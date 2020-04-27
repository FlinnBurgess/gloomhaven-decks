import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character_icons.dart';

class Scoundrel extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Scoundrel(this.name) {
    characterIcon = Icon(CharacterIcons.scoundrel_icon);
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceMinusTwoWithZero(ONE_AVAILABLE, characterClass),
      Perk.replaceMinusOneWithPlusOne(ONE_AVAILABLE, characterClass),
      Perk.replaceZeroWithPlusTwo(TWO_AVAILABLE, characterClass),
      Perk.addTwoRollingPlusOnes(TWO_AVAILABLE, characterClass),
      Perk.addCards(
          AttackEffectCard(AttackEffect.pierce, 3, characterClass)
              .times(2),
          ONE_AVAILABLE,
          'Add three [ROLLING] [PIERCE 3] cards'),
      Perk.addCards(
          ConditionCard(Condition.poison, characterClass).times(2),
          TWO_AVAILABLE,
          'Add two [ROLLING] [POISON] cards'),
      Perk.addCards(
          ConditionCard(Condition.muddle, characterClass).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [MUDDLE] cards'),
      Perk.addCard(
          ConditionCard(Condition.invisible, characterClass),
          ONE_AVAILABLE,
          'Add one [ROLLING] [INVISIBLE] perk'),
    ];
  }
}
