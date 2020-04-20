import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Nightshroud extends Character {
  String name;
  AttackModifierDeck attackModifierDeck;
  List<Perk> perks;

  Nightshroud(this.name) {
    attackModifierDeck = AttackModifierDeck();
    perks = [
      Perk.removeTwoMinusOnes(Perk.TWO_PERKS_AVAILABLE),
      Perk.removeFourZeros(Perk.ONE_PERK_AVAILABLE),
      Perk.addCard(DamageChangeCard.withInfusion(-1, Infusion.dark, false),
          Perk.TWO_PERKS_AVAILABLE, 'Add one -1 and [dark infusion] card'),
      Perk.replaceCard(
          DamageChangeCard.withInfusion(-1, Infusion.dark, false),
          DamageChangeCard.withInfusion(1, Infusion.dark, false),
          Perk.TWO_PERKS_AVAILABLE,
          'Replace one -1 and [dark infusion] card with one +1 and [dark infusion] card'),
      Perk.addCard(
          DamageChangeCard.withCondition(1, Condition.invisible, false),
          Perk.ONE_PERK_AVAILABLE,
          'Add one +1 [INVISIBLE] card'),
      Perk.addCards(ConditionCard(Condition.muddle, true).times(3),
          Perk.TWO_PERKS_AVAILABLE, 'Add three [ROLLING] [MUDDLE] cards'),
      Perk.addCards(AttackEffectCard(AttackEffect.heal, 1, true).times(2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [HEAL+1] cards'),
      Perk.addCards(ConditionCard(Condition.curse, true).times(2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [CURSE] cards'),
      Perk.addCard(AttackEffectCard(AttackEffect.addTarget, 1, true),
          Perk.ONE_PERK_AVAILABLE, 'Add one [ROLLING] [ADD TARGET] card'),
      Perk.addCards(
          DamageChangeCard.minusOne().times(2),
          Perk.ONE_PERK_AVAILABLE,
          'Ignore negative scenario effects and add two +1 cards'),
    ];
  }
}
