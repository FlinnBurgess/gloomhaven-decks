import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

// TODO rename character to correct "Sawbone" without an S
class Sawbones extends Character {
  String name;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();

  Sawbones(this.name) {
    characterIcon = CharacterIcons.sawbones_icon;
    backgroundImagePath = 'images/backgrounds/sawbone.png';
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceZeroWithPlusTwo(TWO_AVAILABLE, characterClass),
      Perk.addCard(DamageChangeCard.forCharacter(2, characterClass).rolling(),
          TWO_AVAILABLE, 'Add one [ROLLING] +2 card'),
      Perk.addPlusOneAndImmobilizeCard(TWO_AVAILABLE, characterClass),
      Perk.addTwoRollingWoundCards(TWO_AVAILABLE, characterClass),
      Perk.addOneRollingStunCard(ONE_AVAILABLE, characterClass),
      Perk.addCard(AttackEffectCard(AttackEffect.heal, 3, characterClass),
          TWO_AVAILABLE, 'Add one [ROLLING] [HEAL 3] card'),
      Perk.addCard(
          DamageChangeCard.withAttackEffect(
              0, AttackEffect.refreshItem, 1, characterClass),
          ONE_AVAILABLE,
          'Add one +0 refresh an item card')
    ];
  }
}
