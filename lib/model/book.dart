import 'package:lesson11/lesson11.dart';
import 'package:lesson11/model/author.dart';

class Book extends ManagedObject<_Book> implements _Book {}

@Table(name: 'books')
class _Book {
  @primaryKey
  int id;
  String name;

  @Relate(#books)
  Author author;
}
