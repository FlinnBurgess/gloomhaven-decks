import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Cragheart extends Character {
  String name;
  AttackModifierDeck attackModifierDeck;
  List<Perk> perks;

  Cragheart(this.name) {
    attackModifierDeck = AttackModifierDeck();

    perks = [
      Perk.removeFourZeros(Perk.ONE_PERK_AVAILABLE),
      Perk.replaceCard(
          DamageChangeCard.minusOne(),
          DamageChangeCard.plusOne(),
          Perk.THREE_PERKS_AVAILABLE,
          'Replace one -1 card with one +1 card'),
      Perk.addCards(
          DamageChangeCard.plusTwo().times(2) +
              DamageChangeCard.minusTwo().times(1),
          Perk.ONE_PERK_AVAILABLE,
          'Add one -2 card and two +2 cards'),
      Perk.addCard(
          DamageChangeCard.withCondition(1, Condition.immobilize, false),
          Perk.TWO_PERKS_AVAILABLE,
          'Add one +1 [IMMOBILIZE] card'),
      Perk.addCard(
          DamageChangeCard.withCondition(2, Condition.muddle, false),
          Perk.TWO_PERKS_AVAILABLE,
          'Add one +2 [MUDDLE] card'),
      Perk.addCards(AttackEffectCard(AttackEffect.push, 2, true).times(2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [PUSH 2] cards'),
      Perk.addCards(InfusionCard(Infusion.earth).times(2),
          Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] [EARTH INFUSION] cards'),
      Perk.addCards(InfusionCard(Infusion.air).times(2),
          Perk.ONE_PERK_AVAILABLE, 'Add two [ROLLING] [AIR INFUSION] cards')
    ];
  }
}
