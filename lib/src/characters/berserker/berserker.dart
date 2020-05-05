import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Berserker extends Character {
  String name;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();

  Berserker(this.name) {
    characterIcon = CharacterIcons.berserker_icon;
    backgroundImagePath = 'images/backgrounds/berserker.png';
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(ONE_AVAILABLE),
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceMinusOneWithPlusOne(TWO_AVAILABLE, characterClass),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.forCharacter(2, characterClass).rolling(),
          TWO_AVAILABLE,
          'Replace one +0 card with one [ROLLING] +2 card'),
      Perk.addTwoRollingWoundCards(TWO_AVAILABLE, characterClass),
      Perk.addOneRollingStunCard(TWO_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withCondition(1, Condition.disarm, characterClass)
              .rolling(),
          ONE_AVAILABLE,
          'Add one [ROLLING] +1 DISARM [DISARM] card'),
      Perk.addTwoRollingHealOneCards(ONE_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withInfusion(2, Infusion.fire, characterClass),
          TWO_AVAILABLE,
          'Add one +2 [FIRE INFUSION] card')
    ];
  }
}
