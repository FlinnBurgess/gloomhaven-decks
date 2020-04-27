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

    var characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(ONE_AVAILABLE),
      Perk.replaceMinusOneWithPlusOne(ONE_AVAILABLE, characterClass),
      Perk.addTwoPlusOnes(TWO_AVAILABLE, characterClass),
      Perk.addCard(DamageChangeCard.forCharacter(3, characterClass),
          ONE_AVAILABLE, 'Add one +3 card'),
      Perk.addCards(
          AttackEffectCard(AttackEffect.push, 1, characterClass).times(3),
          TWO_AVAILABLE,
          'Add three [ROLLING] [PUSH 1] cards'),
      Perk.addCards(
          AttackEffectCard(AttackEffect.pierce, 3, characterClass).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [PIERCE 3] cards'),
      Perk.addOneRollingStunCard(TWO_AVAILABLE, characterClass),
      Perk.addCards([
        ConditionCard(Condition.disarm, characterClass),
        ConditionCard(Condition.muddle, characterClass)
      ], ONE_AVAILABLE,
          'Add one [ROLLING] [DISARM] card and one [ROLLING] [MUDDLE] card'),
      Perk.addCard(AttackEffectCard(AttackEffect.addTarget, 1, characterClass),
          TWO_AVAILABLE, 'Add one [ROLLING] [ADD TARGET] card'),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(
              1, AttackEffect.shield, 1, characterClass),
          ONE_AVAILABLE,
          'Add one +1 [SHIELD 1], Self card'),
      Perk.addCard(DamageChangeCard.forCharacter(1, characterClass),
          ONE_AVAILABLE, 'Ignore negative item effects and add one +1 card')
    ];
  }
}
