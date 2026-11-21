# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Toolchain

- Flutter is pinned with FVM (`.fvmrc` → 3.47.7; VS Code points at `.fvm/versions/3.47.7`). Prefix commands with `fvm` (e.g. `fvm flutter ...`) so the pinned SDK is used.
- Lints: `very_good_analysis` (strict) with a few rules relaxed in `analysis_options.yaml` (`public_member_api_docs`, `avoid_positional_boolean_parameters`, `unnecessary_type_name_in_constructor`). Formatter page width is 80.

## Commands

```bash
fvm flutter pub get
fvm flutter analyze
fvm dart format lib test

# Run: a flavor is REQUIRED (main.dart looks up the Flavor enum from `appFlavor`
# and throws without one). Env values come from a JSON file per flavor.
fvm flutter run --flavor dev --dart-define-from-file=env/dev.json
fvm flutter run --flavor prod --dart-define-from-file=env/prod.json

# Tests (test/ is currently empty; mockito is available)
fvm flutter test
fvm flutter test test/path/to/file_test.dart --plain-name "test name"

# Code generation (json_serializable models, mockito mocks)
fvm dart run build_runner build --delete-conflicting-outputs

# Localization: regenerates lib/l10n/app_localizations*.dart from the .arb files
fvm flutter gen-l10n

# Flavor native config is generated from flavorizr.yaml
fvm dart run flutter_flavorizr
```

- Only `env/example.json` exists (`BASE_URL` plus the API endpoint keys). Create `env/dev.json` / `env/prod.json` from it. `Env.baseUrl` (`lib/core/constants/env.dart`) is empty if no file is passed. The VS Code launch configs in `.vscode/launch.json` pass `--flavor` but not `--dart-define-from-file`.

## Scaffolding with Mason

New code should be generated from the local bricks in `bricks/` (registered in `mason.yaml`), run from the project root:

- `mason make feature` – full feature: data source, response model, repository, cubit + state, screen under `lib/features/<name>/`.
- `mason make screen` – screen in an existing feature. Its `post_gen` hook also adds an entry to the `AppRoutes` enum and a `GoRoute` in `AppRouter`.
- `mason make cubit` / `mason make bloc` – added to `lib/features/<feature>/presentation/<folder>/` (default folder `bloc`).

Bricks do **not** register anything in get_it. Add new data sources, repositories and cubits to `lib/core/config/dependency_injection/injection_container.dart` yourself. If you change a pattern below, update the matching brick template too.

## Architecture

Feature-first layout: `lib/features/<feature>/{data/{datasources,models,repositories},presentation/{bloc,screens}}`, with shared infrastructure in `lib/core/`.

**Startup** (`main.dart` → `app.dart`): set `F.appFlavor` from `--flavor`, install `MyBlocObserver`, `await init()` (get_it setup, global `sl`), then `AppTemplate` provides the app-wide `ThemeCubit` and `LocaleCubit` (lazy singletons, saved through `KeyValueStorage`) and builds `MaterialApp.router` with `AppRouter.router` (go_router, routes named by the `AppRoutes` enum).

**Data flow / error handling** (follow the feature brick):
1. `DataSource` calls `ApiConsumer` (`DioConsumer`: base URL from `Env`, `AppInterceptors`, `PrettyDioLogger` in debug). Status codes below 500 don't throw in Dio. `DioConsumer` turns `DioException`s into `ServerException` subclasses (`lib/core/error/exceptions.dart`).
2. `Repository` never throws. It returns the sealed `Result<T>` (`Success` / `Error`, in `lib/core/networking/result.dart`), catches `ServerException` / `FormatException` / `Exception`, and logs through `AppLogger.instance`.
3. Cubit state extends `BaseState<T>` (`AppStatus` initial/loading/success/failure + `errorMessage`, Equatable, `copyWith`). Cubits `switch` on `Result` with pattern matching.

