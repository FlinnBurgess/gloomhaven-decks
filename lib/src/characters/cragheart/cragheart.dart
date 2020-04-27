import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character_icons.dart';

class Cragheart extends Character {
  String name;
  AttackModifierDeck attackModifierDeck;
  List<Perk> perks;

  Cragheart(this.name) {
    attackModifierDeck = AttackModifierDeck();
    characterIcon = Icon(CharacterIcons.cragheart_icon);

    perks = [
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceMinusOneWithPlusOne(
          THREE_AVAILABLE, this.runtimeType.toString()),
      Perk.addCards(
          DamageChangeCard.forCharacter(2, this.runtimeType.toString())
              .times(2) +
              DamageChangeCard.forCharacter(-2, this.runtimeType.toString())
                  .times(1),
          ONE_AVAILABLE,
          'Add one -2 card and two +2 cards'),
      Perk.addCard(
          DamageChangeCard.withCondition(
              1, Condition.immobilize, this.runtimeType.toString()),
          TWO_AVAILABLE,
          'Add one +1 [IMMOBILIZE] card'),
      Perk.addCard(
          DamageChangeCard.withCondition(
              2, Condition.muddle, this.runtimeType.toString()),
          TWO_AVAILABLE,
          'Add one +2 [MUDDLE] card'),
      Perk.addCards(
          AttackEffectCard(AttackEffect.push, 2, this.runtimeType.toString())
              .times(2),
          ONE_AVAILABLE,
          'Add two [PUSH 2] cards'),
      Perk.addCards(
          InfusionCard(Infusion.earth, this.runtimeType.toString()).times(2),
          TWO_AVAILABLE,
          'Add two [ROLLING] [EARTH INFUSION] cards'),
      Perk.addCards(
          InfusionCard(Infusion.air, this.runtimeType.toString()).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [AIR INFUSION] cards')
    ];
  }
}
