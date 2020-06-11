import 'package:lesson11/controller/category_controller.dart';
import 'package:lesson11/controller/product_controller.dart';
import 'package:lesson11/db_config.dart';
import 'package:lesson11/model/category.dart';
import 'package:lesson11/model/product.dart';

import 'lesson11.dart';

class Lesson11Channel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final dbConf = DbConfig(options.configurationFilePath);
    final tables = ManagedDataModel([Category, Product]);
    final dbConnection = PostgreSQLPersistentStore.fromConnectionInfo(
        dbConf.database.username,
        dbConf.database.password,
        dbConf.database.host,
        dbConf.database.port,
        dbConf.database.databaseName);
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
    router.route('/categories/[:id]').link(() => CategoryController(context));
    router
        .route('/categories/:categoryId/products')
        .link(() => CategoryController(context));
    router.route('/products/[:id]').link(() => ProductController(context));
    return router;
  }
}
