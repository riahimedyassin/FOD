import 'dart:io';
import 'package:yaml/yaml.dart';

class ConfigManager {
  Map<String, List<String>> _configuration = {};
  ConfigManager();
  Future<Map<String, List<String>>> _loadConfig() async {
    if (_configuration.isEmpty) {
      File configFile = File("./config.yaml");
      var res = await configFile.readAsString();
      var yamlRes = (await loadYaml(res)) as YamlMap;
      final dartMap = _convertYamlMapToMap(yamlRes);
      _configuration = dartMap;
    }
    return _configuration;
  }

  Map<String, List<String>> _convertYamlMapToMap(YamlMap yamlMap) {
    final dartMap = <String, List<String>>{};
    yamlMap.forEach((key, value) {
      dartMap[key.toString()] = _convertYamlValue(value);
    });
    return dartMap;
  }

  List<String> _convertYamlValue(dynamic value) {
    if (value is YamlList) {
      return value.map((item) => item.toString()).toList();
    } else {
      return [value.toString()];
    }
  }

  Future<List<String>> getConfigDirectories() async {
    return (await _loadConfig()).keys.toList();
  }

  Future<List<String>> getConfigDirectorysExtension(String directory) async {
    return (await _loadConfig())[directory]!;
  }
}
