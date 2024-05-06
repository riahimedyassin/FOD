import 'dart:io';

class FileManager {
  FileManager();
  Future createFolder(String foldername) async {
    print("Creating folder with name $foldername");
    if (!await isFolder(foldername)) {
      Directory dir = Directory(foldername);
      try {
        var newDirectory = await dir.create();
        return newDirectory.path;
      } on Exception {
        print("Cannot create directory");
        return Null;
      }
    }
    return Null;
  }

  Future<bool> isFolder(String name) async {
    return await Directory(name).exists();
  }

  Future<List<FileSystemEntity>> getDirectoryFiles(String name) async {
    List<FileSystemEntity> files = await Directory(name).list().toList();
    files = files.whereType<File>().toList();
    return files;
  }

  filterByExtension(List<FileSystemEntity> files) {
    Map<String, List<FileSystemEntity>> result = {};
    for (FileSystemEntity file in files) {
      String extension = file.toString().split(".")[2];
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
}
