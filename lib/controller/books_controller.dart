import 'package:lesson11/lesson11.dart';
import 'package:lesson11/model/book.dart';

class BooksController extends ResourceController {
  BooksController(this.context);
  ManagedContext context;

  @Operation.get()
  Future<Response> getAllBooks() async {
    final q = Query<Book>(context);
    final books = await q.fetch();
    return Response.ok(books);
  }

  @Operation.get('id')
  Future<Response> getBookById(@Bind.path('id') int id) async {
    final q = Query<Book>(context)
      ..join(object: (b) => b.author)
      ..where((b) => b.id).equalTo(id);
    final books = await q.fetch();
    return Response.ok(books);
  }
}
