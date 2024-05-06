import 'dart:io';

class FileManager {
  FileManager();
  Future createFolder(String foldername) async {
    Directory dir = Directory(foldername);
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
    return await Directory(name).exists();
  }

  Future<List<File>> getDirectoryFiles(String name) async {
    List<File> files =
        (await Directory(name).list().toList()).whereType<File>().toList();
    return files;
  }

  filterByExtension(List<File> files) {
    Map<String, List<File>> result = {};
    for (File file in files) {
      String extension = file.toString().split(".")[2].replaceAll('\'', "");
      if (result.containsKey(extension)) {
        result.update(extension, (value) {
          value.add(file);
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
    values.forEach((directory, files) {
      for (File file in files) {
        file.copy("./${directory.path}/${file.path}");
      }
    });
    return true;
  }
}
