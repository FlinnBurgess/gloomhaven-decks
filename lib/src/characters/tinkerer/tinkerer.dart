import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character_icons.dart';

class Tinkerer extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Tinkerer(this.name) {
    characterIcon = Icon(CharacterIcons.tinkerer_icon);

    perks = [
      Perk.removeTwoMinusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.replaceMinusTwoWithZero(
          Perk.ONE_PERK_AVAILABLE, this.runtimeType.toString()),
      Perk.addTwoPlusOnes(
          Perk.ONE_PERK_AVAILABLE, this.runtimeType.toString()),
      Perk.addCard(
          DamageChangeCard.forCharacter(3, this.runtimeType.toString()),
          Perk.ONE_PERK_AVAILABLE, 'Add one +3 card'),
      Perk.addCards(
          InfusionCard(Infusion.fire, this.runtimeType.toString())
              .times(
              2),
          Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] [FIRE INFUSION] cards'),
      Perk.addCards(
          ConditionCard(
              Condition.muddle, this.runtimeType.toString())
              .times(3),
          Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [MUDDLE] cards'),
      Perk.addCard(DamageChangeCard.withCondition(
          1, Condition.wound,
          this.runtimeType.toString()),
          Perk.TWO_PERKS_AVAILABLE, 'Add one +1 [WOUND] card'),
      Perk.addCard(DamageChangeCard.withCondition(1, Condition.immobilize,
          this.runtimeType.toString()),
          Perk.TWO_PERKS_AVAILABLE, 'Add one +1 [IMMOBILIZE] card'),
      Perk.addCard(DamageChangeCard.withAttackEffect(1, AttackEffect.heal, 2,
          this.runtimeType.toString()),
          Perk.TWO_PERKS_AVAILABLE, 'Add one +1 [HEAL 2] card'),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(
              0, AttackEffect.addTarget, 1,
              this.runtimeType.toString()),
          Perk.ONE_PERK_AVAILABLE,
          'Add one +0 [ADD TARGET] card')
    ];
  }
}
