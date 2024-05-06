import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:main/ConfigManager.dart';

import 'package:main/FileManager.dart';

void main(List<String> arguments) async {
  ConfigManager configManager = ConfigManager();
  await configManager.loadConfig();
}

void fileManagerTest() async {
  final String path = ask('Enter the path', required: true);
  FileManager fileManager = FileManager(path);
  var files = await fileManager.getDirectoryFiles("./");
  var filteredFiles = fileManager.filterByExtension(files);
  var direct = await fileManager.createFolder("documents");
  print(filteredFiles);
  Map<Directory, List<String>> supportedValues = {
    direct: ["txt", "yaml"]
  };
  var res =
      fileManager.arangeFilesToDirectories(filteredFiles, supportedValues);
  fileManager.moveFilesToDirectory(res);
}
