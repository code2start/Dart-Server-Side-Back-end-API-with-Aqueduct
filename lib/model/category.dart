import 'package:lesson11/lesson11.dart';

class Category extends ManagedObject<_Catgory> implements _Catgory {}

@Table(name: 'categories')
class _Catgory {
  @primaryKey
  int id;
  String name;
}
