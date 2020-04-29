import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/infusion_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

import '../character_icons.dart';

class Cragheart extends Character {
  String name;
  AttackModifierDeck attackModifierDeck;
  List<Perk> perks;

  Cragheart(this.name) {
    backgroundImagePath = 'images/backgrounds/cragheart.png';
    attackModifierDeck = AttackModifierDeck();
    characterIcon = CharacterIcons.cragheart_icon;
    var characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceMinusOneWithPlusOne(THREE_AVAILABLE, characterClass),
      Perk.addCards(
          DamageChangeCard.forCharacter(2, characterClass).times(2) +
              DamageChangeCard.forCharacter(-2, characterClass).times(1),
          ONE_AVAILABLE,
          'Add one -2 card and two +2 cards'),
      Perk.addPlusOneAndImmobilizeCard(TWO_AVAILABLE, characterClass),
      Perk.addCard(
          DamageChangeCard.withCondition(2, Condition.muddle, characterClass),
          TWO_AVAILABLE,
          'Add one +2 [MUDDLE] card'),
      Perk.addCards(
          AttackEffectCard(AttackEffect.push, 2, characterClass).times(2),
          ONE_AVAILABLE,
          'Add two [PUSH 2] cards'),
      Perk.addCards(InfusionCard(Infusion.earth, characterClass).times(2),
          TWO_AVAILABLE, 'Add two [ROLLING] [EARTH INFUSION] cards'),
      Perk.addCards(InfusionCard(Infusion.air, characterClass).times(2),
          ONE_AVAILABLE, 'Add two [ROLLING] [AIR INFUSION] cards')
    ];
  }
}
