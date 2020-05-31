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
        'name': 'Dart Programming',
        'content':
            'Dart Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet pulvinar eros. In ultricies urna nec facilisis ultrices. Nullam consequat eros ac felis pellentesque pretium. '
      },
      {
        'name': 'Flutter Mobile',
        'content':
            'Flutter Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet pulvinar eros. In ultricies urna nec facilisis ultrices. Nullam consequat eros ac felis pellentesque pretium. '
      },
      {
        'name': 'ASP.net Programming',
        'content':
            'ASP.NET Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet pulvinar eros. In ultricies urna nec facilisis ultrices. Nullam consequat eros ac felis pellentesque pretium. '
      },
      {
        'name': 'Dart Server Side',
        'content':
            'Dart server Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet pulvinar eros. In ultricies urna nec facilisis ultrices. Nullam consequat eros ac felis pellentesque pretium. '
      },
      {
        'name': 'JavaScript',
        'content':
            'JavaScript Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet pulvinar eros. In ultricies urna nec facilisis ultrices. Nullam consequat eros ac felis pellentesque pretium. '
      },
    ];
    for (final course in courses) {
      await database.store.execute(
          "insert into _course(name, content) values (@name,@content)",
          substitutionValues: {
            "name": course['name'],
            "content": course['content']
          });
    }
  }
}
