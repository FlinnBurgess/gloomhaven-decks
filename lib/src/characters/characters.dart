import 'package:flutter/foundation.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';

class Characters extends ChangeNotifier {
  final List<Character> _characters = [];

  List<Character> get characters => _characters;

  void addCharacter(Character character) {
    _characters.add(character);
    notifyListeners();
  }

  void deleteCharacter(Character character) {
    _characters.remove(character);
    notifyListeners();
  }

  void toggleCharacterActiveState(Character character) {
    if (_characters.contains(character)) {
      character.toggleActiveState();
      notifyListeners();
    }
  }
}