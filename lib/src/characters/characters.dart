import 'package:flutter/foundation.dart';
import 'package:gloomhaven_decks/src/classes/character_class.dart';

class Characters extends ChangeNotifier {
  final List<CharacterClass> _characters = [];

  List<CharacterClass> get characters => _characters;

  void addCharacter(CharacterClass character) {
    _characters.add(character);
    notifyListeners();
  }

  void deleteCharacter(CharacterClass character) {
    _characters.remove(character);
    notifyListeners();
  }

  void toggleCharacterActiveState(CharacterClass character) {
    character.toggleActiveState();
    notifyListeners();
  }
}