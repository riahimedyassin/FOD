import 'package:yaml/yaml.dart';

class YamlParser {
  Map<String, List<String>> parse(YamlMap yamlMap) {
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
}
