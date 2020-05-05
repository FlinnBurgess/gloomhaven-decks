import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character.dart';

class Elementalist extends Character {
  String name;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();

  Elementalist(this.name) {
    characterIcon = CharacterIcons.elementalist_icon;
    backgroundImagePath = 'images/backgrounds/elementalist.png';
    var characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.replaceMinusOneWithPlusOne(ONE_AVAILABLE, characterClass),
      Perk.replaceZeroWithPlusTwo(TWO_AVAILABLE, characterClass),
      Perk.addCards(
          DamageChangeCard.withInfusion(0, Infusion.fire, characterClass)
              .times(3),
          ONE_AVAILABLE,
          'Add three +0 [FIRE INFUSION] cards'),
      Perk.addCards(
          DamageChangeCard.withInfusion(0, Infusion.ice, characterClass)
              .times(3),
          ONE_AVAILABLE,
          'Add three +0 [ICE INFUSION] cards'),
      Perk.addCards(
          DamageChangeCard.withInfusion(0, Infusion.air, characterClass)
              .times(3),
          ONE_AVAILABLE,
          'Add three +0 [AIR INFUSION] cards'),
      Perk.addCards(
          DamageChangeCard.withInfusion(0, Infusion.earth, characterClass)
              .times(3),
          ONE_AVAILABLE,
          'Add three +0 [EARTH INFUSION] cards'),
      Perk.replaceCards(
          DamageChangeCard.base(0).times(2),
          [
            DamageChangeCard.withInfusion(0, Infusion.fire, characterClass),
            DamageChangeCard.withInfusion(0, Infusion.earth, characterClass)
          ],
          ONE_AVAILABLE,
          'Replace two +0 cards with one +0 [FIRE INFUSION] and one +0 [EARTH INFUSION] card'),
      Perk.replaceCards(
          DamageChangeCard.base(0).times(2),
          [
            DamageChangeCard.withInfusion(0, Infusion.ice, characterClass),
            DamageChangeCard.withInfusion(0, Infusion.air, characterClass)
          ],
          ONE_AVAILABLE,
          'Replace two +0 cards with one +0 [ICE INFUSION] and one +0 [AIR INFUSION] card'),
      Perk.addCards(
          DamageChangeCard.withAttackEffect(
                  1, AttackEffect.push, 1, characterClass)
              .times(2),
          ONE_AVAILABLE,
          'Add two +1 PUSH [PUSH] 1 cards'),
      Perk.addPlusOneAndWoundCard(ONE_AVAILABLE, characterClass),
      Perk.addOnePlusZeroAndStunCard(ONE_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(
              0, AttackEffect.addTarget, 1, characterClass),
          ONE_AVAILABLE,
          'Add one +0 ADD TARGET [ADD TARGET] card')
    ];
  }
}
