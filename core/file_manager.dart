import 'dart:io';

class FileManager {
  String _workingPath = "./";
  FileManager(String value) {
    _workingPath = value;
  }
  Future createFolder(String foldername) async {
    Directory dir = Directory("$_workingPath/$foldername");
    if (!await isFolder(foldername)) {
      try {
        var newDirectory = await dir.create();
        return newDirectory;
      } on Exception {
        print("Cannot create directory");
        return Null;
      }
    }
    return dir;
  }

  Future<bool> isFolder(String name) async {
    return await Directory("$_workingPath/$name").exists();
  }

  Future<List<File>> getDirectoryFiles() async {
    List<File> files = (await Directory("$_workingPath/./").list().toList())
        .whereType<File>()
        .toList();
    return files;
  }

  filterByExtension(List<File> files) {
    Map<String, List<File>> result = {};
    for (File file in files) {
      String extension = file.toString().split(".")[2].replaceAll('\'', "");
      if (result.containsKey(extension)) {
        result.update(extension, (value) {
          value.add(file) ; 
          return value;
        });
      } else {
        result[extension] = [file];
      }
    }
    return result;
  }

  Map<Directory, List<File>> arangeFilesToDirectories(
    Map<String, List<File>> filteredFiles,
    Map<Directory, List<String>> constaint,
  ) {
    Map<Directory, List<File>> result = {};
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

  Future<bool> moveFilesToDirectory(Map<Directory, List<File>> values) async {
    try {
      values.forEach((directory, files) {
        files.forEach((file) async {
          await file.copy("${directory.path}/${file.path.split("/")[2]}");
          await file.delete();
        });
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
