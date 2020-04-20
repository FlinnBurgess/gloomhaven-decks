import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Mindthief extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Mindthief(this.name) {
    perks = [
      Perk.removeTwoMinusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.removeFourZeros(Perk.ONE_PERK_AVAILABLE),
      Perk.replaceCards(
          DamageChangeCard.plusOne().times(2),
          DamageChangeCard.plusTwo().times(2),
          Perk.ONE_PERK_AVAILABLE,
          'Replace two +1 cards with two +2 cards'),
      Perk.replaceMinusTwoWithZero(Perk.ONE_PERK_AVAILABLE),
      Perk.addCard(DamageChangeCard.withInfusion(2, Infusion.ice, false),
          Perk.TWO_PERKS_AVAILABLE, 'Add one +2 [ICE INFUSION] card'),
      Perk.addTwoRollingPlusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.addCards(AttackEffectCard(AttackEffect.pull, 1).times(3),
          Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [PULL 1] cards'),
      Perk.addCards(ConditionCard(Condition.muddle).times(3),
          Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [MUDDLE] cards'),
      Perk.addCards(ConditionCard(Condition.immobilize).times(2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [IMMOBILIZE] cards'),
      Perk.addCard(ConditionCard(Condition.stun), Perk.ONE_PERK_AVAILABLE,
          'Add one [ROLLING] [STUN] card'),
      Perk.addCards([
        ConditionCard(Condition.disarm),
        ConditionCard(Condition.muddle)
      ], Perk.ONE_PERK_AVAILABLE,
          'Add one [ROLLING] [DISARM] card and one [ROLLING] [MUDDLE] card')
    ];
  }
}
