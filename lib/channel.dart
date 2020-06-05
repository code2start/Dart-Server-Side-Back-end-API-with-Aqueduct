import 'package:lesson3/controller/course_controller.dart';

import 'lesson3.dart';

class Lesson3Channel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final config = CoursesConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);
    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    //router.route('/courses').linkFunction((request) => Response.ok(_courses));
    router.route('/courses/[:id]').link(() => CourseController(context));

    return router;
  }
}

class CoursesConfig extends Configuration {
  CoursesConfig(String path) : super.fromFile(File(path));
  DatabaseConfiguration database;
}
