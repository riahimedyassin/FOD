import 'dart:io';

import 'package:main/ConfigManager.dart';

import 'FileManager.dart';

class FileManagerFactory {
  late ConfigManager _configManager;
  late FileManager _fileManager;
  FileManagerFactory(String path) {
    _fileManager = FileManager(path);
    _configManager = ConfigManager();
  }
  arangeFiles() async {
    var directories = await _configManager.getConfigDirectories();
    Map<Directory, List<String>> acctualDirectives =
        await _createFolders(directories);
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

  _createFolders(List<String> directories) async {
    Map<Directory, List<String>> acctualDirectives = {};
    for (String directory in directories) {
      var local = (await _fileManager.createFolder(directory)) as Directory;
      acctualDirectives.addAll({
        local: await _configManager.getConfigDirectorysExtension(directory)
      });
    }
    return acctualDirectives;
  }
}
