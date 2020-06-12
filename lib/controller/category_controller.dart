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
      ..join(set: (c) => c.products)
      ..where((c) => c.id).equalTo(id);
    final products = await q.fetch();
    return Response.ok(products);
  }

  @Operation.post()
  Future<Response> createCategory(
      @Bind.body(ignore: ['id']) Category category) async {
    final q = Query<Category>(context)..values = category;
    final insertedCategory = await q.insert();
    return Response.ok(insertedCategory);
  }

  @Operation.put('id')
  Future<Response> updateCategory(
      @Bind.path('id') int id, @Bind.body() Category category) async {
    final q = Query<Category>(context)
      ..where((c) => c.id).equalTo(id)
      ..values = category;
    final updatedCategory = await q.updateOne();
    return Response.ok(updatedCategory);
  }

  @Operation.delete('id')
  Future<Response> deleteCategory(@Bind.path('id') int id) async {
    final q = Query<Category>(context)..where((c) => c.id).equalTo(id);
    final affected = await q.delete();
    return Response.ok({'message': 'There are $affected category removed'});
  }
}
