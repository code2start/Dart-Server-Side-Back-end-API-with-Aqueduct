import 'package:lesson11/lesson11.dart';
import 'package:lesson11/model/category.dart';

class CategoryController extends ResourceController {
  CategoryController(this.context);
  ManagedContext context;
  @Operation.get()
  Future<Response> getAllCategories() async {
    final q = Query<Category>(context);
    final categories = await q.fetch();
    return Response.ok(categories);
  }

  @Operation.get('id')
  Future<Response> getCategoryById(@Bind.path('id') int id) async {
    final q = Query<Category>(context)..where((c) => c.id).equalTo(id);
    final category = await q.fetchOne();
    return Response.ok(category);
  }

  @Operation.get('categoryId')
  Future<Response> getAllProductsByCategoryId(
      @Bind.path('categoryId') int id) async {
    final q = Query<Category>(context)
      ..where((c) => c.id).equalTo(id)
      ..join(set: (c) => c.products);
    final products = await q.fetch();
    return Response.ok(products);
  }
}
