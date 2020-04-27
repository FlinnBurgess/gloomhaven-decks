import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character_icons.dart';

class Spellweaver extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Spellweaver(this.name) {
    characterIcon = Icon(CharacterIcons.spellweaver_icon);
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceMinusOneWithPlusOne(TWO_AVAILABLE, characterClass),
      Perk.addTwoPlusOnes(TWO_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withCondition(
              0, Condition.stun, characterClass),
          ONE_AVAILABLE,
          'Add one +0 [STUN] card'),
      Perk.addCard(
          DamageChangeCard.withCondition(
              1, Condition.wound, characterClass),
          ONE_AVAILABLE,
          'Add one +1 [WOUND] card'),
      Perk.addCard(
          DamageChangeCard.withCondition(
              1, Condition.immobilize, characterClass),
          ONE_AVAILABLE,
          'Add one +1 [IMMOBILIZE] card'),
      Perk.addCard(
          DamageChangeCard.withCondition(
              1, Condition.curse, characterClass),
          ONE_AVAILABLE,
          'Add one +1 [CURSE] card'),
      Perk.addCard(
          DamageChangeCard.withInfusion(
              2, Infusion.fire, characterClass),
          TWO_AVAILABLE,
          'Add one +2 [FIRE INFUSION] card'),
      Perk.addCard(
          DamageChangeCard.withInfusion(
              2, Infusion.ice, characterClass),
          TWO_AVAILABLE,
          'Add one +2 [ICE INFUSION] card'),
      Perk.addCards([
        InfusionCard(Infusion.earth, characterClass),
        InfusionCard(Infusion.air, characterClass)
      ], ONE_AVAILABLE, 'Add one [EARTH INFUSION] and one [AIR INFUSION] card'),
      Perk.addCards([
        InfusionCard(Infusion.light, characterClass),
        InfusionCard(Infusion.dark, characterClass)
      ], ONE_AVAILABLE,
          'Add one [LIGHT INFUSION] and one [DARK INFUSION] card'),
    ];
  }
}
