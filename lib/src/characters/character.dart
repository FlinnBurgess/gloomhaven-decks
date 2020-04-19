import 'package:gloomhaven_decks/src/characters/scoundrel/scoundrel.dart';
import 'package:gloomhaven_decks/src/characters/spellweaver/spellweaver.dart';
import 'package:gloomhaven_decks/src/characters/tinkerer/tinkerer.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import 'brute/brute.dart';
import 'cragheart/cragheart.dart';
import 'mindthief/mindthief.dart';
import 'nightshroud/nightshroud.dart';

abstract class Character {
  String name;
  bool isActive = true;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck;

  static final CLASS_LIST = [
    'Brute',
    'Cragheart',
    'Mindthief',
    'Scoundrel',
    'Spellweaver',
    'Tinkerer',
    'NightShroud'
  ];

  static Character createCharacter(className, name) {
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