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
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceMinusTwoWithZero(ONE_AVAILABLE, this.runtimeType.toString()),
      Perk.replaceCard(
          DamageChangeCard.base(-1),
          DamageChangeCard.forCharacter(1, this.runtimeType.toString()),
          ONE_AVAILABLE,
          'Replace one -1 card with one +1 card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.forCharacter(2, this.runtimeType.toString()),
          TWO_AVAILABLE,
          'Replace one +0 card with one +2 card'),
      Perk.addTwoRollingPlusOnes(TWO_AVAILABLE, this.runtimeType.toString()),
      Perk.addCards(
          AttackEffectCard(AttackEffect.pierce, 3, this.runtimeType.toString())
              .times(2),
          ONE_AVAILABLE,
          'Add three [ROLLING] [PIERCE 3] cards'),
      Perk.addCards(
          ConditionCard(Condition.poison, this.runtimeType.toString()).times(2),
          TWO_AVAILABLE,
          'Add two [ROLLING] [POISON] cards'),
      Perk.addCards(
          ConditionCard(Condition.muddle, this.runtimeType.toString()).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [MUDDLE] cards'),
      Perk.addCard(
          ConditionCard(Condition.invisible, this.runtimeType.toString()),
          ONE_AVAILABLE,
          'Add one [ROLLING] [INVISIBLE] perk'),
    ];
  }
}
