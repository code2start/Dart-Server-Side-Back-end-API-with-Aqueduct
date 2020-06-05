import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("_Course", [
      SchemaColumn("id", ManagedPropertyType.bigInteger,
          isPrimaryKey: true,
          autoincrement: true,
          isIndexed: false,
          isNullable: false,
          isUnique: false),
      SchemaColumn("name", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: true),
      SchemaColumn("content", ManagedPropertyType.string,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false)
    ]));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final courses = [
      {
        'name': 'Dart programming',
        'content':
            'Dart Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean quam est, laoreet eget magna quis, luctus mollis massa. Class aptent taciti sociosqu ad litora torquent per conubia nostra,'
      },
      {
        'name': 'PHP programming',
        'content':
            'PHP Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean quam est, laoreet eget magna quis, luctus mollis massa. Class aptent taciti sociosqu ad litora torquent per conubia nostra,'
      },
      {
        'name': 'Dart Server',
        'content':
            'Dart Server Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean quam est, laoreet eget magna quis, luctus mollis massa. Class aptent taciti sociosqu ad litora torquent per conubia nostra,'
      },
      {
        'name': 'ASP.net',
        'content':
            'ASP.net Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean quam est, laoreet eget magna quis, luctus mollis massa. Class aptent taciti sociosqu ad litora torquent per conubia nostra,'
      },
      {
        'name': 'C# ',
        'content':
            'C# Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean quam est, laoreet eget magna quis, luctus mollis massa. Class aptent taciti sociosqu ad litora torquent per conubia nostra,'
      },
      {
        'name': 'Flutter Mobile ',
        'content':
            'Flutter Mobile Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean quam est, laoreet eget magna quis, luctus mollis massa. Class aptent taciti sociosqu ad litora torquent per conubia nostra,'
      },
    ];
    for (final course in courses) {
      await database.store.execute(
          "insert into _course(name,content) values(@name,@content)",
          substitutionValues: {
            "name": course['name'],
            "content": course['content']
          });
    }
  }
}
