import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character_icons.dart';

class Mindthief extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Mindthief(this.name) {
    characterIcon = Icon(CharacterIcons.mindthief_icon);

    perks = [
      Perk.removeTwoMinusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.removeFourZeros(Perk.ONE_PERK_AVAILABLE),
      Perk.replaceCards(
          DamageChangeCard.base(1).times(2),
          DamageChangeCard.forCharacter(2, this.runtimeType.toString())
              .times(2),
          Perk.ONE_PERK_AVAILABLE,
          'Replace two +1 cards with two +2 cards'),
      Perk.replaceMinusTwoWithZero(
          Perk.ONE_PERK_AVAILABLE, this.runtimeType.toString()),
      Perk.addCard(
          DamageChangeCard.withInfusion(
              2, Infusion.ice, this.runtimeType.toString()),
          Perk.TWO_PERKS_AVAILABLE,
          'Add one +2 [ICE INFUSION] card'),
      Perk.addTwoRollingPlusOnes(
          Perk.TWO_PERKS_AVAILABLE, this.runtimeType.toString()),
      Perk.addCards(
          AttackEffectCard(AttackEffect.pull, 1, this.runtimeType.toString())
              .times(3),
          Perk.ONE_PERK_AVAILABLE,
          'Add three [ROLLING] [PULL 1] cards'),
      Perk.addCards(
          ConditionCard(Condition.muddle, this.runtimeType.toString()).times(3),
          Perk.ONE_PERK_AVAILABLE,
          'Add three [ROLLING] [MUDDLE] cards'),
      Perk.addCards(
          ConditionCard(Condition.immobilize, this.runtimeType.toString())
              .times(2),
          Perk.ONE_PERK_AVAILABLE,
          'Add two [ROLLING] [IMMOBILIZE] cards'),
      Perk.addCard(ConditionCard(Condition.stun, this.runtimeType.toString()),
          Perk.ONE_PERK_AVAILABLE, 'Add one [ROLLING] [STUN] card'),
      Perk.addCards([
        ConditionCard(Condition.disarm, this.runtimeType.toString()),
        ConditionCard(Condition.muddle, this.runtimeType.toString())
      ], Perk.ONE_PERK_AVAILABLE,
          'Add one [ROLLING] [DISARM] card and one [ROLLING] [MUDDLE] card')
    ];
  }
}
