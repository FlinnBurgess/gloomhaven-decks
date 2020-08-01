import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_effect_card.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/cards/condition_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/ui/misc_icons.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';

const int ONE_AVAILABLE = 1;
const int TWO_AVAILABLE = 2;
const int THREE_AVAILABLE = 3;

var placeholderConversions = {
  '[FIRE INFUSION]': fireIcon,
  '[ICE INFUSION]': iceIcon,
  '[AIR INFUSION]': airIcon,
  '[EARTH INFUSION]': earthIcon,
  '[LIGHT INFUSION]': lightIcon,
  '[DARK INFUSION]': darkIcon,
  '[ADD TARGET]': addTargetIcon,
  '[PUSH]': pushIcon,
  '[PULL]': pullIcon,
  '[HEAL]': healIcon,
  '[SHIELD]': shieldIcon,
  '[PIERCE]': pierceIcon,
  '[BLESS]': blessIcon,
  '[CURSE]': curseIcon,
  '[DISARM]': disarmIcon,
  '[IMMOBILIZE]': immobilizeIcon,
  '[INVISIBLE]': invisibleIcon,
  '[MUDDLE]': muddleIcon,
  '[POISON]': poisonIcon,
  '[STRENGTHEN]': strengthenIcon,
  '[STUN]': stunIcon,
  '[WOUND]': woundIcon,
  '[ROLLING]': Icon(MiscIcons.rolling, color: Color.fromRGBO(77, 121, 68, 1)),
};

RichText perkText(String description) {
  var textSections = description.split(RegExp(r"\[[A-Z0-9\s]+\]"));
  var iconPlaceholders = RegExp(r"\[[A-Z0-9\s]+\]").allMatches(description);
  var icons = iconPlaceholders.map<Widget>((match) {
    return placeholderConversions.containsKey(match.group(0))
        ? Container(child: placeholderConversions[match.group(0)],
      decoration: BoxDecoration(color: Colors.black38, shape: BoxShape.circle),)
        : OutlinedText.blackAndWhite(match.group(0));
  }).toList();

  var textSpanChildren = <InlineSpan>[];

  for (int i = 0; i < textSections.length; i++) {
    textSpanChildren
        .add(WidgetSpan(child: OutlinedText.blackAndWhite(textSections[i])));
    if (icons.length >= i + 1) {
      textSpanChildren.add(WidgetSpan(child: icons[i]));
    }
  }

  return RichText(
    text: TextSpan(children: textSpanChildren),
  );
}

class Perk {
  Function(Character) apply;
  Function(Character) unapply;
  int perksAvailable = 0;
  int perksUsed = 0;
  String description;

  Perk.addCards(List<AttackModifierCard> cards, this.perksAvailable,
      this.description) {
    apply = _addCardsToDeck(cards);
    unapply = _removeCardsFromDeck(cards);
  }

  Perk.addCard(AttackModifierCard card, perksAvailable, description)
      : this.addCards([card], perksAvailable, description);

  Perk.removeCards(List cards, this.perksAvailable, this.description) {
    apply = _removeCardsFromDeck(cards);
    unapply = _addCardsToDeck(cards);
  }

  Perk.replaceCards(List<AttackModifierCard> cardsBeingReplaced,
      List<AttackModifierCard> replacementCards,
      this.perksAvailable,
      this.description) {
    apply = (Character character) {
      return character.attackModifierDeck.replaceCards(
          cardsBeingReplaced, replacementCards);
    };

    unapply = (Character character) {
      return character.attackModifierDeck.replaceCards(
          replacementCards, cardsBeingReplaced);
    };
  }

  Perk.replaceCard(AttackModifierCard cardToReplace,
      AttackModifierCard replacementCard,
      int perksAvailable,
      String description)
      : this.replaceCards(
      [cardToReplace], [replacementCard], perksAvailable, description);

  Perk.removeFourZeros(int perksAvailable)
      : this.removeCards(DamageChangeCard.base(0).times(4), perksAvailable,
      'Remove four +0 cards');

