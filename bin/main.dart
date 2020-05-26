import 'package:aqueduct/aqueduct.dart';
import 'package:backend2/backend2.dart';

Future main() async {
  final app = Application<Backend2Channel>()..options.port = 8888;
  await app.start();
}
