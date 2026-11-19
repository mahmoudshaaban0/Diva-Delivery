import 'package:limitless_code_template/core/cubit/base_state.dart';

class {{name.pascalCase()}}State extends BaseState<{{name.pascalCase()}}State> {
  const {{name.pascalCase()}}State({super.status, super.errorMessage});

  @override
  {{name.pascalCase()}}State copyWith({AppStatus? status, String? errorMessage}) {
    return {{name.pascalCase()}}State(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