**Data layer rules**:
- API endpoint paths live in the env files, not in code. Add each key to `env/example.json` (and the flavor files), expose it as a `String.fromEnvironment` constant on `Env` (`lib/core/constants/env.dart`), and use it as `Env.sendOtpEndpoint`. No `static const _endpoint` strings in data sources.
- All exceptions live in `lib/core/error/exceptions.dart` (extend `ServerException` or one of its subclasses). Don't create per-feature exception files.
- No private helper methods in data sources or repositories (`_unwrap`, `_asMap`, `_guard`). Write the response parsing, and the brick's `try`/`on ServerException`/`on FormatException`/`on Exception` block, inside each method, even though it repeats.

**Cubit state rules**: every cubit state extends `BaseState<T>` (generate it with `mason make cubit`). Emit only through `state.copyWith(...)`. Don't construct a fresh state in `emit(...)`, and don't add private helpers like `_failure()`. Map errors inline in the `switch` on `Result`, exactly like the feature brick does.

**Screen and widget rules**:
- No helper methods or functions in screens: no `Widget _buildX()`, no top-level helper functions, no getters that format data. Screens only compose widgets and hold screen logic (controllers, submit and listener handlers).
- Every piece of UI a screen uses is its own public widget class in its own file under `lib/features/<feature>/presentation/widgets/`, named with the feature prefix (e.g. `LoginPhoneField`, `OtpResendTimer`). Don't use private `_Widget` classes inside the screen file.
- Anything used by more than one feature belongs in the design system as an atom, molecule or organism (`lib/core/design_system/{atoms,molecules,organisms}/`), not in a feature folder.
- Data formatting (phone numbers, dates, digits) belongs in `lib/core/formatters/`, not in widgets or screens.
- Every regular expression lives in `AppRegex` (`lib/core/constants/app_regex.dart`), e.g. `AppRegex.saudiMobile.hasMatch(value)`. Don't declare `RegExp` fields inside widgets, formatters or other classes.
- For spacing use the gap widgets from `tokens/app_spacing.dart` (`gapH4`…`gapH24`, `gapW4`…`gapW24`, scaled getters, not `const`), or `16.vs` / `16.hs` for other values. No `SizedBox(height: …)` / `SizedBox(width: …)` spacers.
- Phone number field only: `AppTextField(alignLeft: true)` starts the cursor and text at the left in both languages, and `+966` always sits on the physical left (`LoginCountryCode`). Other Latin inputs (email, password) use `ltrInput: true`: typed LTR but aligned to the reading start, so in Arabic they sit on the right next to the icon, like the design.
- Read theme and strings inline at each use: `context.colors.textTitle`, `context.typography.bodyS`, `context.localizations.signIn`. Don't cache them in locals (`final colors = context.colors;`, `final l10n = ...`, `final typography = ...`).

**Design system** (`lib/core/design_system/`, atomic layout):
- `tokens/`: `AppColors` and `AppTypography` are `ThemeExtension`s with light/dark variants and `lerp` (the theme change is animated), plus spacing/insets/radius/shadows. Read them with `context.colors` and `context.typography` (`lib/core/utility/extensions.dart`), not hard-coded colors or `Theme.of(context).textTheme`.
- `atoms/` (e.g. `AppText`, which defaults to `typography.bodyM` and takes a `color`, buttons, text field, images) and `organisms/` (bottom sheet, empty/error states). Use these over raw Material widgets.
- `responsive.dart`: `ResponsiveScope` (placed in `MaterialApp.builder`) updates `SizeConfig` against a 375×812 design frame. Size with the `num` extensions `.w .h .r .sp .sw .sh` and the `.vs` / `.hs` spacer widgets. Scale factors are clamped. See `docs/responsive_explained.pdf`.
  - Tokens built from `.w/.h/.r/.sp` must be **getters**, not `static`/top-level fields (fields are computed once and go stale on rotation/resize).
  - Padding: use `AppInsets` (`only(start:, end:, top:, bottom:)`, `symmetric(horizontal:, vertical:)`, `all()`), which applies `.w` to horizontal, `.h` to vertical and `.r` to all-sides values. No raw `EdgeInsets(...)` with unscaled numbers. Spacing: `Row(spacing: 12.w)`, `Column(spacing: 16.h)`, or the `gapW*` / `gapH*` widgets.
  - Text: `context.typography` already returns styles scaled with `.sp` (`AppTypography.scaled`). Never apply `.sp` to those styles again.
  - Don't scale fixed component sizes (button height, borders, dividers). The button atoms use a fixed 46 height, and expanded buttons are capped at 400 wide and centered.

