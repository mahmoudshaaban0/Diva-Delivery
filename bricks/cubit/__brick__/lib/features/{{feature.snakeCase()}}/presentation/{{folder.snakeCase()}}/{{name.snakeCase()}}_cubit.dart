import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limitless_code_template/features/{{feature.snakeCase()}}/presentation/{{folder.snakeCase()}}/{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> {
  {{name.pascalCase()}}Cubit() : super(const {{name.pascalCase()}}State());
}
