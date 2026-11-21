/// Keeps Latin values (codes, phone numbers, emails) in left-to-right order
/// inside Arabic text, so `#DRV-0142` doesn't render as `DRV-0142#` and
/// `+966 55 …` keeps its plus sign in front.
abstract final class LtrFormatter {
  static const _isolateStart = '\u2066'; // LEFT-TO-RIGHT ISOLATE
  static const _isolateEnd = '\u2069'; // POP DIRECTIONAL ISOLATE

  static String isolate(String value) => '$_isolateStart$value$_isolateEnd';

  /// `DRV-0142` → `#DRV-0142` (isolated).
  static String code(String value) => isolate('#$value');
}
