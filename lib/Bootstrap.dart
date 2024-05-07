import 'dart:io';

import 'package:main/ConfigManager.dart';
import 'package:main/FileManager.dart';
import 'package:main/FileManagerFactory.dart';

class Bootstrap {
  late String path;
  late FileManagerFactory fileManagerFactory;
  Bootstrap(this.path) {
    fileManagerFactory = FileManagerFactory(path);
  }
  void run() async {
    fileManagerFactory.arangeFiles();
  }
}
