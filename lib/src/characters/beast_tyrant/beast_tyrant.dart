import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class BeastTyrant extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;
  Icon characterIcon = Icon(CharacterIcons.beast_tyrant_icon);

  BeastTyrant(this.name) {
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(ONE_AVAILABLE),
      Perk.replaceMinusOneWithPlusOne(THREE_AVAILABLE, characterClass),
      Perk.replaceZeroWithPlusTwo(TWO_AVAILABLE, characterClass),
      Perk.addPlusOneAndWoundCard(TWO_AVAILABLE, characterClass),
      Perk.addPlusOneAndImmobilizeCard(TWO_AVAILABLE, characterClass),
      Perk.addTwoRollingHealOneCards(THREE_AVAILABLE, characterClass),
      Perk.addCards(InfusionCard(Infusion.earth, characterClass).times(2),
          ONE_AVAILABLE, 'Add two [ROLLING] [EARTH INFUSION] cards')
    ];
  }
}
