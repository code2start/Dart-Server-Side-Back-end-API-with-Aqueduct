import 'dart:async';
import 'package:aqueduct/aqueduct.dart';

class Migration2 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("authors", [
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
          isUnique: false)
    ]));
    database.createTable(SchemaTable("books", [
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
          isUnique: false)
    ]));
    database.addColumn(
        "books",
        SchemaColumn.relationship("author", ManagedPropertyType.bigInteger,
            relatedTableName: "authors",
            relatedColumnName: "id",
            rule: DeleteRule.nullify,
            isNullable: true,
            isUnique: false));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final authors = [
      {'name': 'Mohamed Fathy'},
      {'name': 'Ahmed Fathy'},
      {'name': 'Sayed Fathy'},
    ];
    for (final author in authors) {
      await database.store.execute('insert into authors(name) values(@name)',
          substitutionValues: {'name': author['name']});
    }
    final books = [
      {'name': 'Introduction to dart programming', 'author_id': 1},
      {'name': 'Introduction to php programming', 'author_id': 2},
      {'name': 'Introduction to flutter', 'author_id': 1},
      {'name': 'dart for beginners', 'author_id': 2},
      {'name': 'C# for beginners', 'author_id': 3},
      {'name': 'Angular for beginners', 'author_id': 3},
    ];
    for (final book in books) {
      await database.store.execute(
          'insert into books(name,author_id) values(@name,@author_id)',
          substitutionValues: {
            'name': book['name'],
            'author_id': book['author_id']
          });
    }
  }
}
