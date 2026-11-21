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
import '../../../features/home/data/datasources/home_data_source.dart' as _i607;
import '../../../features/home/data/home_module.dart' as _i860;
import '../../../features/home/data/repositories/home_repository.dart' as _i127;
import '../../../features/home/presentation/bloc/home_cubit.dart' as _i382;
import '../../../features/orders/data/datasources/orders_data_source.dart'
    as _i58;
import '../../../features/orders/data/orders_module.dart' as _i342;
import '../../../features/orders/data/repositories/orders_repository.dart'
    as _i670;
import '../../../features/orders/presentation/bloc/order_details_cubit.dart'
    as _i410;
import '../../../features/orders/presentation/bloc/orders_cubit.dart' as _i659;
import '../../../features/permissions/presentation/bloc/camera_permission_cubit.dart'
    as _i240;
import '../../../features/permissions/presentation/bloc/location_permission_cubit.dart'
    as _i552;
import '../../../features/profile/data/datasources/profile_data_source.dart'
    as _i431;
import '../../../features/profile/data/profile_module.dart' as _i337;
import '../../../features/profile/data/repositories/profile_repository.dart'
    as _i549;
import '../../../features/profile/presentation/bloc/profile_cubit.dart'
    as _i699;
import '../../cubit/locale_cubit.dart' as _i148;
import '../../cubit/theme_cubit.dart' as _i1053;
import '../../networking/api_consumer.dart' as _i685;
import '../../networking/app_intercepters.dart' as _i301;
import '../../networking/dio_consumer.dart' as _i1031;
import '../../networking/network_info.dart' as _i421;
import '../../services/call_service.dart' as _i277;
import '../../services/directions_service.dart' as _i567;
import '../../services/image_picker_service.dart' as _i928;
import '../../services/location_service.dart' as _i537;
import '../../services/permission_service.dart' as _i496;
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
    final homeModule = _$HomeModule();
    final ordersModule = _$OrdersModule();
    final profileModule = _$ProfileModule();
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
    gh.lazySingleton<_i277.CallService>(() => _i277.CallService());
    gh.lazySingleton<_i567.DirectionsService>(() => _i567.DirectionsService());
    gh.lazySingleton<_i928.ImagePickerService>(
      () => _i928.ImagePickerService(),
    );
    gh.lazySingleton<_i537.LocationService>(() => _i537.LocationService());
    gh.lazySingleton<_i496.PermissionService>(() => _i496.PermissionService());
    gh.factory<_i240.CameraPermissionCubit>(
      () => _i240.CameraPermissionCubit(gh<_i496.PermissionService>()),
    );
    gh.factory<_i552.LocationPermissionCubit>(
      () => _i552.LocationPermissionCubit(gh<_i496.PermissionService>()),
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
    gh.lazySingleton<_i607.HomeDataSource>(
      () => homeModule.homeDataSource(
        gh<_i685.ApiConsumer>(),
        gh<_i421.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i58.OrdersDataSource>(
      () => ordersModule.ordersDataSource(
        gh<_i685.ApiConsumer>(),
        gh<_i421.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i431.ProfileDataSource>(
      () => profileModule.profileDataSource(
        gh<_i685.ApiConsumer>(),
        gh<_i421.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i670.OrdersRepository>(
      () => _i670.OrdersRepository(gh<_i58.OrdersDataSource>()),
    );
    gh.factory<_i410.OrderDetailsCubit>(
      () => _i410.OrderDetailsCubit(
        gh<_i670.OrdersRepository>(),
        gh<_i277.CallService>(),
        gh<_i567.DirectionsService>(),
      ),
    );
    gh.factory<_i659.OrdersCubit>(
      () => _i659.OrdersCubit(
        gh<_i670.OrdersRepository>(),
        gh<_i277.CallService>(),
        gh<_i567.DirectionsService>(),
      ),
    );
    gh.lazySingleton<_i960.AuthRepository>(
      () => _i960.AuthRepository(gh<_i118.AuthDataSource>()),
    );
    gh.lazySingleton<_i127.HomeRepository>(
      () => _i127.HomeRepository(gh<_i607.HomeDataSource>()),
    );
    gh.lazySingleton<_i549.ProfileRepository>(
      () => _i549.ProfileRepository(gh<_i431.ProfileDataSource>()),
    );
    gh.factory<_i382.HomeCubit>(
      () => _i382.HomeCubit(
        gh<_i127.HomeRepository>(),
        gh<_i537.LocationService>(),
        gh<_i567.DirectionsService>(),
      ),
    );
    gh.factoryParam<_i989.OtpCubit, String, int?>(
      (phone, resendAfterSeconds) =>
          _i989.OtpCubit(gh<_i960.AuthRepository>(), phone, resendAfterSeconds),
    );
    gh.factory<_i699.ProfileCubit>(
      () => _i699.ProfileCubit(
        gh<_i549.ProfileRepository>(),
        gh<_i496.PermissionService>(),
        gh<_i928.ImagePickerService>(),
      ),
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

class _$HomeModule extends _i860.HomeModule {}

class _$OrdersModule extends _i342.OrdersModule {}

class _$ProfileModule extends _i337.ProfileModule {}
