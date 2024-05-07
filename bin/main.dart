import 'package:dcli/dcli.dart';
import 'package:main/Bootstrap.dart';
import 'package:main/FileManagerFactory.dart';

void main(List<String> arguments) async {
  String path = ask("Enter the path", required: true);
  FileManagerFactory fileManagerFactory = FileManagerFactory(path);
  fileManagerFactory.arangeFiles();
}
