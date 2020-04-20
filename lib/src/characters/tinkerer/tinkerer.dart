import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Tinkerer extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Tinkerer(this.name) {
    perks = [
      Perk.removeTwoMinusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.replaceMinusTwoWithZero(Perk.ONE_PERK_AVAILABLE),
      Perk.addTwoPlusOnes(Perk.ONE_PERK_AVAILABLE),
      Perk.additive([DamageChangeCard(3, false)], Perk.ONE_PERK_AVAILABLE,
          'Add one +3 card'),
      Perk.additive(InfusionCard(Infusion.fire, true).times(2),
          Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] [FIRE INFUSION] cards'),
      Perk.additive(ConditionCard(Condition.muddle, true).times(3),
          Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [MUDDLE] cards'),
      Perk.additive([DamageChangeCard.withCondition(1, Condition.wound, false)],
          Perk.TWO_PERKS_AVAILABLE, 'Add one +1 [WOUND] card'),
      Perk.additive(
          [DamageChangeCard.withCondition(1, Condition.immobilize, false)],
          Perk.TWO_PERKS_AVAILABLE,
          'Add one +1 [IMMOBILIZE] card'),
      Perk.additive(
          [DamageChangeCard.withAttackEffect(1, AttackEffect.heal, 2, false)],
          Perk.TWO_PERKS_AVAILABLE,
          'Add one +1 [HEAL 2] card'),
      Perk.additive([
        DamageChangeCard.withAttackEffect(0, AttackEffect.addTarget, 1, false)
      ], Perk.ONE_PERK_AVAILABLE, 'Add one +0 [ADD TARGET] card')
    ];
  }
}
