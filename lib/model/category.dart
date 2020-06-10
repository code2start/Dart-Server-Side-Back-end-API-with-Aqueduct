import 'package:lesson11/lesson11.dart';
import 'package:lesson11/model/product.dart';

class Category extends ManagedObject<_Category> implements _Category {}

@Table(name: 'categories')
class _Category {
  @primaryKey
  int id;

  String name;

  ManagedSet<Product> products;
}
