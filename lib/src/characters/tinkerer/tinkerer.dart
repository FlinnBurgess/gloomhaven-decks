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
      Perk.replaceMinusTwoWithZero(
          Perk.ONE_PERK_AVAILABLE, 'cards/tinkerer/plus-0-damage.png'),
      Perk.addTwoPlusOnes(
          Perk.ONE_PERK_AVAILABLE, 'cards/tinkerer/plus-1-damage.png'),
      Perk.addCard(
          DamageChangeCard(3, 'cards/tinkerer/plus-3-damage.png'),
          Perk.ONE_PERK_AVAILABLE, 'Add one +3 card'),
      Perk.addCards(
          InfusionCard(Infusion.fire, 'cards/tinkerer/rolling-fire.png').times(
              2),
          Perk.TWO_PERKS_AVAILABLE, 'Add two [ROLLING] [FIRE INFUSION] cards'),
      Perk.addCards(
          ConditionCard(Condition.muddle, 'cards/tinkerer/rolling-muddle.png')
              .times(3),
          Perk.ONE_PERK_AVAILABLE, 'Add three [ROLLING] [MUDDLE] cards'),
      Perk.addCard(DamageChangeCard.withCondition(
          1, Condition.wound, 'cards/tinkerer/plus-1-damage-and-wound.png'),
          Perk.TWO_PERKS_AVAILABLE, 'Add one +1 [WOUND] card'),
      Perk.addCard(DamageChangeCard.withCondition(1, Condition.immobilize,
          'cards/tinkerer/plus-1-damage-and-immobilize.png'),
          Perk.TWO_PERKS_AVAILABLE, 'Add one +1 [IMMOBILIZE] card'),
      Perk.addCard(DamageChangeCard.withAttackEffect(1, AttackEffect.heal, 2,
          'cards/tinkerer/plus-1-damage-and-heal-2.png'),
          Perk.TWO_PERKS_AVAILABLE, 'Add one +1 [HEAL 2] card'),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(
              0, AttackEffect.addTarget, 1, 'cards/tinkerer/add-target-1.png'),
          Perk.ONE_PERK_AVAILABLE,
          'Add one +0 [ADD TARGET] card')
    ];
  }
}
