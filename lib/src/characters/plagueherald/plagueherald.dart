import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Plagueherald extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Plagueherald(this.name) {
    characterIcon = Icon(CharacterIcons.plagueherald_icon);
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.replaceMinusTwoWithZero(ONE_AVAILABLE, characterClass),
      Perk.replaceMinusOneWithPlusOne(TWO_AVAILABLE, characterClass),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.forCharacter(2, characterClass),
          TWO_AVAILABLE,
          'Replace one +0 card with one +2 card'),
      Perk.addCards(
          DamageChangeCard.forCharacter(1, characterClass)
              .times(2),
          ONE_AVAILABLE,
          'Add two +1 cards'),
      Perk.addCard(
          DamageChangeCard.withInfusion(
              1, Infusion.air, characterClass),
          THREE_AVAILABLE,
          'Add one +1 [AIR INFUSION] card'),
      Perk.addCards(
          ConditionCard(Condition.poison, characterClass).times(3),
          ONE_AVAILABLE,
          'Add three [ROLLING] [POISON] cards'),
      Perk.addCards(
          ConditionCard(Condition.curse, characterClass).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [CURSE] cards'),
      Perk.addCards(
          ConditionCard(Condition.immobilize, characterClass)
              .times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [IMMOBILIZE] cards'),
      Perk.addCard(ConditionCard(Condition.stun, characterClass),
          TWO_AVAILABLE, 'Add one [ROLLING] [STUN] card'),
      Perk.addCards(
          DamageChangeCard.forCharacter(1, characterClass)
              .times(2),
          ONE_AVAILABLE,
          'Ignore negative scenario effects and add one +1 card'),
    ];
  }
}
