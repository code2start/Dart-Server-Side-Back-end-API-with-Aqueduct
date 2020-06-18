import 'package:lesson11/lesson11.dart';
import 'package:lesson11/model/author.dart';

class AuthorsController extends ResourceController {
  AuthorsController(this.context);
  ManagedContext context;

  @Operation.get()
  Future<Response> getAllAuthors() async {
    final q = Query<Author>(context);
    final authors = await q.fetch();
    return Response.ok(authors);
  }

  @Operation.get('id')
  Future<Response> getAuthorById(@Bind.path('id') int id) async {
    final q = Query<Author>(context)
      ..join(set: (a) => a.books)
      ..where((a) => a.id).equalTo(id);
    final authors = await q.fetch();
    return Response.ok(authors);
  }
}
