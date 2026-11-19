import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:limitless_code_template/core/networking/network_info.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.networkInfo) : super(HomeInitial());
  final NetworkInfo networkInfo;
}
