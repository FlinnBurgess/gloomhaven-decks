import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character.dart';

class Berserker extends Character {
  String name;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  Icon characterIcon = Icon(CharacterIcons.berserker_icon);

  Berserker(this.name) {
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(ONE_AVAILABLE),
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceMinusOneWithPlusOne(TWO_AVAILABLE, characterClass),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.forCharacter(2, characterClass).rolling(),
          TWO_AVAILABLE,
          'Replace one +0 card with one [ROLLING] +2 card'),
      Perk.addCards(ConditionCard(Condition.wound, characterClass).times(2),
          TWO_AVAILABLE, 'Add two [ROLLING] [WOUND] cards'),
      Perk.addOneRollingStunCard(TWO_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withCondition(1, Condition.disarm, characterClass)
              .rolling(),
          ONE_AVAILABLE,
          'Add one [ROLLING] +1 [DISARM] card'),
      Perk.addTwoRollingHealOneCards(ONE_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withInfusion(2, Infusion.fire, characterClass),
          TWO_AVAILABLE,
          'Add one +2 [FIRE INFUSION] card')
    ];
  }
}
