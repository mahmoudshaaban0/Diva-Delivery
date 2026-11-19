import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  final logger = context.logger;
  final feature = _snake(context.vars['feature'] as String);
  final name = context.vars['name'] as String;
  final snake = _snake(name);
  final pascal = _pascal(name);
  final camel = pascal[0].toLowerCase() + pascal.substring(1);
  var path = (context.vars['path'] as String).trim();
  if (path.isEmpty) path = '/${snake.replaceAll('_', '-')}';
  if (!path.startsWith('/')) path = '/$path';

  final routesFile = File('lib/core/routing/app_routes.dart');
  final routerFile = File('lib/core/routing/app_router.dart');
  if (!routesFile.existsSync() || !routerFile.existsSync()) {
    logger.warn('Routing files not found (run from the project root). '
        'Screen created but route NOT registered.');
    return;
  }

  // ---- AppRoutes enum -------------------------------------------------
  var routes = routesFile.readAsStringSync();
  if (RegExp('\\b$camel\\(').hasMatch(routes)) {
    logger.warn('AppRoutes.$camel already exists - skipping route registration.');
    return;
  }
  final ctor = RegExp(r';(\s*\n\s*AppRoutes\()');
  if (!ctor.hasMatch(routes)) {
    logger.warn('Could not find AppRoutes constructor - route NOT registered.');
    return;
  }
  routes = routes.replaceFirstMapped(
    ctor,
    (m) => ",\n  $camel('$path', '$camel');${m[1]}",
  );
  routesFile.writeAsStringSync(routes);

  // ---- AppRouter ------------------------------------------------------
  var router = routerFile.readAsStringSync();
  final importLine =
      "import 'package:limitless_code_template/features/$feature/presentation/screens/${snake}_screen.dart';";
  final closing = RegExp(r'\n    \],\n  \);');
  if (!closing.hasMatch(router)) {
    logger.warn('Could not find routes list in AppRouter - add GoRoute manually.');
    return;
  }
  final goRoute = '''
      GoRoute(
        name: AppRoutes.$camel.name,
        path: AppRoutes.$camel.path,
        builder: (context, state) => const ${pascal}Screen(),
      ),''';
  router = router.replaceFirstMapped(closing, (m) => '\n$goRoute${m[0]}');
  // Insert import keeping imports sorted alphabetically.
  final lines = router.split('\n');
  final imports = <int>[
    for (var i = 0; i < lines.length; i++)
      if (lines[i].startsWith('import ')) i,
  ];
  var at = imports.last + 1;
  for (final i in imports) {
    if (lines[i].compareTo(importLine) > 0) {
      at = i;
      break;
    }
  }
  lines.insert(at, importLine);
  routerFile.writeAsStringSync(lines.join('\n'));

  Process.runSync('dart', [
    'format',
    routesFile.path,
    routerFile.path,
  ]);
  logger.success('Registered AppRoutes.$camel ($path) in AppRouter.');
}

List<String> _words(String s) => s
    .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]} ${m[2]}')
    .split(RegExp(r'[\s_\-]+'))
    .where((w) => w.isNotEmpty)
    .toList();

String _snake(String s) => _words(s).map((w) => w.toLowerCase()).join('_');

String _pascal(String s) => _words(s)
    .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
    .join();
