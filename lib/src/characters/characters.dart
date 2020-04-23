import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:path_provider/path_provider.dart';

class Characters extends ChangeNotifier {
  List<Character> _characters = [];

  List<Character> get characters => _characters;

  Characters(this._characters);

  void addCharacter(Character character) {
    _characters.add(character);
    save();
    notifyListeners();
  }

  void deleteCharacter(Character character) {
    _characters.remove(character);
    save();
    notifyListeners();
  }

  void setCharacterActiveState(Character character, bool isActive) {
    character.isActive = isActive;
    save();
    notifyListeners();
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> asJson = [];
    _characters.forEach((character) => asJson.add(character.toJson()));
    return asJson;
  }

  static List<Character> fromJson(List<dynamic> json) {
    return json.map<Character>((jsonCharacter) =>
        Character.fromJson(jsonCharacter)).toList();
  }

  Future<void> save() async {
    final file = await _localFile;

    return file.writeAsString(jsonEncode(this.toJson()));
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/characters.json');
  }
}