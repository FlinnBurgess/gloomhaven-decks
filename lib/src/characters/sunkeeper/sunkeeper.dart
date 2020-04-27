import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character_icons.dart';

class Sunkeeper extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Sunkeeper(this.name) {
    characterIcon = Icon(CharacterIcons.sunkeeper_icon);
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceMinusTwoWithZero(ONE_AVAILABLE, characterClass),
      Perk.replaceZeroWithPlusTwo(ONE_AVAILABLE, characterClass),
      Perk.addTwoRollingPlusOnes(TWO_AVAILABLE, characterClass),
      Perk.addTwoRollingHealOneCards(TWO_AVAILABLE, characterClass),
      Perk.addOneRollingStunCard(ONE_AVAILABLE, characterClass),
      Perk.addCards(InfusionCard(Infusion.light, characterClass).times(2),
          TWO_AVAILABLE, 'Add two [ROLLING] [LIGHT INFUSION] cards'),
      Perk.addCards(
          AttackEffectCard(AttackEffect.shield, 1, characterClass).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [SHIELD 1], Self cards'),
      Perk.addCards(DamageChangeCard.forCharacter(1, characterClass).times(2),
          ONE_AVAILABLE, 'Ignore negative item effects and add two +1 cards')
    ];
  }
}
