import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/config/di/injectable.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies() => getIt.init();
