import 'package:main/FileManager.dart';

void main(List<String> arguments) async {
  // print(arguments);
  FileManager fileManager = FileManager();
  var files = await fileManager.getDirectoryFiles("./");
  // print(files);
  print(fileManager.filterByExtension(files)); 
}