**Toasts**: show short messages with `context.showToast(...)` (`organisms/app_toast.dart`, Figma `Courier/Toast`). A "no connection" failure (state `isOffline`, set when the cubit gets `NoInternetConnectionException`) uses `iconAsset: Assets.vectorsIcWifiOff20` plus a retry action. On screens with a pinned footer, pass `bottomMargin: AppToast.aboveFooterMargin` (or the footer's own clearance, e.g. `LoginFooter.toastClearance`).

**Device permissions**: go through `PermissionService` (`lib/core/services/`, wraps `permission_handler`), never `permission_handler` directly in cubits or widgets. A new permission also needs its Android `<uses-permission>` in `android/app/src/main/AndroidManifest.xml`, and its iOS usage string in `ios/Runner/Info.plist`. iOS plugins build with Swift Package Manager here, so `permission_handler_apple` enables a permission from the `Info.plist` key alone (the `ios/Podfile` macros only matter if the project goes back to CocoaPods). Xcode caches that decision: after adding a key, run `rm -rf ~/Library/Developer/Xcode/DerivedData` and rebuild, or the permission stays compiled out (requests return denied without a prompt, and "Open settings" lands on the main Settings screen). Onboarding order after sign-in: location (required) → camera & photos (optional) → home. "Already granted, skip this step" is an async `redirect` on the route in `AppRouter` (checked before the screen is built), never a status check in the screen or cubit, which would flash the screen for a moment.

**Reusable pieces from Flow 02** (use these, don't rebuild them):
- Bottom sheets: `showAppBottomSheet(size: AppSheetSize.wrap, child: AppStatusSheet(...))` (Figma `Courier/Bottom Sheet`: status icon, title, text, optional content, two actions).
- `AppSwipeButton` (swipe-to-confirm, idle / checking / disabled; idle has a soft "slide to answer" shine), `AppStatusPill`, `AppDot`.
- Motion: keep it subtle and readable, and respect "reduce motion" (`MediaQuery.disableAnimationsOf`). `AppDot(pulse: true)` / `AppStatusPill(pulse: true)` only for live or attention states (in range, day started, new orders waiting), never for plain legend dots. Repeating animations never settle, so widget tests must use `pump(duration)`, not `pumpAndSettle`.
- Tabs (Home · Orders · Profile) use `persistent_bottom_nav_bar_v2` with go_router: a `StatefulShellRoute.indexedStack` in `AppRouter` builds `MainShell` (`lib/core/routing/main_shell.dart`, `PersistentTabView.router`), and `AppBottomNav` is its `navBarBuilder`: our own Figma-style bar (icon over label on every tab, soft pill on the active one; the pill slides and colors cross-fade when switching). Don't use the package's `StyleXBottomNavBar` styles: they don't match Figma and overflow. Build tab items with `AppBottomNav.item(context, ...)` so colors come from the theme, never a raw `ItemConfig`. One `StatefulShellBranch` per tab, same order as the tabs. A tab's inner screens go as sub-routes of its branch (nav bar stays visible); full-screen flows stay top-level routes. Tab screens don't add their own bottom bar.
- Money: `AppPrice(amount: …)` draws the riyal symbol left of the number (Figma `Icon/Riyal`). Numbers and dates show Western digits in both languages: use `AmountFormatter` and `DateFormatter.formatDayAndDate` / `formatTime`, never a raw `NumberFormat` / `DateFormat`.
- Location and maps: `LocationService` (current position, distance) and `DirectionsService` (open the maps app) in `lib/core/services/`.

**Reusable pieces from Flow 07** (use these, don't rebuild them):
- `AppPageHeader` (organism, Figma `Courier/Page Header`): title + description, optional back button (`onBack`). Inner full-screen screens pass `onBack: () => context.pop()`.
- Settings lists: `AppMenuGroup` holding `AppMenuRow`s (icon box, title, optional value + chevron, `destructive` red variant).
- Read-only details: `AppInfoCard` holding `AppInfoRow`s (label / value, `onCopy`). `AppInfoBanner` is the blue info banner. `AppRadioRow` is a single-choice pill.
- Pickers (`LanguageScreen`, `ThemeScreen`): a column of `AppRadioRow`s plus a "Save" button in `AppFooterBar`, disabled until the selection differs from the current value. Saving calls the cubit (`LocaleCubit.setLocale` / `ThemeCubit.setThemeMode`) and pops.
- `AppFooterBar` (organism): a pinned footer with a top hairline, used as `Scaffold.bottomNavigationBar`.
- `AppStatusSheet`:
  - `iconAsset` and the primary action are optional.
  - `primaryVariant: AppFilledVariant.red` makes the primary action red (destructive confirms).
  - `isPrimaryLoading` shows a spinner on the primary action while its request runs.
- `AppStatusPill(size: AppStatusPillSize.medium)` is the bigger pill.
- Formatters:
  - `LtrFormatter.isolate` / `.code` keeps Latin codes, phone numbers and emails in order inside Arabic text.
  - `NameFormatter.initials` builds avatar initials and skips the Arabic article "ال".
  - `DateFormatter.formatMonthYear` formats month and year.
- Photos: `ImagePickerService` (`lib/core/services/`, wraps `image_picker`). `PermissionService.locationAccess()` returns always / while in use / denied.

**Loading skeletons**: content that's loading shows a shimmer skeleton (`shimmer` package), never a centered `CircularProgressIndicator`. Wrap a layout of `AppSkeletonBox`es (`atoms/app_skeleton_box.dart`, `.circle` for avatars) in `AppSkeleton` (`atoms/app_skeleton.dart`, theme colors, sweeps in the reading direction). Each screen gets its own `<Feature>Skeleton` widget that mirrors the real layout (e.g. `HomeSkeleton`). Spinners stay only inside buttons (`AppFilledButton(isLoading: true)`) and the swipe button's checking state.

**OTP input**: use `AppOtpField` (molecule wrapping `pinput`). Keep `pinput` on **6.x**: 7.x is built on the decoupled `material_ui` package and crashes under the framework's `Scaffold`. SMS autofill works through `oneTimeCode` on iOS and `SmsCodeRetriever` (`lib/core/utility/`, `smart_auth` SMS User Consent API) on Android.

**Assets**: put files under `assets/{vectors,rasters,lotties,fonts}/`, then regenerate `lib/core/constants/assets.dart` with the VS Code extension "Flutter Assets Gen" (F1 → `Flutter Assets: Generate`, configured by `flutter_assets:` in `pubspec.yaml`). Don't edit that file by hand. Fields are named `<folder><FileName>` (e.g. `Assets.vectorsIcClock16`). `assets/vectors/` goes through the `vector_graphics_compiler` transformer, so it may only contain `.svg` files. Draw single-color icons with `AppSvgIcon` (tinted from the theme).

**Localization**: English (template `app_en.arb`) and Arabic (RTL) in `lib/l10n/`. Getters are non-nullable. Read strings with `context.localizations`. `Intl.defaultLocale` follows the active locale, so `DateFormat`/`NumberFormat` (`lib/core/formatters/`) use the app language.
