import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
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

    perks = [
      Perk.removeTwoMinusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.removeFourZeros(Perk.ONE_PERK_AVAILABLE),
      Perk.replaceMinusTwoWithZero(
          Perk.ONE_PERK_AVAILABLE, this.runtimeType.toString()),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.forCharacter(2, this.runtimeType.toString()),
          Perk.ONE_PERK_AVAILABLE, 'Replace one +0 card with one +2 card'),
      Perk.addTwoRollingPlusOnes(Perk.TWO_PERKS_AVAILABLE,
          this.runtimeType.toString()),
      Perk.addCards(AttackEffectCard(
          AttackEffect.heal, 1,
          this.runtimeType.toString())
          .times(2),
          Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] [HEAL 1] cards'),
      Perk.addCard(
          ConditionCard(
              Condition.stun, this.runtimeType.toString()),
          Perk.ONE_PERK_AVAILABLE,
          'Add one [ROLLING] [STUN] card'),
      Perk.addCards(
          InfusionCard(
              Infusion.light, this.runtimeType.toString())
              .times(2),
          Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] [LIGHT INFUSION] cards'),
      Perk.addCards(AttackEffectCard(
          AttackEffect.shield, 1, this.runtimeType.toString())
          .times(
          2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [SHIELD 1], Self cards'),
      Perk.addCards(
          DamageChangeCard.forCharacter(1, this.runtimeType.toString()).times(
              2),
          Perk.ONE_PERK_AVAILABLE,
          'Ignore negative item effects and add two +1 cards')
    ];
  }
}
