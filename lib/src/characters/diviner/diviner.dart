import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character_icons.dart';

class Diviner extends Character {
  String name;
  AttackModifierDeck attackModifierDeck;
  List<Perk> perks;

  Diviner(this.name) {
    backgroundImagePath = 'images/backgrounds/diviner.png';
    attackModifierDeck = AttackModifierDeck();
    characterIcon = CharacterIcons.diviner_icon;
    var characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(2),
      Perk.removeCards(DamageChangeCard.base(-2).times(1), ONE_AVAILABLE,
          'Remove one -2 card'),
      Perk.replaceCards(
          DamageChangeCard.base(1).times(2),
          DamageChangeCard.withAttackEffect(
                  3, AttackEffect.shield, 1, characterClass)
              .times(1),
          TWO_AVAILABLE,
          'Replace two +1 cards with one +3 Shield [SHIELD] 1, Self card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withAttackEffect(
              1, AttackEffect.shield, 1, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +1 Shield [SHIELD] 1, Affect any ally card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withInfusion(2, Infusion.dark, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +2 [DARK INFUSION] card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withInfusion(2, Infusion.light, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +2 [LIGHT INFUSION] card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withCondition(3, Condition.muddle, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +3 MUDDLE [MUDDLE] card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withCondition(2, Condition.curse, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +2 CURSE [CURSE] card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withCondition(
              2, Condition.regenerate, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +2 REGENERATE [REGENERATE], Self card'),
      Perk.replaceCard(
          DamageChangeCard.base(-1),
          DamageChangeCard.withAttackEffect(
              1, AttackEffect.heal, 2, characterClass),
          ONE_AVAILABLE,
          'Replace one -1 card with one +1 Heal [HEAL] 2, Affect any ally card'),
      Perk.addCards(
          AttackEffectCard(AttackEffect.heal, 1, characterClass)
              .rolling()
              .times(2),
          TWO_AVAILABLE,
          'Add two [ROLLING] Heal [HEAL] 1, Self cards'),
      Perk.addCards(
          ConditionCard(Condition.curse, characterClass).rolling().times(2),
          TWO_AVAILABLE,
          'Add two [ROLLING] CURSE [CURSE] cards'),
      Perk.ignoreNegativeScenarioEffectsAndAddTwoPlusOneCards(characterClass)
    ];
  }
}
