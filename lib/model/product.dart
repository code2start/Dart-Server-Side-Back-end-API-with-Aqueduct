import 'package:lesson11/lesson11.dart';

class Product extends ManagedObject<_Product> implements _Product {}

@Table(name: 'products')
class _Product {
  @primaryKey
  int id;
  String name;
  double price;
}
