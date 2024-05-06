import 'dart:io';

import 'package:main/ConfigManager.dart';
import 'package:main/FileManager.dart';

class Bootstrap {
  late String path;
  late ConfigManager _configManager;
  late FileManager _fileManager;
  Bootstrap(this.path) {
    _configManager = ConfigManager();
    _fileManager = FileManager(path);
  }
  void run() async {
    var directories = await _configManager.getConfigDirectories();
    Map<Directory, List<String>> acctualDirectives = {};
    for (String directory in directories) {
      var local = (await _fileManager.createFolder(directory)) as Directory;
      acctualDirectives.addAll({
        local: await _configManager.getConfigDirectorysExtension(directory)
      });
    }
    List<File> directoryFiles = await _fileManager.getDirectoryFiles();
    Map<String, List<File>> filtered = _fileManager.filterByExtension(
      directoryFiles,
    );
    var arranged = _fileManager.arangeFilesToDirectories(
      filtered,
      acctualDirectives,
    );
    await _fileManager.moveFilesToDirectory(arranged);
  }
}
