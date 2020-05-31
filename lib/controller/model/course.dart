import 'package:lesson3/lesson3.dart';

class Course extends ManagedObject<_Course> implements _Course {}

class _Course {
  //attributes = column
  @primaryKey
  int id;
  @Column(unique: true)
  String name;
  String content;
}
