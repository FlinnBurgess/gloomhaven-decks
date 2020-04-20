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
      Perk.replacement(DamageChangeCard.plusOne().times(2), DamageChangeCard.plusTwo().times(2), Perk.ONE_PERK_AVAILABLE, 'Replace two +1 cards with two +2 cards'),
      Perk.replacement([DamageChangeCard.minusTwo()], [DamageChangeCard.zero()], Perk.ONE_PERK_AVAILABLE, 'Replace one -2 card with one +0 card'),
      Perk.additive([DamageChangeCard.withInfusion(2, Infusion.ice, false)], Perk.TWO_PERKS_AVAILABLE, 'Add one +2 [ICE INFUSION] card'),
      Perk.additive(DamageChangeCard(1, true).times(2), Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] +1 cards'),
      Perk.additive(AttackEffectCard(AttackEffect.pull, 1, true).times(3), Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [PULL 1] cards'),
      Perk.additive(ConditionCard(Condition.muddle, true).times(3), Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [MUDDLE] cards'),
      Perk.additive(ConditionCard(Condition.immobilize, true).times(2), Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [IMMOBILIZE] cards'),
      Perk.additive([ConditionCard(Condition.stun, true)], Perk.ONE_PERK_AVAILABLE, 'Add one [ROLLING] [STUN] card'),
      Perk.additive([ConditionCard(Condition.disarm, true), ConditionCard(Condition.muddle, true)], Perk.ONE_PERK_AVAILABLE, 'Add one [ROLLING] [DISARM] card and one [ROLLING] [MUDDLE] card')
    ];
  }
}