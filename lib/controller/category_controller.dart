import 'package:lesson11/lesson11.dart';

class CategoryController extends ResourceController {
  @Operation.get()
  Future<Response> getAllCategories() async {
    return Response.ok('All Categories');
  }

  @Operation.get('id')
  Future<Response> getCategoryById(@Bind.path('id') int id) async {
    return Response.ok('select category with id $id');
  }
}
