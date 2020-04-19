import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';

class Perk {
  static final ONE_PERK_AVAILABLE = 1;
  static final TWO_PERKS_AVAILABLE = 1;

  Function(AttackModifierDeck) apply;
  Function(AttackModifierDeck) unapply;
  int perksAvailable;
  int perksUsed = 0;
  String description;

  Perk.additive(List cards, this.perksAvailable, this.description) {
    apply = _addCardsToDeck(cards);
    unapply = _removeCardsFromDeck(cards);
  }

  Perk.subtractive(List cards, this.perksAvailable, this.description) {
    apply = _removeCardsFromDeck(cards);
    unapply = _addCardsToDeck(cards);
  }

  Perk.replacement(List cardsBeingReplaced, List replacementCards,
      this.perksAvailable, this.description) {
    //TODO replacement is conditional (possibly not?) on the card being there in the first place

    apply = (AttackModifierDeck attackModifierDeck) {
      for (var card in cardsBeingReplaced) {
        attackModifierDeck.removeCard(card);
      }
      for (var card in replacementCards) {
        attackModifierDeck.addCard(card);
      }
    };

    unapply = (AttackModifierDeck attackModifierDeck) {
      for (var card in cardsBeingReplaced) {
        attackModifierDeck.addCard(card);
      }
      for (var card in replacementCards) {
        attackModifierDeck.removeCard(card);
      }
    };
  }

  Perk.removeFourZeros(int perksAvailable) {
    Perk.subtractive(DamageChangeCard.zero().times(4), perksAvailable,
        'Remove four +0 cards');
  }

  Perk.removeTwoMinusOnes(int perksAvailable) {
    Perk.subtractive(DamageChangeCard.minusOne().times(2), perksAvailable,
        'Remove two -1 cards');
  }

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
