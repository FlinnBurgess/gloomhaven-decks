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
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.replaceMinusTwoWithZero(ONE_AVAILABLE, characterClass),
      Perk.addTwoPlusOnes(ONE_AVAILABLE, characterClass),
      Perk.addCard(DamageChangeCard.forCharacter(3, characterClass),
          ONE_AVAILABLE, 'Add one +3 card'),
      Perk.addCards(InfusionCard(Infusion.fire, characterClass).times(2),
          TWO_AVAILABLE, 'Add two [ROLLING] [FIRE INFUSION] cards'),
      Perk.addCards(ConditionCard(Condition.muddle, characterClass).times(3),
          ONE_AVAILABLE, 'Add three [ROLLING] [MUDDLE] cards'),
      Perk.addPlusOneAndWoundCard(TWO_AVAILABLE, characterClass),
      Perk.addPlusOneAndImmobilizeCard(TWO_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(
              1, AttackEffect.heal, 2, characterClass),
          TWO_AVAILABLE,
          'Add one +1 [HEAL 2] card'),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(
              0, AttackEffect.addTarget, 1, characterClass),
          ONE_AVAILABLE,
          'Add one +0 [ADD TARGET] card')
    ];
  }
}
