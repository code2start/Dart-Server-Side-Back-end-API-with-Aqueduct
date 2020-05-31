import 'package:lesson3/controller/model/course.dart';
import 'package:lesson3/lesson3.dart';

class CourseController extends ResourceController {
  CourseController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCourses({@Bind.query('name') String name}) async {
    final courseQuery = Query<Course>(context);
    if (name != null) {
      courseQuery.where((c) => c.name).contains(name, caseSensitive: false);
    }
    final courses = await courseQuery.fetch();
    return Response.ok(courses);
  }

  @Operation.get('id')
  Future<Response> getCourseById(@Bind.path('id') int id) async {
    final courseQuery = Query<Course>(context)..where((c) => c.id).equalTo(id);
    final course = await courseQuery.fetchOne();
    if (course == null) {
      return Response.notFound();
    }
    return Response.ok(course);
  }
}
