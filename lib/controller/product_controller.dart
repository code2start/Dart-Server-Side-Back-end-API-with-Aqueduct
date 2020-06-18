import 'package:lesson11/lesson11.dart';
import 'package:lesson11/model/product.dart';
import 'package:aqueduct/aqueduct.dart';
import 'package:mime/mime.dart';
import 'package:http_server/http_server.dart';

class ProductController extends ResourceController {
  ProductController(this.context) {
    acceptedContentTypes = [ContentType("multipart", "form-data")];
  }
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

  /*  @Operation.post()
  Future<Response> createProduct(
      @Bind.body(ignore: ['id']) Product product) async {
    final q = Query<Product>(context)..values = product;
    final insertedProduct = await q.insert();
    return Response.ok(insertedProduct);
  } */

  @Operation.put('id')
  Future<Response> updateProduct(
      @Bind.path('id') int id, @Bind.body() Product product) async {
    final q = Query<Product>(context)
      ..where((p) => p.id).equalTo(id)
      ..values = product;
    final updatedProduct = await q.updateOne();
    return Response.ok(updatedProduct);
  }

  @Operation.delete('id')
  Future<Response> deleteProduct(@Bind.path('id') int id) async {
    final q = Query<Product>(context)..where((p) => p.id).equalTo(id);
    final selectedProduct = await q.fetchOne();
    if (selectedProduct == null) {
      return Response.notFound();
    }
    final affected = await q.delete();
    return Response.ok({'message': '$affected product has been deleted'});
  }
}
