import 'package:lesson11/controller/category_controller.dart';

import 'lesson11.dart';

class Lesson11Channel extends ApplicationChannel {
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/example").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    router.route('/about').linkFunction((request) async {
      return Response.ok('This about page');
    });

    router.route('/categories/[:id]').link(() => CategoryController());
    return router;
  }
}
