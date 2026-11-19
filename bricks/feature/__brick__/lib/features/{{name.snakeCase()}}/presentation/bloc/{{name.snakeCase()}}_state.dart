import 'package:limitless_code_template/core/cubit/base_state.dart';
import 'package:limitless_code_template/features/{{name.snakeCase()}}/data/models/{{name.snakeCase()}}_response_model.dart';

class {{name.pascalCase()}}State extends BaseState<{{name.pascalCase()}}State> {
  const {{name.pascalCase()}}State({
    super.status,
    super.errorMessage,
    this.{{name.camelCase()}},
  });

  final {{name.pascalCase()}}ResponseModel? {{name.camelCase()}};

  @override
  {{name.pascalCase()}}State copyWith({
    AppStatus? status,
    String? errorMessage,
    {{name.pascalCase()}}ResponseModel? {{name.camelCase()}},
  }) {
    return {{name.pascalCase()}}State(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      {{name.camelCase()}}: {{name.camelCase()}} ?? this.{{name.camelCase()}},
    );
  }

  @override
  List<Object?> get props => [...super.props, {{name.camelCase()}}];
}
