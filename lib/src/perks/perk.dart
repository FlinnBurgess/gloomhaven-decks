import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';

class Perk {
  static final ONE_PERK_AVAILABLE = 1;
  static final TWO_PERKS_AVAILABLE = 1;

  Function(AttackModifierDeck) apply;
  Function(AttackModifierDeck) unapply;

  Perk.additive(List cards) {
    apply = addCardsToDeck(cards);
    unapply = removeCardsFromDeck(cards);
  }

  Perk.subtractive(List cards) {
    apply = removeCardsFromDeck(cards);
    unapply = addCardsToDeck(cards);
  }

  Function removeCardsFromDeck(List cards) {
    return (AttackModifierDeck attackModifierDeck) => {
          for (var card in cards) {attackModifierDeck.removeCard(card)}
        };
  }

  Function addCardsToDeck(List cards) {
    return (AttackModifierDeck attackModifierDeck) => {
          for (var card in cards) {attackModifierDeck.addCard(card)}
        };
  }
}
