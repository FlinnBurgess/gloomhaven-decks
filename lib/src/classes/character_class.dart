import 'package:gloomhaven_decks/src/classes/brute/brute.dart';
import 'package:gloomhaven_decks/src/classes/cragheart/cragheart.dart';
import 'package:gloomhaven_decks/src/classes/mindthief/mindthief.dart';
import 'package:gloomhaven_decks/src/classes/scoundrel/scoundrel.dart';
import 'package:gloomhaven_decks/src/classes/spellweaver/spellweaver.dart';
import 'package:gloomhaven_decks/src/classes/tinkerer/tinkerer.dart';

abstract class CharacterClass {
  static final CLASS_LIST = [
    'Brute',
    'Cragheart',
    'Mindthief',
    'Scoundrel',
    'Spellweaver',
    'Tinkerer',
  ];

  static CharacterClass createCharacterClass(className, name) {
    switch (className) {
      case 'Brute':
        return Brute(name);
      case 'Cragheart':
        return Cragheart(name);
      case 'Mindthief':
        return Mindthief(name);
      case 'Scoundrel':
        return Scoundrel(name);
      case 'Spellweaver':
        return Spellweaver(name);
      case 'Tinkerer':
        return Tinkerer(name);
      default:
        return null;
    }
  }
}