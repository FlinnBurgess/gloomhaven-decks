import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/characters/scoundrel/scoundrel.dart';
import 'package:gloomhaven_decks/src/characters/spellweaver/spellweaver.dart';
import 'package:gloomhaven_decks/src/characters/sunkeeper/sunkeeper.dart';
import 'package:gloomhaven_decks/src/characters/tinkerer/tinkerer.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import 'brute/brute.dart';
import 'cragheart/cragheart.dart';
import 'mindthief/mindthief.dart';
import 'nightshroud/nightshroud.dart';

abstract class Character {
  final int ONE_AVAILABLE = 1;
  final int TWO_AVAILABLE = 2;
  final int THREE_AVAILABLE = 3;

  String name;
  bool isActive = true;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck;
  Icon characterIcon;

  static final CLASS_LIST = [
    'Brute',
    'Cragheart',
    'Mindthief',
    'Scoundrel',
    'Spellweaver',
    'Tinkerer',
    'Nightshroud',
    'Sunkeeper'
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
      case 'Nightshroud':
        return Nightshroud(name);
      case 'Sunkeeper':
        return Sunkeeper(name);
      default:
        return null;
    }
  }

  void toggleActiveState() {
    isActive = !isActive;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'class': this.runtimeType.toString(),
      'isActive': isActive,
      'perks': perks.map<int>((perk) => perk.perksUsed).toList()
    };
  }

  static Character fromJson(dynamic json) {
    String name = json['name'];
    String className = json['class'];
    bool isActive = json['isActive'];
    List perks = json['perks'];

    Character character = createCharacter(className, name);
    character.isActive = isActive;

    for (int currentPerk = 0; currentPerk < perks.length; currentPerk++) {
      for (int applied = 0; applied < perks[currentPerk]; applied++) {
        character.perks[currentPerk].apply(character.attackModifierDeck);
        character.perks[currentPerk].perksUsed++;
        character.perks[currentPerk].perksAvailable--;
      }
    }

    return character;
  }
}