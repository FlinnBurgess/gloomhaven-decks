import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry/sentry.dart';

class Characters extends ChangeNotifier {
  List<Character> _characters = [];
  static var sentry = SentryClient(
      dsn:
      "https://c4b85bb56d4f4514824ea548a80013a7@o387184.ingest.sentry.io/5222123");

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

  static Future<Characters> load() async {
    try {
      final file = await _localFile;
      String encodedCharacters = await file.readAsString();
      List<dynamic> decodedCharacters = jsonDecode(encodedCharacters);
      return Characters(fromJson(decodedCharacters));
    } catch (error, stackTrace) {
      try {
        await sentry.captureException(exception: error, stackTrace: stackTrace);
        print('Error sent to sentry.io: $error');
      } catch (e) {
        print('Sending report to sentry.io failed: $e');
        print('Original error: $error');
      }
      return Characters([]);
    }
  }

  Future<void> save() async {
    try {
      final file = await _localFile;
      return file.writeAsString(jsonEncode(this.toJson()));
    } catch (e) {
      print('Error saving characters: $e');
    }
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/characters.json');
  }
}