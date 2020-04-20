import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/cards/bless_card.dart';
import 'package:gloomhaven_decks/src/cards/curse_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/double_damage_card.dart';
import 'package:gloomhaven_decks/src/cards/null_damage_card.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

class AttackModifierDeck {
  static const BASE_NUMBER_OF_ZERO_MODIFIERS = 6;
  static const BASE_NUMBER_OF_PLUS_ONE_MODIFIERS = 5;
  static const BASE_NUMBER_OF_MINUS_ONE_MODIFIERS = 5;

  final List<AttackModifierCard> _cardsInDeck = [];
  List _drawPile = [];
  List _discardPile = [];
  final List _cardsDrawn = [];
  bool needsShuffling = false;
  int _blessCardCount = 0;
  int _curseCardCount = 0;

  AttackModifierDeck() {
    for (var i = 0; i < BASE_NUMBER_OF_ZERO_MODIFIERS; i++) {
      _cardsInDeck.add(DamageChangeCard(0));
    }

    for (var i = 0; i < BASE_NUMBER_OF_PLUS_ONE_MODIFIERS; i++) {
      _cardsInDeck.add(DamageChangeCard(1));
    }

    for (var i = 0; i < BASE_NUMBER_OF_MINUS_ONE_MODIFIERS; i++) {
      _cardsInDeck.add(DamageChangeCard(-1));
    }

    _cardsInDeck.add(DamageChangeCard(2));
    _cardsInDeck.add(DamageChangeCard(-2));
    _cardsInDeck.add(NullDamageCard());
    _cardsInDeck.add(DoubleDamageCard());

    _drawPile = [..._cardsInDeck];
  }

  bool applyPerk(Perk perk) {
    bool successful = perk.apply(this);

    if (successful) {
      this.shuffle();
    }

    return successful;
  }

  bool unapplyPerk(Perk perk) {
    bool successful = perk.unapply(this);

    if (successful) {
      this.shuffle();
    }

    return successful;
  }

  void shuffle() {
    // TODO Needs reworking, since if you have to shuffle due to running out of cards
    // then you shouldn't includee the cards drawn this round (which are currently
    // included in _cardsDrawn)
    _drawPile = [..._cardsInDeck];
    _drawPile.shuffle();
    _discardPile = [];
  }

  void addCards(List<AttackModifierCard> cards) {
    cards.forEach((card) => addCard(card));
  }

  void addCard(card) {
    //TODO should shuffle the the deck after adding a card (i.e. perk), but if you're in the
    // middle of a scenario and adding bless/curse, then you should only add to and shuffle
    // the draw pile

    _cardsInDeck.add(card);

    if (card is BlessCard) {
      _blessCardCount++;
    }

    if (card is CurseCard) {
      _curseCardCount++;
    }
  }

  bool removeCards(List<AttackModifierCard> cards) {
    if (!_containsAll(cards)) {
      return false;
    }
    cards.forEach((card) => _removeCard(card));
    return true;
  }

  void _removeCard(card) {
    _cardsInDeck.remove(card);

    if (card is BlessCard) {
      _blessCardCount--;
    }

    if (card is CurseCard) {
      _curseCardCount--;
    }
  }

  bool replaceCards(List<AttackModifierCard> cardsBeingReplaced,
      List<AttackModifierCard> replacementCards) {
    if (_containsAll(cardsBeingReplaced)) {
      removeCards(cardsBeingReplaced);
      addCards(replacementCards);
      return true;
    }

    return false;
  }

  bool _containsAll(List<AttackModifierCard> cards) {
    bool containsAllCards = true;
    var deckCopy = [..._cardsInDeck];

    cards.forEach((card) => containsAllCards = deckCopy.remove(card));
    return containsAllCards;
  }

  bool isBlessed() {
    return _blessCardCount > 0;
  }

  bool isCursed() {
    return _curseCardCount > 0;
  }

  void discardCards(cards) {
    _discardPile += cards;
  }

  AttackModifierCard draw() {
    if (_drawPile.isEmpty) {
      shuffle();
    }

    AttackModifierCard cardDrawn = _drawPile.removeAt(0);
    if (!_cardIsSingleUse(cardDrawn)) {
      _cardsDrawn.add(cardDrawn);
    }

    if (cardDrawn is DoubleDamageCard || cardDrawn is NullDamageCard) {
      needsShuffling = true;
    }

    return cardDrawn;
  }

  bool _cardIsSingleUse(AttackModifierCard card) {
    return card is CurseCard || card is BlessCard;
  }
}
