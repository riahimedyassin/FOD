import 'dart:io';
import 'package:yaml/yaml.dart';

import '../utils/yaml.parser.dart';

class ConfigManager {
  Map<String, List<String>> _configuration = {};
  final YamlParser _yamlParser = YamlParser();
  ConfigManager();
  Future<Map<String, List<String>>> _loadConfig() async {
    if (_configuration.isEmpty) {
      File configFile = File("./config.yaml");
      var res = await configFile.readAsString();
      var yamlRes = (await loadYaml(res)) as YamlMap;
      final dartMap = _yamlParser.parse(yamlRes);
      _configuration = dartMap;
    }
    return _configuration;
  }

  Future<List<String>> getConfigDirectories() async {
    return (await _loadConfig()).keys.toList();
  }

  Future<List<String>> getConfigDirectorysExtension(String directory) async {
    return (await _loadConfig())[directory]!;
  }
}
