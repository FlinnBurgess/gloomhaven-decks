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
          DamageChangeCard(1, 'images/cards/base/plus-1-damage.png').times(2),
          DamageChangeCard(2, 'images/cards/mindthief/plus-2-damage.png').times(
              2),
          Perk.ONE_PERK_AVAILABLE,
          'Replace two +1 cards with two +2 cards'),
      Perk.replaceMinusTwoWithZero(
          Perk.ONE_PERK_AVAILABLE, 'images/cards/mindthief/plus-0-damage.png'),
      Perk.addCard(DamageChangeCard.withInfusion(
          2, Infusion.ice, 'images/cards/mindthief/plus-2-damage-and-ice.png'),
          Perk.TWO_PERKS_AVAILABLE, 'Add one +2 [ICE INFUSION] card'),
      Perk.addTwoRollingPlusOnes(Perk.TWO_PERKS_AVAILABLE,
          'images/cards/mindthief/rolling-plus-1-damage.png'),
      Perk.addCards(AttackEffectCard(
          AttackEffect.pull, 1, 'images/cards/mindthief/rolling-pull-1.png')
          .times(3),
          Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [PULL 1] cards'),
      Perk.addCards(
          ConditionCard(
              Condition.muddle, 'images/cards/mindthief/rolling-muddle.png')
              .times(3),
          Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [MUDDLE] cards'),
      Perk.addCards(ConditionCard(
          Condition.immobilize, 'images/cards/mindthief/rolling-immobilize.png')
          .times(
          2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [IMMOBILIZE] cards'),
      Perk.addCard(
          ConditionCard(
              Condition.stun, 'images/cards/mindthief/rolling-stun.png'),
          Perk.ONE_PERK_AVAILABLE,
          'Add one [ROLLING] [STUN] card'),
      Perk.addCards([
        ConditionCard(
            Condition.disarm, 'images/cards/mindthief/rolling-disarm.png'),
        ConditionCard(
            Condition.muddle, 'images/cards/mindthief/rolling-muddle.png')
      ], Perk.ONE_PERK_AVAILABLE,
          'Add one [ROLLING] [DISARM] card and one [ROLLING] [MUDDLE] card')
    ];
  }
}
