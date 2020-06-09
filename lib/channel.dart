import 'package:lesson11/controller/category_controller.dart';
import 'package:lesson11/database_config.dart';
import 'package:lesson11/model/category.dart';

import 'lesson11.dart';

class Lesson11Channel extends ApplicationChannel {
  ManagedContext context;
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final config = DatabaseConfig(options.configurationFilePath);
    final tables = ManagedDataModel([Category]);
    final dbConnection = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.password);
    context = ManagedContext(tables, dbConnection);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });
    router.route('/about').linkFunction((request) async {
      return Response.ok('About page');
    });
    router.route('/categories/[:id]').link(() => CategoryController());
    return router;
  }
}
