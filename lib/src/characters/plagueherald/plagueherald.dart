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

    perks = [
      Perk.replaceMinusTwoWithZero(ONE_AVAILABLE, this.runtimeType.toString()),
      Perk.replaceCard(
          DamageChangeCard.base(-1),
          DamageChangeCard.forCharacter(1, this.runtimeType.toString()),
          TWO_AVAILABLE,
          'Replace one -1 card with one +1 card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.forCharacter(2, this.runtimeType.toString()),
          TWO_AVAILABLE,
          'Replace one +0 card with one +2 card'),
      Perk.addCards(
          DamageChangeCard.forCharacter(1, this.runtimeType.toString())
              .times(2),
          ONE_AVAILABLE,
          'Add two +1 cards'),
      Perk.addCard(
          DamageChangeCard.withInfusion(
              1, Infusion.air, this.runtimeType.toString()),
          THREE_AVAILABLE,
          'Add one +1 [AIR INFUSION] card'),
      Perk.addCards(
          ConditionCard(Condition.poison, this.runtimeType.toString()).times(3),
          ONE_AVAILABLE,
          'Add three [ROLLING] [POISON] cards'),
      Perk.addCards(
          ConditionCard(Condition.curse, this.runtimeType.toString()).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [CURSE] cards'),
      Perk.addCards(
          ConditionCard(Condition.immobilize, this.runtimeType.toString())
              .times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [IMMOBILIZE] cards'),
      Perk.addCard(ConditionCard(Condition.stun, this.runtimeType.toString()),
          TWO_AVAILABLE, 'Add one [ROLLING] [STUN] card'),
      Perk.addCards(
          DamageChangeCard.forCharacter(1, this.runtimeType.toString())
              .times(2),
          ONE_AVAILABLE,
          'Ignore negative scenario effects and add one +1 card'),
    ];
  }
}
