import 'package:limitless_code_template/core/error/exceptions.dart';
import 'package:limitless_code_template/core/networking/result.dart';
import 'package:limitless_code_template/core/utility/logger.dart';
import 'package:limitless_code_template/features/{{name.snakeCase()}}/data/datasources/{{name.snakeCase()}}_data_source.dart';
import 'package:limitless_code_template/features/{{name.snakeCase()}}/data/models/{{name.snakeCase()}}_response_model.dart';

class {{name.pascalCase()}}Repository {
  {{name.pascalCase()}}Repository(this.{{name.camelCase()}}DataSource);
  final {{name.pascalCase()}}DataSource {{name.camelCase()}}DataSource;

  /// Never throws: returns [Success] with the data or [Error] with the
  /// exception (a [ServerException] subclass).
  Future<Result<{{name.pascalCase()}}ResponseModel>> get{{name.pascalCase()}}() async {
    try {
      final data = await {{name.camelCase()}}DataSource.get{{name.pascalCase()}}();
      return Success(data);
    } on ServerException catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return Error(e);
    } on FormatException catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return const Error(BadRequestException('Invalid data received from server.'));
    } on Exception catch (e, st) {
      AppLogger.instance.logError('$e\n$st');
      return Error(ServerException(e.toString()));
    }
  }
}
