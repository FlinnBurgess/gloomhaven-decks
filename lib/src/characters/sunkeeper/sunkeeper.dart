import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Sunkeeper extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Sunkeeper(this.name) {
    perks = [
      Perk.removeTwoMinusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.removeFourZeros(Perk.ONE_PERK_AVAILABLE),
      Perk.replaceMinusTwoWithZero(
          Perk.ONE_PERK_AVAILABLE, 'cards/sunkeeper/plus-0-damage.png'),
      Perk.replaceCard(DamageChangeCard(0, 'cards/base/plus-0-damage.png'),
          DamageChangeCard(2, 'cards/sunkeeper/plus-2-damage.png'),
          Perk.ONE_PERK_AVAILABLE, 'Replace one +0 card with one +2 card'),
      Perk.addTwoRollingPlusOnes(Perk.TWO_PERKS_AVAILABLE,
          'cards/sunkeeper/rolling-plus-1-damage.png'),
      Perk.addCards(AttackEffectCard(
          AttackEffect.heal, 1, 'cards/sunkeeper/rolling-heal-1-self.png')
          .times(2),
          Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] [HEAL 1] cards'),
      Perk.addCard(
          ConditionCard(Condition.stun, 'cards/sunkeeper/rolling-stun.png'),
          Perk.ONE_PERK_AVAILABLE,
          'Add one [ROLLING] [STUN] card'),
      Perk.addCards(
          InfusionCard(Infusion.light, 'cards/sunkeeper/rolling-light.png')
              .times(2),
          Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] [LIGHT INFUSION] cards'),
      Perk.addCards(AttackEffectCard(
          AttackEffect.shield, 1, 'cards/sunkeeper/rolling-shield-1.png').times(
          2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [SHIELD 1], Self cards'),
      Perk.addCards(
          DamageChangeCard(1, 'cards/sunkeeper/plus-1-damage.png').times(2),
          Perk.ONE_PERK_AVAILABLE,
          'Ignore negative item effects and add two +1 cards')
    ];
  }
}
