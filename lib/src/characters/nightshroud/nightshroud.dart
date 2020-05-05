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

class Nightshroud extends Character {
  String name;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  List<Perk> perks;

  Nightshroud(this.name) {
    backgroundImagePath = 'images/backgrounds/nightshroud.png';
    characterIcon = CharacterIcons.nightshroud_icon;
    var characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.addCard(
          DamageChangeCard.withInfusion(-1, Infusion.dark, characterClass),
          TWO_AVAILABLE,
          'Add one -1 and [dark infusion] card'),
      Perk.replaceCard(
          DamageChangeCard.withInfusion(-1, Infusion.dark, characterClass),
          DamageChangeCard.withInfusion(1, Infusion.dark, characterClass),
          TWO_AVAILABLE,
          'Replace one -1 and [dark infusion] card with one +1 and [dark infusion] card'),
      Perk.addCard(
          DamageChangeCard.withCondition(
              1, Condition.invisible, characterClass),
          TWO_AVAILABLE,
          'Add one +1 INVISIBLE [INVISIBLE] card'),
      Perk.addCards(ConditionCard(Condition.muddle, characterClass).times(3),
          TWO_AVAILABLE, 'Add three [ROLLING] MUDDLE [MUDDLE] cards'),
      Perk.addCards(
          AttackEffectCard(AttackEffect.heal, 1, characterClass).times(2),
          ONE_AVAILABLE,
          'Add two [ROLLING] Heal [HEAL] 1 cards'),
      Perk.addCards(ConditionCard(Condition.curse, characterClass).times(2),
          ONE_AVAILABLE, 'Add two [ROLLING] CURSE [CURSE] cards'),
      Perk.addOneRollingAddTargetCard(ONE_AVAILABLE, characterClass),
      Perk.ignoreNegativeScenarioEffectsAndAddTwoPlusOneCards(characterClass),
    ];
  }
}
