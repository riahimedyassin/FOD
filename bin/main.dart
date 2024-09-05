import 'package:dcli/dcli.dart';
import '../core/file_manager.dart';

void main(List<String> arguments) async {
  String path = ask("Enter the path", required: true);
  FileManager boot = FileManager(path);
  boot.execute();
}
