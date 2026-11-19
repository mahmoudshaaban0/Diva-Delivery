// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../../features/auth/data/auth_module.dart' as _i124;
import '../../../features/auth/data/datasources/auth_data_source.dart' as _i118;
import '../../../features/auth/data/repositories/auth_repository.dart' as _i960;
import '../../../features/auth/presentation/bloc/forgot_password_cubit.dart'
    as _i690;
import '../../../features/auth/presentation/bloc/login_cubit.dart' as _i618;
import '../../../features/auth/presentation/bloc/otp_cubit.dart' as _i989;
import '../../../features/home/presentation/cubit/home_cubit.dart' as _i893;
import '../../cubit/locale_cubit.dart' as _i148;
import '../../cubit/theme_cubit.dart' as _i1053;
import '../../networking/api_consumer.dart' as _i685;
import '../../networking/app_intercepters.dart' as _i301;
import '../../networking/dio_consumer.dart' as _i1031;
import '../../networking/network_info.dart' as _i421;
import '../../storage/key_value_storage.dart' as _i291;
import 'register_module.dart' as _i292;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final coreInjectableModule = _$CoreInjectableModule();
    final authModule = _$AuthModule();
    gh.factory<String>(() => coreInjectableModule.envBaseUrl);
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => coreInjectableModule.prefs(),
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => coreInjectableModule.secureStorage(),
    );
    gh.lazySingleton<_i895.Connectivity>(
      () => coreInjectableModule.connectivity(),
    );
    gh.lazySingleton<_i301.AppInterceptors>(
      () => coreInjectableModule.appInterceptors(),
    );
    gh.lazySingleton<_i528.PrettyDioLogger>(
      () => coreInjectableModule.prettyDioLogger(),
    );
    gh.lazySingleton<_i421.NetworkInfo>(
      () => coreInjectableModule.networkInfo(),
    );
    gh.singleton<_i361.Dio>(
      () => coreInjectableModule.dio(
        gh<_i301.AppInterceptors>(),
        gh<_i528.PrettyDioLogger>(),
      ),
    );
    gh.factory<_i685.ApiConsumer>(
      () => _i1031.DioConsumer(client: gh<_i361.Dio>()),
    );
    gh.factory<_i893.HomeCubit>(() => _i893.HomeCubit(gh<_i421.NetworkInfo>()));
    gh.lazySingleton<_i291.KeyValueStorage>(
      () => coreInjectableModule.keyValueStorage(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i1053.ThemeCubit>(
      () => coreInjectableModule.themeCubit(gh<_i291.KeyValueStorage>()),
    );
    gh.lazySingleton<_i148.LocaleCubit>(
      () => coreInjectableModule.localeCubit(gh<_i291.KeyValueStorage>()),
    );
    gh.lazySingleton<_i118.AuthDataSource>(
      () => authModule.authDataSource(
        gh<_i685.ApiConsumer>(),
        gh<_i421.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i960.AuthRepository>(
      () => _i960.AuthRepository(gh<_i118.AuthDataSource>()),
    );
    gh.factoryParam<_i989.OtpCubit, String, int?>(
      (phone, resendAfterSeconds) =>
          _i989.OtpCubit(gh<_i960.AuthRepository>(), phone, resendAfterSeconds),
    );
    gh.factory<_i690.ForgotPasswordCubit>(
      () => _i690.ForgotPasswordCubit(gh<_i960.AuthRepository>()),
    );
    gh.factory<_i618.LoginCubit>(
      () => _i618.LoginCubit(gh<_i960.AuthRepository>()),
    );
    return this;
  }
}

class _$CoreInjectableModule extends _i292.CoreInjectableModule {}

class _$AuthModule extends _i124.AuthModule {}
