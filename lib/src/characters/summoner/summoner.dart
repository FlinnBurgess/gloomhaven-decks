import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Summoner extends Character {
  String name;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();

  Summoner(this.name) {
    characterIcon = CharacterIcons.summoner_icon;
    backgroundImagePath = 'images/backgrounds/summoner.png';
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(ONE_AVAILABLE),
      Perk.replaceMinusTwoWithZero(ONE_AVAILABLE, characterClass),
      Perk.replaceMinusOneWithPlusOne(THREE_AVAILABLE, characterClass),
      Perk.addCard(DamageChangeCard.forCharacter(2, characterClass),
          TWO_AVAILABLE, 'Add one +2 card'),
      Perk.addTwoRollingWoundCards(ONE_AVAILABLE, characterClass),
      Perk.addCards(ConditionCard(Condition.poison, characterClass).times(2),
          ONE_AVAILABLE, 'Add two [ROLLING] [POISON] cards'),
      Perk.addTwoRollingHealOneCards(THREE_AVAILABLE, characterClass),
      Perk.addCards([
        InfusionCard(Infusion.fire, characterClass),
        InfusionCard(Infusion.air, characterClass)
      ], ONE_AVAILABLE,
          'Add one [ROLLING] [FIRE INFUSION] card and one [ROLLING] [AIR INFUSION] card'),
      Perk.addCards([
        InfusionCard(Infusion.dark, characterClass),
        InfusionCard(Infusion.earth, characterClass)
      ], ONE_AVAILABLE,
          'Add one [ROLLING] [DARK INFUSION] card and one [ROLLING] [EARTH INFUSION] card'),
      Perk.ignoreNegativeScenarioEffectsAndAddTwoPlusOneCards(characterClass)
    ];
  }
}
