import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Doomstalker extends Character {
  String name;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();

  Doomstalker(this.name) {
    characterIcon = CharacterIcons.doomstalker_icon;
    backgroundImagePath = 'images/backgrounds/doomstalker.png';
    var characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.replaceCards(
          DamageChangeCard.base(0).times(2),
          DamageChangeCard.forCharacter(1, characterClass).times(2),
          THREE_AVAILABLE,
          'Replace two +0 cards with two +1 cards'),
      Perk.addTwoRollingPlusOnes(TWO_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withCondition(2, Condition.muddle, characterClass),
          ONE_AVAILABLE,
          'Add one +2 MUDDLE [MUDDLE] card'),
      Perk.addCard(
          DamageChangeCard.withCondition(1, Condition.poison, characterClass),
          ONE_AVAILABLE,
          'Add one +1 POISON [POISON] card'),
      Perk.addPlusOneAndWoundCard(ONE_AVAILABLE, characterClass),
      Perk.addPlusOneAndImmobilizeCard(ONE_AVAILABLE, characterClass),
      Perk.addOnePlusZeroAndStunCard(ONE_AVAILABLE, characterClass),
      Perk.addOneRollingAddTargetCard(TWO_AVAILABLE, characterClass),
      Perk.ignoreNegativeScenarioEffects()
    ];
  }
}
