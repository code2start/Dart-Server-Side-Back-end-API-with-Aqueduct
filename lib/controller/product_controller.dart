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
}
