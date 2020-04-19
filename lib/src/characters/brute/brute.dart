import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Brute extends Character {
  String name;
  AttackModifierDeck attackModifierDeck;
  List<Perk> perks;

  Brute(this.name) {
    attackModifierDeck = AttackModifierDeck();

    perks = [
      Perk.removeTwoMinusOnes(Perk.ONE_PERK_AVAILABLE),
      Perk.replacement(
          [DamageChangeCard.minusOne()],
          [DamageChangeCard.plusOne()],
          Perk.ONE_PERK_AVAILABLE,
          'Replace one -1 card with one +1 card'),
      Perk.addTwoPlusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.additive([DamageChangeCard(3, false)], Perk.ONE_PERK_AVAILABLE,
          'Add one +3 card'),
      Perk.additive(AttackEffectCard(AttackEffect.push, 1, true).times(3),
          Perk.TWO_PERKS_AVAILABLE, 'Add three [ROLLING] [PUSH 1] cards'),
      Perk.additive(AttackEffectCard(AttackEffect.pierce, 3, true).times(2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [PIERCE 3] cards'),
      Perk.additive([ConditionCard(Condition.stun, true)],
          Perk.TWO_PERKS_AVAILABLE, 'Add one [ROLLING] [STUN] card'),
      Perk.additive([
        ConditionCard(Condition.disarm, true),
        ConditionCard(Condition.muddle, true)
      ], Perk.ONE_PERK_AVAILABLE,
          'Add one [ROLLING] [DISARM] card and one [ROLLING] [MUDDLE] card'),
      Perk.additive([AttackEffectCard(AttackEffect.addTarget, 1, true)],
          Perk.TWO_PERKS_AVAILABLE, 'Add one [ROLLING] [ADD TARGET] card'),
      Perk.additive(
          [DamageChangeCard.withAttackEffect(1, AttackEffect.shield, 1, false)],
          Perk.ONE_PERK_AVAILABLE,
          'Add one +1 [SHIELD 1], Self card'),
      Perk.additive([DamageChangeCard(1, false)], Perk.ONE_PERK_AVAILABLE,
          'Ignore negative item effects and add one +1 card')
    ];
  }
}