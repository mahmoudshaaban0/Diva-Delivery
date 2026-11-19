import 'package:limitless_code_template/core/networking/api_consumer.dart';
import 'package:limitless_code_template/features/{{name.snakeCase()}}/data/models/{{name.snakeCase()}}_response_model.dart';

class {{name.pascalCase()}}DataSource {
  {{name.pascalCase()}}DataSource(this.apiConsumer);
  final ApiConsumer apiConsumer;

  static const String _endpoint = '/{{name.snakeCase()}}';

  Future<{{name.pascalCase()}}ResponseModel> get{{name.pascalCase()}}() async {
    final response = await apiConsumer.get(_endpoint);
    return {{name.pascalCase()}}ResponseModel.fromJson(
      response as Map<String, dynamic>? ?? {},
    );
  }
}
