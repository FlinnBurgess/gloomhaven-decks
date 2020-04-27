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

class Quartermaster extends Character {
  String name;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  Icon characterIcon = Icon(CharacterIcons.quartermaster_icon);

  Quartermaster(this.name) {
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceZeroWithPlusTwo(TWO_AVAILABLE, characterClass),
      Perk.addTwoRollingPlusOnes(TWO_AVAILABLE, characterClass),
      Perk.addCards(ConditionCard(Condition.muddle, characterClass).times(3),
          ONE_AVAILABLE, 'Add three [ROLLING] [MUDDLE] cards'),
      Perk.addCards(
          AttackEffectCard(AttackEffect.pierce, 3, characterClass).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] [PIERCE 3] cards'),
      Perk.addOneRollingStunCard(ONE_AVAILABLE, characterClass),
      Perk.addOneRollingAddTargetCard(ONE_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(
              0, AttackEffect.refreshItem, 1, characterClass),
          THREE_AVAILABLE,
          'Add one +0 refresh an item card'),
      Perk.ignoreNegativeScenarioEffectsAndAddTwoPlusOneCards(characterClass)
    ];
  }
}
