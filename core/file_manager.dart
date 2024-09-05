import 'dart:async';
import 'dart:io';

import '../types/config_types.dart';
import '../utils/file_system.dart';
import 'config_manager.dart';

class FileManager {
  late String _workingPath;
  late FileSystem _fileSystem;
  late ConfigManager _configManager;
  FileManager(String value) {
    _workingPath = value;
    _fileSystem = FileSystem();
    _configManager = ConfigManager();
  }

  Future<List<File>> getDirectoryFiles() async {
    List<File> files = (await Directory("$_workingPath/./").list().toList())
        .whereType<File>()
        .toList();
    return files;
  }

  DirectoryFiles arangeFilesToDirectories(
    ExtensionFiles filteredFiles,
    DirectoryExtensions constaint,
  ) {
    DirectoryFiles result = {};
    filteredFiles.forEach((key, value) {
      constaint.forEach((direct, extensions) {
        if (extensions.contains(key)) {
          if (result[direct] != null) {
            result[direct]!.addAll(value);
          } else {
            result[direct] = value;
          }
        }
      });
    });
    return result;
  }

  Future<DirectoryExtensions> getDirectoriesExtension(
      List<String> directories) async {
    DirectoryExtensions result = {};
    for (String directory in directories) {
      var local = await _fileSystem.createDirectory(_workingPath, directory);
      result.addAll(
          {local: await _configManager.getDirectoryExtensions(directory)});
    }
    return result;
  }

  Future execute() async {
    var directories = await _configManager.getConfigDirectories();
    DirectoryExtensions directoriesByExtension =
        await getDirectoriesExtension(directories);
    List<File> directoryFiles = await getDirectoryFiles();
    ExtensionFiles groupedFilesByExtension = _fileSystem.groupByExtension(
      directoryFiles,
    );
    var arranged = arangeFilesToDirectories(
      groupedFilesByExtension,
      directoriesByExtension,
    );
    await _fileSystem.moveFilesToDirectories(arranged);
  }
}
