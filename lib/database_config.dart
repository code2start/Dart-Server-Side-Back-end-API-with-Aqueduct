import 'package:lesson11/lesson11.dart';

class DatabaseConfig extends Configuration {
  DatabaseConfig(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}
