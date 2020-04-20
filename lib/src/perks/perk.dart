import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';

class Perk {
  static final ONE_PERK_AVAILABLE = 1;
  static final TWO_PERKS_AVAILABLE = 2;
  static final THREE_PERKS_AVAILABLE = 3;

  Function(AttackModifierDeck) apply;
  Function(AttackModifierDeck) unapply;
  int perksAvailable = 0;
  int perksUsed = 0;
  String description;

  Perk.addCards(List cards, this.perksAvailable, this.description) {
    apply = _addCardsToDeck(cards);
    unapply = _removeCardsFromDeck(cards);
  }

  Perk.addCard(AttackModifierCard card, perksAvailable, description)
      : this.addCards([card], perksAvailable, description);

  Perk.removeCards(List cards, this.perksAvailable, this.description) {
    apply = _removeCardsFromDeck(cards);
    unapply = _addCardsToDeck(cards);
  }

  Perk.replaceCards(
      List<AttackModifierCard> cardsBeingReplaced,
      List<AttackModifierCard> replacementCards,
      this.perksAvailable,
      this.description) {
    apply = (AttackModifierDeck attackModifierDeck) {
      attackModifierDeck.replaceCards(cardsBeingReplaced, replacementCards);
    };

    unapply = (AttackModifierDeck attackModifierDeck) {
      attackModifierDeck.replaceCards(replacementCards, cardsBeingReplaced);
    };
  }

  Perk.replaceCard(AttackModifierCard cardToReplace,
      AttackModifierCard replacementCard,
      int perksAvailable,
      String description)
      : this.replaceCards(
      [cardToReplace], [replacementCard], perksAvailable, description);

  Perk.removeFourZeros(int perksAvailable)
      : this.removeCards(DamageChangeCard.zero().times(4), perksAvailable,
            'Remove four +0 cards');

  Perk.removeTwoMinusOnes(int perksAvailable)
      : this.removeCards(DamageChangeCard.minusOne().times(2), perksAvailable,
            'Remove two -1 cards');

  Perk.addTwoPlusOnes(int perksAvailable)
      : this.addCards(DamageChangeCard.plusOne().times(2), perksAvailable,
            'Add two +1 cards');

  Perk.replaceMinusTwoWithZero(int perksAvailable)
      : this.replaceCards(
            [DamageChangeCard.minusTwo()],
            [DamageChangeCard.zero()],
            perksAvailable,
            'Replace one -2 card with one +0 card');

  Perk.addTwoRollingPlusOnes(int perksAvailable)
      : this.addCards(DamageChangeCard(1).rolling().times(2), perksAvailable,
            'Add two [ROLLING] +1 cards');

  Function _removeCardsFromDeck(List cards) {
    return (AttackModifierDeck attackModifierDeck) => {
          for (var card in cards) {attackModifierDeck.removeCard(card)}
        };
  }

  Function _addCardsToDeck(List cards) {
    return (AttackModifierDeck attackModifierDeck) => {
          for (var card in cards) {attackModifierDeck.addCard(card)}
        };
  }
}
