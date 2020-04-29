import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/character_icons.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class Soothsinger extends Character {
  String name;
  List<Perk> perks;
  AttackModifierDeck attackModifierDeck = AttackModifierDeck();

  Soothsinger(this.name) {
    characterIcon = CharacterIcons.soothsinger_icon;
    backgroundImagePath = 'images/backgrounds/soothsinger.png';
    String characterClass = this.runtimeType.toString();

    perks = [
      Perk.removeTwoMinusOnes(TWO_AVAILABLE),
      Perk.removeCards(DamageChangeCard.base(-2).times(1), ONE_AVAILABLE,
          'Remove one -2 card'),
      Perk.replaceCards(
          DamageChangeCard.base(1).times(2),
          DamageChangeCard.forCharacter(4, characterClass).times(1),
          TWO_AVAILABLE,
          'Replace two +1 cards with one +4 card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withCondition(
              1, Condition.immobilize, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +1 [IMMOBILIZE] card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withCondition(1, Condition.disarm, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +1 [DISARM] card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withCondition(2, Condition.wound, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +2 [WOUND] card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withCondition(2, Condition.poison, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +2 [POISON] card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withCondition(2, Condition.curse, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +2 [CURSE] card'),
      Perk.replaceCard(
          DamageChangeCard.base(0),
          DamageChangeCard.withCondition(3, Condition.muddle, characterClass),
          ONE_AVAILABLE,
          'Replace one +0 card with one +3 [MUDDLE] card'),
      Perk.replaceCard(
          DamageChangeCard.base(-1),
          DamageChangeCard.withCondition(0, Condition.stun, characterClass),
          ONE_AVAILABLE,
          'Replace one -1 card with one +0 [STUN] card'),
      Perk.addCards(
          DamageChangeCard.forCharacter(1, characterClass).rolling().times(3),
          ONE_AVAILABLE,
          'Add three [ROLLING] +1 cards'),
      Perk.addCards(ConditionCard(Condition.curse, characterClass).times(2),
          TWO_AVAILABLE, 'Add two [ROLLING] [CURSE] cards')
    ];
  }
}