  Perk.removeTwoMinusOnes(int perksAvailable)
      : this.removeCards(DamageChangeCard.base(-1).times(2), perksAvailable,
      'Remove two -1 cards');

  Perk.addTwoPlusOnes(int perksAvailable, String characterClass)
      : this.addCards(DamageChangeCard.forCharacter(1, characterClass).times(2),
      perksAvailable, 'Add two +1 cards');

  Perk.addPlusOneAndWoundCard(int perksAvailable, String characterClass)
      : this.addCard(
      DamageChangeCard.withCondition(1, Condition.wound, characterClass),
      perksAvailable,
      'Add one +1 WOUND [WOUND] card');

  Perk.addPlusOneAndImmobilizeCard(int perksAvailable, String characterClass)
      : this.addCard(
      DamageChangeCard.withCondition(
          1, Condition.immobilize, characterClass),
      perksAvailable,
      'Add one +1 IMMOBILIZE [IMMOBILIZE] card');

  Perk.addOneRollingStunCard(int perksAvailable, String characterClass)
      : this.addCard(ConditionCard(Condition.stun, characterClass),
      perksAvailable, 'Add one [ROLLING] STUN [STUN] card');

  Perk.addOnePlusZeroAndStunCard(int perksAvailable, String characterClass)
      : this.addCard(
      DamageChangeCard.withCondition(0, Condition.stun, characterClass),
      perksAvailable,
      'Add one +0 STUN [STUN] card');

  Perk.addTwoRollingWoundCards(int perksAvailable, String characterClass)
      : this.addCards(ConditionCard(Condition.wound, characterClass).times(2),
      perksAvailable, 'Add two [ROLLING] WOUND [WOUND] cards');

  Perk.addTwoRollingHealOneCards(int perksAvailable, String characterClass)
      : this.addCards(
      AttackEffectCard(AttackEffect.heal, 1, characterClass).times(2),
      perksAvailable,
      'Add two [ROLLING] Heal [HEAL] 1 cards');

  Perk.addOneRollingAddTargetCard(int perksAvailable, String characterClass)
      : this.addCard(
      AttackEffectCard(AttackEffect.addTarget, 1, characterClass),
      perksAvailable,
      'Add one [ROLLING] ADD TARGET [ADD TARGET] card');

  Perk.replaceMinusTwoWithZero(int perksAvailable, String characterClass)
      : this.replaceCards(
      [DamageChangeCard.base(-2)],
      [DamageChangeCard.forCharacter(0, characterClass)],
      perksAvailable,
      'Replace one -2 card with one +0 card');

  Perk.replaceMinusOneWithPlusOne(int perksAvailable, String characterClass)
      : this.replaceCard(
      DamageChangeCard.base(-1),
      DamageChangeCard.forCharacter(1, characterClass),
      perksAvailable,
      'Replace one -1 card with one +1 card');

  Perk.replaceZeroWithPlusTwo(int perksAvailable, String characterClass)
      : this.replaceCard(
      DamageChangeCard.base(0),
      DamageChangeCard.forCharacter(2, characterClass),
      perksAvailable,
      'Replace one +0 card with one +2 card');

  Perk.addTwoRollingPlusOnes(int perksAvailable, String characterClass)
      : this.addCards(
      DamageChangeCard.forCharacter(1, characterClass).rolling().times(2),
      perksAvailable,
      'Add two [ROLLING] +1 cards');

  Perk.ignoreNegativeScenarioEffectsAndAddTwoPlusOneCards(String characterClass)
      : this.addCards(
      DamageChangeCard.forCharacter(1, characterClass).times(2),
      ONE_AVAILABLE,
      'Ignore negative scenario effects and add two +1 cards');

  Function _removeCardsFromDeck(List<AttackModifierCard> cards) {
    return (Character character) {
        bool successful = character.attackModifierDeck.removeCards(cards);
        if (successful) {
          character.attackModifierDeck.shuffle();
        }
        return successful;
    };
  }

  Function _addCardsToDeck(List<AttackModifierCard> cards) {
    return (Character character) {
      character.attackModifierDeck.addCards(cards);
      return true;
    };
  }
}
