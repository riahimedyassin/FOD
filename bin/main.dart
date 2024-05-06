import 'dart:io';

import 'package:main/FileManager.dart';

void main(List<String> arguments) async {
  FileManager fileManager = FileManager();
  var files = await fileManager.getDirectoryFiles("./");
  var filteredFiles = fileManager.filterByExtension(files);
  var direct = await fileManager.createFolder("documents");
  print(filteredFiles);
  Map<Directory, List<String>> supportedValues = {
    direct: ["md","yaml"]
  };
  var res = fileManager.arangeFilesToDirectories(filteredFiles, supportedValues); 
  fileManager.moveFilesToDirectory(res); 
}
