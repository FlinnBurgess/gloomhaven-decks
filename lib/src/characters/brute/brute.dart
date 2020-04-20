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
      Perk.replaceCard(
          DamageChangeCard(-1),
          DamageChangeCard(1),
          Perk.ONE_PERK_AVAILABLE,
          'Replace one -1 card with one +1 card'),
      Perk.addTwoPlusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.addCard(DamageChangeCard(3), Perk.ONE_PERK_AVAILABLE,
          'Add one +3 card'),
      Perk.addCards(AttackEffectCard(AttackEffect.push, 1).times(3),
          Perk.TWO_PERKS_AVAILABLE, 'Add three [ROLLING] [PUSH 1] cards'),
      Perk.addCards(AttackEffectCard(AttackEffect.pierce, 3).times(2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [PIERCE 3] cards'),
      Perk.addCard(ConditionCard(Condition.stun),
          Perk.TWO_PERKS_AVAILABLE, 'Add one [ROLLING] [STUN] card'),
      Perk.addCards([
        ConditionCard(Condition.disarm),
        ConditionCard(Condition.muddle)
      ], Perk.ONE_PERK_AVAILABLE,
          'Add one [ROLLING] [DISARM] card and one [ROLLING] [MUDDLE] card'),
      Perk.addCard(AttackEffectCard(AttackEffect.addTarget, 1),
          Perk.TWO_PERKS_AVAILABLE, 'Add one [ROLLING] [ADD TARGET] card'),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(1, AttackEffect.shield, 1),
          Perk.ONE_PERK_AVAILABLE,
          'Add one +1 [SHIELD 1], Self card'),
      Perk.addCard(DamageChangeCard(1), Perk.ONE_PERK_AVAILABLE,
          'Ignore negative item effects and add one +1 card')
    ];
  }
}
