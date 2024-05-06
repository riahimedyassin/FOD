import 'package:dcli/dcli.dart';
import 'package:main/Bootstrap.dart';


void main(List<String> arguments) async {
  String path = ask("Enter the path", required: true);
  Bootstrap boot = Bootstrap(path);
  boot.run();
}
