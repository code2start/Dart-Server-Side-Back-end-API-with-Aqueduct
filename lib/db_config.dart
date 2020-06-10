import 'package:lesson11/lesson11.dart';

class DbConfig extends Configuration {
  DbConfig(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}
