import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/characters/beast_tyrant/beast_tyrant.dart';
import 'package:gloomhaven_decks/src/characters/berserker/berserker.dart';
import 'package:gloomhaven_decks/src/characters/doomstalker/doomstalker.dart';
import 'package:gloomhaven_decks/src/characters/plagueherald/plagueherald.dart';
import 'package:gloomhaven_decks/src/characters/quartermaster/quartermaster.dart';
import 'package:gloomhaven_decks/src/characters/sawbones/sawbones.dart';
import 'package:gloomhaven_decks/src/characters/scoundrel/scoundrel.dart';
import 'package:gloomhaven_decks/src/characters/soothsinger/soothsinger.dart';
import 'package:gloomhaven_decks/src/characters/spellweaver/spellweaver.dart';
import 'package:gloomhaven_decks/src/characters/summoner/summoner.dart';
import 'package:gloomhaven_decks/src/characters/sunkeeper/sunkeeper.dart';
import 'package:gloomhaven_decks/src/characters/tinkerer/tinkerer.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import 'brute/brute.dart';
import 'cragheart/cragheart.dart';
import 'mindthief/mindthief.dart';
import 'nightshroud/nightshroud.dart';

final STARTING_CLASSES = [
  'Brute',
  'Cragheart',
  'Mindthief',
  'Scoundrel',
  'Spellweaver',
  'Tinkerer',
];

abstract class Character {
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
    'Sunkeeper',
    'Plagueherald',
    'Beast Tyrant',
    'Berserker',
    'Doomstalker',
    'Quartermaster',
    'Sawbones',
    'Soothsinger',
    'Summoner'
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
      case 'Plagueherald':
        return Plagueherald(name);
      case 'Beast Tyrant':
        return BeastTyrant(name);
      case 'Berserker':
        return Berserker(name);
      case 'Doomstalker':
        return Doomstalker(name);
      case 'Quartermaster':
        return Quartermaster(name);
      case 'Sawbones':
        return Sawbones(name);
      case 'Soothsinger':
        return Soothsinger(name);
      case 'Summoner':
        return Summoner(name);
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