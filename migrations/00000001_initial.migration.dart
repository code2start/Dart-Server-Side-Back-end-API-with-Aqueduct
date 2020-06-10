import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:lesson11/model/product.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(SchemaTable("categories", [
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
    database.createTable(SchemaTable("products", [
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
          isUnique: false),
      SchemaColumn("price", ManagedPropertyType.doublePrecision,
          isPrimaryKey: false,
          autoincrement: false,
          isIndexed: false,
          isNullable: false,
          isUnique: false)
    ]));
    database.addColumn(
        "products",
        SchemaColumn.relationship("category", ManagedPropertyType.bigInteger,
            relatedTableName: "categories",
            relatedColumnName: "id",
            rule: DeleteRule.nullify,
            isNullable: true,
            isUnique: false));
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final categories = [
      {'name': 'Mobiles'},
      {'name': 'Tablets'},
      {'name': 'Labtops'},
    ];
    for (final category in categories) {
      await database.store.execute('insert into categories(name) values(@name)',
          substitutionValues: {
            'name': category['name'],
          });
    }
    final products = [
      {'name': 'Samsung s1', 'price': 3233, 'category_id': 1},
      {'name': 'Nexsus 2', 'price': 53233, 'category_id': 1},
      {'name': 'Mac pro', 'price': 63233, 'category_id': 2},
      {'name': 'HP pro', 'price': 33233, 'category_id': 2},
      {'name': 'Dell 555', 'price': 63233, 'category_id': 3},
      {'name': 'HP 755', 'price': 93233, 'category_id': 3},
    ];
    for (final product in products) {
      await database.store.execute(
          'insert into products(name,price,category_id) values(@name,@price,@category_id)',
          substitutionValues: {
            'name': product['name'],
            'price': product['price'],
            'category_id': product['category_id'],
          });
    }
  }
}
