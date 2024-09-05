import 'dart:io';
import '../types/config_types.dart';


class FileSystem {
  Future<Directory> createDirectory(String path, String name) async {
    Directory dir = Directory("$path/$name");
    if (!await folderExists("$path/$name")) {
      try {
        return await dir.create();
      } on Exception {
        throw Exception("Cannot create directory");
      }
    }
    return dir;
  }

  Future<bool> folderExists(String fullPath) async {
    return await Directory(fullPath).exists();
  }

  Map<String, List<File>> groupByExtension(List<File> files) {
    Map<String, List<File>> result = {};
    for (File file in files) {
      String extension = file.toString().split(".")[2].replaceAll('\'', "");
      if (result[extension] != null) {
        result.update(extension, (value) {
          value.add(file);
          return value;
        });
        continue;
      }
      result[extension] = [file];
    }
    return result;
  }

  Future<bool> moveFilesToDirectories(DirectoryFiles values) async {
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
