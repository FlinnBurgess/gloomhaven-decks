import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
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

    perks = [
      Perk.removeTwoMinusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.removeFourZeros(Perk.ONE_PERK_AVAILABLE),
      Perk.replaceMinusTwoWithZero(
          Perk.ONE_PERK_AVAILABLE, 'images/cards/scoundrel/plus-0-damage.png'),
      Perk.replaceCard(
          DamageChangeCard(-1, 'images/cards/base/minus-1-damage.png'),
          DamageChangeCard(1, 'images/cards/scoundrel/plus-1-damage.png'),
          Perk.ONE_PERK_AVAILABLE,
          'Replace one -1 card with one +1 card'),
      Perk.replaceCard(
          DamageChangeCard(0, 'images/cards/base/plus-0-damage.png'),
          DamageChangeCard(2, 'images/cards/scoundrel/plus-2-damage.png'),
          Perk.TWO_PERKS_AVAILABLE, 'Replace one +0 card with one +2 card'),
      Perk.addTwoRollingPlusOnes(Perk.TWO_PERKS_AVAILABLE,
          'images/cards/scoundrel/rolling-plus-1-damage.png'),
      Perk.addCards(AttackEffectCard(
          AttackEffect.pierce, 3, 'images/cards/scoundrel/rolling-pierce-3.png')
          .times(
          2),
          Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [PIERCE 3] cards'),
      Perk.addCards(
          ConditionCard(
              Condition.poison, 'images/cards/scoundrel/rolling-poison.png')
              .times(2),
          Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] [POISON] cards'),
      Perk.addCards(
          ConditionCard(
              Condition.muddle, 'images/cards/scoundrel/rolling-muddle.png')
              .times(2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [MUDDLE] cards'),
      Perk.addCard(ConditionCard(
          Condition.invisible, 'images/cards/scoundrel/rolling-invisible.png'),
          Perk.ONE_PERK_AVAILABLE, 'Add one [ROLLING] [INVISIBLE] perk'),
    ];
  }
}
