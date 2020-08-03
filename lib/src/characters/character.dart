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
import 'package:gloomhaven_decks/src/item/item.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';
import 'package:recase/recase.dart';

import 'brute/brute.dart';
import 'cragheart/cragheart.dart';
import 'elementalist/elementalist.dart';
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
  IconData characterIcon;
  String backgroundImagePath;
  List<Item> _items = [];
  List<int> _itemWishList = [];
  bool _ignoreNegativeItemEffects = false;
  bool _ignoreNegativeScenarioEffects = false;

  static final CLASS_LIST = [
    'Brute',
    'Cragheart',
    'Mindthief',
    'Scoundrel',
    'Spellweaver',
    'Tinkerer',
    'Beast Tyrant',
    'Berserker',
    'Doomstalker',
    'Elementalist',
    'Nightshroud',
    'Plagueherald',
    'Quartermaster',
    'Sawbones',
    'Soothsinger',
    'Summoner',
    'Sunkeeper',
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
      case 'Elementalist':
        return Elementalist(name);
      default:
        throw Exception('Unrecognised class: $className');
    }
  }

  void toggleActiveState() {
    isActive = !isActive;
  }

  void addItem(Item item) {
    if (!_items.contains(item)) {
      _items.add(item);
    }
  }

  void removeItem(Item item) {
    if (_items.contains(item)) {
      _items.remove(item);
    }
  }

  bool ownsItem(Item item) {
    return _items.contains(item);
  }

  void addWishListItem(int itemNumber) {
    if (!_itemWishList.contains(itemNumber)) {
      _itemWishList.add(itemNumber);
    }
  }

  void removeWishListItem(int itemNumber) {
    _itemWishList.remove(itemNumber);
  }

  bool applyPerk(Perk perk) {
    return perk.apply(this);
  }

  bool unapplyPerk(Perk perk) {
    return perk.unapply(this);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'class': this.runtimeType.toString(),
      'isActive': isActive,
      'perks': perks.map<int>((perk) => perk.perksUsed).toList(),
      'items': _items.map((item) => item.itemNumber).toList(),
      'itemWishList': _itemWishList
    };
  }

  static Character fromJson(dynamic json) {
    String name = json['name'];
    String className = json['class'];
    bool isActive = json['isActive'];
    List perks = json['perks'];
    List<Item> savedItems = json['items'] == null
        ? []
        : json['items'].map<Item>((itemNumber) => Item(itemNumber)).toList();
    List<int> itemWishList =
        json['itemWishList'] == null ? [] : json['itemWishList'].cast<int>();

    Character character = createCharacter(className.titleCase, name);
    character.isActive = isActive;

    for (int currentPerk = 0; currentPerk < perks.length; currentPerk++) {
      for (int applied = 0; applied < perks[currentPerk]; applied++) {
        character.applyPerk(character.perks[currentPerk]);
        character.perks[currentPerk].perksUsed++;
        character.perks[currentPerk].perksAvailable--;
      }
    }

    character._items = savedItems;
    character._itemWishList = itemWishList;

    return character;
  }

  List<Item> get items => _items;

  List<int> get itemWishList => _itemWishList;

  bool get ignoreNegativeItemEffects => _ignoreNegativeItemEffects;

  set ignoreNegativeItemEffects(bool value) {
    _ignoreNegativeItemEffects = value;
  }

  bool get ignoreNegativeScenarioEffects => _ignoreNegativeScenarioEffects;

  set ignoreNegativeScenarioEffects(bool value) {
    _ignoreNegativeScenarioEffects = value;
  }
}
