import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/constants/env.dart';
import 'package:limitless_code_template/core/cubit/locale_cubit.dart';
import 'package:limitless_code_template/core/cubit/theme_cubit.dart';
import 'package:limitless_code_template/core/networking/app_intercepters.dart';
import 'package:limitless_code_template/core/networking/network_info.dart';
import 'package:limitless_code_template/core/storage/key_value_storage.dart';
import 'package:limitless_code_template/core/storage/shared_pref_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class CoreInjectableModule {
  String get envBaseUrl => Env.baseUrl;

  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage secureStorage() => const FlutterSecureStorage();

  @lazySingleton
  Connectivity connectivity() => Connectivity();

  @lazySingleton
  AppInterceptors appInterceptors() => AppInterceptors();

  @lazySingleton
  PrettyDioLogger prettyDioLogger() => PrettyDioLogger(
    requestBody: true,
    responseHeader: true,
    requestHeader: true,
  );

  @singleton
  Dio dio(AppInterceptors appInterceptors, PrettyDioLogger prettyDioLogger) {
    final dio = Dio(
      BaseOptions(
        baseUrl: envBaseUrl,
        sendTimeout: const Duration(seconds: 45),
        connectTimeout: const Duration(seconds: 45),
      ),
    );
    dio.interceptors.add(appInterceptors);
    dio.interceptors.addAll([if (kDebugMode) prettyDioLogger]);
    return dio;
  }

  @lazySingleton
  KeyValueStorage keyValueStorage(SharedPreferences prefs) =>
      SharedPrefStorage(prefs);

  @lazySingleton
  ThemeCubit themeCubit(KeyValueStorage storage) => ThemeCubit(storage);

  @lazySingleton
  LocaleCubit localeCubit(KeyValueStorage storage) => LocaleCubit(storage);

  @lazySingleton
  NetworkInfo networkInfo() => NetworkInfoImpl();
}
