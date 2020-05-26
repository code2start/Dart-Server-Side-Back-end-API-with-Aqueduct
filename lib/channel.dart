import 'package:lesson3/controller/course_controller.dart';

import 'lesson3.dart';

class Lesson3Channel extends ApplicationChannel {
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

    //router.route('/courses').linkFunction((request) => Response.ok(_courses));
    router.route('/courses').link(() => CourseController());

    return router;
  }
}
