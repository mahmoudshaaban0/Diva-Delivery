import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/features/{{name.snakeCase()}}/data/repositories/{{name.snakeCase()}}_repository.dart';
import 'package:limitless_code_template/features/{{name.snakeCase()}}/presentation/bloc/{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> {
  {{name.pascalCase()}}Cubit(this._{{name.camelCase()}}Repository) : super(const {{name.pascalCase()}}State());

  final {{name.pascalCase()}}Repository _{{name.camelCase()}}Repository;

  Future<void> get{{name.pascalCase()}}() async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await _{{name.camelCase()}}Repository.get{{name.pascalCase()}}();
    switch (result) {
      case Success(:final data):
        emit(state.copyWith(status: AppStatus.success, {{name.camelCase()}}: data));
      case Error(:final exception):
        emit(
          state.copyWith(
            status: AppStatus.failure,
            errorMessage: exception is ServerException
                ? exception.message
                : exception.toString(),
          ),
        );
    }
  }
}
