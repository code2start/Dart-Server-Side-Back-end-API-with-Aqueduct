import 'package:lesson11/lesson11.dart';
import 'package:lesson11/model/category.dart';

class Product extends ManagedObject<_Product> implements _Product {}

@Table(name: 'products')
class _Product {
  @primaryKey
  int id;
  String name;
  double price;
  @Relate(#products)
  Category category;
}
