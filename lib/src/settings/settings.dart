import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Settings {
  bool lessRandomness = false;
  bool hideNonStarterClassNames = true;

  void setLessRandomnessSetting(bool setting) {
    lessRandomness = setting;
  }

  void setHideNonStarterClassNames(bool setting) {
    hideNonStarterClassNames = setting;
  }

  Map<String, dynamic> toJson() {
    return {
      'doubleAndNullAreTwoDamageChangeInstead': lessRandomness,
      'hideNonStarterClassNames': hideNonStarterClassNames
    };
  }

  static Settings fromJson(Map<String, dynamic> json) {
    Settings settings = Settings();
    settings.lessRandomness = json['doubleAndNullAreTwoDamageChangeInstead'];
    settings.hideNonStarterClassNames = json['hideNonStarterClassNames'];
    return settings;
  }

  Future<void> save() async {
    final file = await _localFile;

    return file.writeAsString(jsonEncode(this.toJson()));
  }

  static Future<Settings> load() async {
    try {
      final file = await _localFile;
      String encodedSettings = await file.readAsString();
      Map<String, dynamic> decodedSettings = jsonDecode(encodedSettings);
      return fromJson(decodedSettings);
    } catch (e) {
      return Settings();
    }
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/settings.json');
  }
}
