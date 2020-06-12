import 'package:lesson11/lesson11.dart';
import 'package:lesson11/model/product.dart';

class ProductController extends ResourceController {
  ProductController(this.context);
  ManagedContext context;

  @Operation.get()
  Future<Response> getAllProducts() async {
    final q = Query<Product>(context);
    final products = await q.fetch();
    return Response.ok(products);
  }

  @Operation.get('id')
  Future<Response> getProductById(@Bind.path('id') int id) async {
    final q = Query<Product>(context)..where((p) => p.id).equalTo(id);
    final product = await q.fetchOne();
    if (product == null) {
      return Response.notFound();
    }
    return Response.ok(product);
  }

  @Operation.post()
  Future<Response> createProduct(
      @Bind.body(ignore: ['id']) Product product) async {
    final q = Query<Product>(context)..values = product;
    //insert int products (,,,) value
    final insertedProduct = await q.insert();
    return Response.ok(insertedProduct);
  }

  @Operation.put('id')
  Future<Response> updateProduct(
      @Bind.path('id') int id, @Bind.body() Product product) async {
    final q = Query<Product>(context)..where((p) => p.id).equalTo(id);
    final selectedProduct = await q.fetchOne();
    if (selectedProduct != null) {
      q.values = product;
      final updatedProduct = await q.update();
      return Response.ok(updatedProduct);
    }
    return Response.notFound();
  }

  @Operation.delete('id')
  Future<Response> deleteProduct(@Bind.path('id') int id) async {
    final q = Query<Product>(context)..where((p) => p.id).equalTo(id);
    final affectedRows = await q.delete();
    return Response.ok({'message': 'there is $affectedRows product removed'});
  }
}
