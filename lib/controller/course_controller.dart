import 'package:lesson3/lesson3.dart';

class CourseController extends ResourceController {
  final List _courses = [
    {'id': 1, 'name': 'Dart Programming'},
    {'id': 2, 'name': 'PHP Course'},
    {'id': 3, 'name': 'Flutter Course'},
    {'id': 4, 'name': 'Laravel Course'},
  ];
  CourseController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCourses() async {
    return Response.ok(_courses);
  }

  @Operation.get('id')
  Future<Response> getCourseById(@Bind.path('id') int id) async {
    //final id = int.parse(request.path.variables['id']);
    final course =
        _courses.firstWhere((item) => item['id'] == id, orElse: () => null);
    if (course == null) {
      Response.notFound();
    }
    return Response.ok(course);
  }
}
