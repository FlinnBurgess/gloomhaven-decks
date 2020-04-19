import 'package:gloomhaven_decks/src/classes/brute/brute.dart';
import 'package:gloomhaven_decks/src/classes/cragheart/cragheart.dart';
import 'package:gloomhaven_decks/src/classes/mindthief/mindthief.dart';
import 'package:gloomhaven_decks/src/classes/nightshroud/nightshroud.dart';
import 'package:gloomhaven_decks/src/classes/scoundrel/scoundrel.dart';
import 'package:gloomhaven_decks/src/classes/spellweaver/spellweaver.dart';
import 'package:gloomhaven_decks/src/classes/tinkerer/tinkerer.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

abstract class CharacterClass {
  String name;
  bool isActive = true;
  List<Perk> perks;

  static final CLASS_LIST = [
    'Brute',
    'Cragheart',
    'Mindthief',
    'Scoundrel',
    'Spellweaver',
    'Tinkerer',
    'NightShroud'
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
      case 'NightShroud':
        return NightShroud(name);
      default:
        return null;
    }
  }

  void toggleActiveState() {
    isActive = !isActive;
  }
}