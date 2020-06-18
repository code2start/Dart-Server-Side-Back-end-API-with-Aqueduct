import 'package:lesson11/lesson11.dart';
import 'package:lesson11/model/book.dart';

class Author extends ManagedObject<_Author> implements _Author {}

@Table(name: 'authors')
class _Author {
  @primaryKey
  int id;
  String name;
  ManagedSet<Book> books;
}
