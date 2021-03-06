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
    backgroundImagePath = 'images/backgrounds/plagueherald.png';
    characterIcon = CharacterIcons.plagueherald_icon;
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.replaceMinusTwoWithZero(ONE_AVAILABLE, characterClass),
      Perk.replaceMinusOneWithPlusOne(TWO_AVAILABLE, characterClass),
      Perk.replaceZeroWithPlusTwo(TWO_AVAILABLE, characterClass),
      Perk.addCards(DamageChangeCard.forCharacter(1, characterClass).times(2),
          ONE_AVAILABLE, 'Add two +1 cards'),
      Perk.addCard(
          DamageChangeCard.withInfusion(1, Infusion.air, characterClass),
          THREE_AVAILABLE,
          'Add one +1 [AIR INFUSION] card'),
      Perk.addCards(ConditionCard(Condition.poison, characterClass).times(3),
          ONE_AVAILABLE, 'Add three [ROLLING] POISON [POISON] cards'),
      Perk.addCards(ConditionCard(Condition.curse, characterClass).times(2),
          ONE_AVAILABLE, 'Add two [ROLLING] CURSE [CURSE] cards'),
      Perk.addCards(
          ConditionCard(Condition.immobilize, characterClass).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] IMMOBILIZE [IMMOBILIZE] cards'),
      Perk.addOneRollingStunCard(TWO_AVAILABLE, characterClass),
      Perk.ignoreNegativeScenarioEffectsAndAddOnePlusOneCard(characterClass),
    ];
  }
}
