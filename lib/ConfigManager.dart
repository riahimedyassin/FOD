import 'dart:io';
import 'package:yaml/yaml.dart'; 

class ConfigManager {
  ConfigManager();
  loadConfig() async {
    File configFile = File("./config.yaml");
    var res = await configFile.readAsString();
    var yamlRes = await loadYaml(res) as YamlList ; 
    print(yamlRes);
  }
}
