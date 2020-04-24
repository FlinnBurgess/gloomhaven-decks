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
      Perk.removeTwoMinusOnes(Perk.ONE_PERK_AVAILABLE),
      Perk.replaceCard(
          DamageChangeCard(-1, 'images/cards/base/minus-1-damage.png'),
          DamageChangeCard(1, 'images/cards/brute/plus-1-damage.png'),
          Perk.ONE_PERK_AVAILABLE,
          'Replace one -1 card with one +1 card'),
      Perk.addTwoPlusOnes(
          Perk.TWO_PERKS_AVAILABLE, 'images/cards/brute/plus-1-damage.png'),
      Perk.addCard(DamageChangeCard(3, 'images/cards/brute/plus-3-damage.png'),
          Perk.ONE_PERK_AVAILABLE, 'Add one +3 card'),
      Perk.addCards(
          AttackEffectCard(
              AttackEffect.push, 1, 'images/cards/brute/rolling-push-1.png')
              .times(3),
          Perk.TWO_PERKS_AVAILABLE,
          'Add three [ROLLING] [PUSH 1] cards'),
      Perk.addCards(
          AttackEffectCard(
              AttackEffect.pierce, 3, 'images/cards/brute/rolling-pierce-3.png')
              .times(2),
          Perk.ONE_PERK_AVAILABLE,
          'Add two [ROLLING] [PIERCE 3] cards'),
      Perk.addCard(
          ConditionCard(Condition.stun, 'images/cards/brute/rolling-stun.png'),
          Perk.TWO_PERKS_AVAILABLE,
          'Add one [ROLLING] [STUN] card'),
      Perk.addCards([
        ConditionCard(
            Condition.disarm, 'images/cards/brute/rolling-disarm.png'),
        ConditionCard(Condition.muddle, 'images/cards/brute/rolling-muddle.png')
      ], Perk.ONE_PERK_AVAILABLE,
          'Add one [ROLLING] [DISARM] card and one [ROLLING] [MUDDLE] card'),
      Perk.addCard(
          AttackEffectCard(AttackEffect.addTarget, 1,
              'images/cards/brute/rolling-add-target-1.png'),
          Perk.TWO_PERKS_AVAILABLE,
          'Add one [ROLLING] [ADD TARGET] card'),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(1, AttackEffect.shield, 1,
              'images/cards/brute/plus-1-damage-and-shield.png'),
          Perk.ONE_PERK_AVAILABLE,
          'Add one +1 [SHIELD 1], Self card'),
      Perk.addCard(
          DamageChangeCard(1, 'images/cards/brute/plus-1-damage.png'),
          Perk.ONE_PERK_AVAILABLE,
          'Ignore negative item effects and add one +1 card')
    ];
  }
}
