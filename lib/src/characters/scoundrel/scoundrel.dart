import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Scoundrel extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Scoundrel(this.name) {
    perks = [
      Perk.removeTwoMinusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.removeFourZeros(Perk.ONE_PERK_AVAILABLE),
      Perk.replaceMinusTwoWithZero(Perk.ONE_PERK_AVAILABLE),
      Perk.replaceCard(
          DamageChangeCard.minusOne(),
          DamageChangeCard.plusOne(),
          Perk.ONE_PERK_AVAILABLE,
          'Replace one -1 card with one +1 card'),
      Perk.replaceCard(DamageChangeCard.zero(), DamageChangeCard.plusTwo(),
          Perk.TWO_PERKS_AVAILABLE, 'Replace one +0 card with one +2 card'),
      Perk.addTwoRollingPlusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.addCards(AttackEffectCard(AttackEffect.pierce, 3, true).times(2),
          Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [PIERCE 3] cards'),
      Perk.addCards(ConditionCard(Condition.poison, true).times(2),
          Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] [POISON] cards'),
      Perk.addCards(ConditionCard(Condition.muddle, true).times(2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [MUDDLE] cards'),
      Perk.addCard(ConditionCard(Condition.invisible, true),
          Perk.ONE_PERK_AVAILABLE, 'Add one [ROLLING] [INVISIBLE] perk'),
    ];
  }
}
