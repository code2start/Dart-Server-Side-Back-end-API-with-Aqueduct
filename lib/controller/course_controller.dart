import 'package:lesson3/lesson3.dart';

class CourseController extends Controller {
  final List _courses = [
    {'id': 1, 'name': 'Dart Programming'},
    {'id': 2, 'name': 'PHP Programming'},
    {'id': 3, 'name': 'Flutter Mobile'},
    {'id': 4, 'name': 'ASP.net'},
  ];
  @override
  FutureOr<RequestOrResponse> handle(Request request) {
    switch (request.method) {
      case 'GET':
        return Response.ok(_courses);

        break;
      case 'POST':
        return Response.ok('POST Method');
        break;
      case 'PUT':
        return Response.ok('PUT Method');
        break;
      case 'DELETE':
        return Response.ok('DELETE Method');
        break;
      default:
        return Response.ok('undefined');
        break;
    }
  }
}
