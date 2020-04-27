import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Sawbones extends Character {
  String name;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();
  Icon characterIcon = Icon(CharacterIcons.sawbones_icon);

  Sawbones(this.name) {
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.removeFourZeros(ONE_AVAILABLE),
      Perk.replaceZeroWithPlusTwo(TWO_AVAILABLE, characterClass),
      Perk.addCard(DamageChangeCard.forCharacter(2, characterClass).rolling(),
          TWO_AVAILABLE, 'Add one [ROLLING] +2 card'),
      Perk.addPlusOneAndImmobilizeCard(TWO_AVAILABLE, characterClass),
      Perk.addCards(ConditionCard(Condition.wound, characterClass).times(2),
          TWO_AVAILABLE, 'Add two [ROLLING] [WOUND] cards'),
      Perk.addOneRollingStunCard(ONE_AVAILABLE, characterClass),
      Perk.addCard(AttackEffectCard(AttackEffect.heal, 3, characterClass),
          TWO_AVAILABLE, 'Add one [ROLLING] [HEAL 3] card'),
      Perk.addCard(
          AttackEffectCard(AttackEffect.refreshItem, 1, characterClass),
          ONE_AVAILABLE,
          'Add one +0 refresh an item card')
    ];
  }
}
