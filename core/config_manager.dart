import 'dart:io';
import 'package:yaml/yaml.dart';

import '../types/config_types.dart';
import '../utils/yaml.parser.dart';

class ConfigManager {
  ConfigType _configuration = {};
  final YamlParser _yamlParser = YamlParser();
  ConfigManager();
  Future<bool> _loadConfig() async {
    try {
      File configFile = File("./config.yaml");
      var res = await configFile.readAsString();
      var yamlRes = (await loadYaml(res)) as YamlMap;
      final dartMap = _yamlParser.parse(yamlRes);
      _configuration = dartMap;
      return true;
    } on Exception {
      return false;
    }
  }

  Future<ConfigType> getConfig() async {
    if (_configuration.isEmpty) {
      await _loadConfig();
    }
    return _configuration;
  }

  Future<List<String>> getConfigDirectories() async {
    return (await getConfig()).keys.toList();
  }

  Future<List<String>> getDirectoryExtensions(String directory) async {
    return (await getConfig())[directory]!;
  }
}
