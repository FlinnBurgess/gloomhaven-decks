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
      Perk.replaceMinusTwoWithZero(Perk.ONE_PERK_AVAILABLE,
          'images/cards/plagueherald/plus-0-damage.png'),
      Perk.replaceCard(
          DamageChangeCard(-1, 'images/cards/base/minus-1-damage.png'),
          DamageChangeCard(1, 'images/cards/plagueherald/plus-1-damage.png'),
          Perk.TWO_PERKS_AVAILABLE,
          'Replace one -1 card with one +1 card'),
      Perk.replaceCard(
          DamageChangeCard(0, 'images/cards/base/plus-0-damage.png'),
          DamageChangeCard(2, 'images/cards/plagueherald/plus-2-damage.png'),
          Perk.TWO_PERKS_AVAILABLE,
          'Replace one +0 card with one +2 card'),
      Perk.addCards(
          DamageChangeCard(1, 'images/cards/plagueherald/plus-1-damage.png')
              .times(2),
          Perk.ONE_PERK_AVAILABLE,
          'Add two +1 cards'),
      Perk.addCard(
          DamageChangeCard.withInfusion(1, Infusion.air,
              'images/cards/plagueherald/plus-1-damage-and-air.png'),
          Perk.THREE_PERKS_AVAILABLE,
          'Add one +1 [AIR INFUSION] card'),
      Perk.addCards(
          ConditionCard(Condition.poison,
                  'images/cards/plagueherald/rolling-poison.png')
              .times(3),
          Perk.ONE_PERK_AVAILABLE,
          'Add three [ROLLING] [POISON] cards'),
      Perk.addCards(
          ConditionCard(Condition.curse,
                  'images/cards/plagueherald/rolling-curse.png')
              .times(2),
          Perk.ONE_PERK_AVAILABLE,
          'Add two [ROLLING] [CURSE] cards'),
      Perk.addCards(
          ConditionCard(Condition.immobilize,
                  'images/cards/plagueherald/rolling-immobilize.png')
              .times(2),
          Perk.ONE_PERK_AVAILABLE,
          'Add two [ROLLING] [IMMOBILIZE] cards'),
      Perk.addCard(
          ConditionCard(
              Condition.stun, 'images/cards/plagueherald/rolling-stun.png'),
          Perk.TWO_PERKS_AVAILABLE,
          'Add one [ROLLING] [STUN] card'),
      Perk.addCards(
          DamageChangeCard(1, 'images/cards/plagueherald/plus-1-damage.png')
              .times(2),
          Perk.ONE_PERK_AVAILABLE,
          'Ignore negative scenario effects and add one +1 card'),
    ];
  }
}
