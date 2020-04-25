import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Brute extends Character {
  String name;
  AttackModifierDeck attackModifierDeck;
  List<Perk> perks;

  Brute(this.name) {
    attackModifierDeck = AttackModifierDeck();
    characterIcon = Icon(CharacterIcons.brute_icon);

    perks = [
      Perk.removeTwoMinusOnes(ONE_AVAILABLE),
      Perk.replaceCard(
          DamageChangeCard.base(-1),
          DamageChangeCard.forCharacter(1, this.runtimeType.toString()),
          ONE_AVAILABLE,
          'Replace one -1 card with one +1 card'),
      Perk.addTwoPlusOnes(
          TWO_AVAILABLE, this.runtimeType.toString()),
      Perk.addCard(
          DamageChangeCard.forCharacter(3, this.runtimeType.toString()),
          ONE_AVAILABLE, 'Add one +3 card'),
      Perk.addCards(
          AttackEffectCard(
              AttackEffect.push, 1, this.runtimeType.toString())
              .times(3),
          TWO_AVAILABLE,
          'Add three [ROLLING] [PUSH 1] cards'),
      Perk.addCards(
          AttackEffectCard(
              AttackEffect.pierce, 3, this.runtimeType.toString())
              .times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [PIERCE 3] cards'),
      Perk.addCard(
          ConditionCard(Condition.stun, this.runtimeType.toString()),
          TWO_AVAILABLE,
          'Add one [ROLLING] [STUN] card'),
      Perk.addCards([
        ConditionCard(
            Condition.disarm, this.runtimeType.toString()),
        ConditionCard(Condition.muddle, this.runtimeType.toString())
      ], ONE_AVAILABLE,
          'Add one [ROLLING] [DISARM] card and one [ROLLING] [MUDDLE] card'),
      Perk.addCard(
          AttackEffectCard(AttackEffect.addTarget, 1,
              this.runtimeType.toString()),
          TWO_AVAILABLE,
          'Add one [ROLLING] [ADD TARGET] card'),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(1, AttackEffect.shield, 1,
              this.runtimeType.toString()),
          ONE_AVAILABLE,
          'Add one +1 [SHIELD 1], Self card'),
      Perk.addCard(
          DamageChangeCard.forCharacter(1, this.runtimeType.toString()),
          ONE_AVAILABLE,
          'Ignore negative item effects and add one +1 card')
    ];
  }
}
