import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character_icons.dart';

class Mindthief extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Mindthief(this.name) {
    backgroundImagePath = 'images/backgrounds/mindthief.png';
    characterIcon = CharacterIcons.mindthief_icon;

    var characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceCards(
          DamageChangeCard.base(1).times(2),
          DamageChangeCard.forCharacter(2, characterClass).times(2),
          ONE_AVAILABLE,
          'Replace two +1 cards with two +2 cards'),
      Perk.replaceMinusTwoWithZero(ONE_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withInfusion(2, Infusion.ice, characterClass),
          TWO_AVAILABLE,
          'Add one +2 [ICE INFUSION] card'),
      Perk.addTwoRollingPlusOnes(TWO_AVAILABLE, characterClass),
      Perk.addCards(
          AttackEffectCard(AttackEffect.pull, 1, characterClass).times(3),
          ONE_AVAILABLE,
          'Add three [ROLLING] PULL [PULL] 1 cards'),
      Perk.addCards(ConditionCard(Condition.muddle, characterClass).times(3),
          ONE_AVAILABLE, 'Add three [ROLLING] MUDDLE [MUDDLE] cards'),
      Perk.addCards(
          ConditionCard(Condition.immobilize, characterClass).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] IMMOBILIZE [IMMOBILIZE] cards'),
      Perk.addOneRollingStunCard(ONE_AVAILABLE, characterClass),
      Perk.addCards([
        ConditionCard(Condition.disarm, characterClass),
        ConditionCard(Condition.muddle, characterClass)
      ], ONE_AVAILABLE,
          'Add one [ROLLING] DISARM [DISARM] card and one [ROLLING] MUDDLE [MUDDLE] card')
    ];
  }
}
