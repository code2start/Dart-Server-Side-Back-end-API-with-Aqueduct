import 'package:aqueduct/aqueduct.dart';

class Backend2Channel extends ApplicationChannel {
  @override
  Controller get entryPoint {
    final router = Router();
    router
        .route('/hello')
        .linkFunction((request) => Response.ok('hello to aqueduct framework'));
    router
        .route('/courses')
        .linkFunction((request) => Response.ok("Here show all courses"));
    return router;
  }
}
