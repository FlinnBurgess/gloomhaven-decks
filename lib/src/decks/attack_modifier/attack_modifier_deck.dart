import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/cards/bless_card.dart';
import 'package:gloomhaven_decks/src/cards/curse_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/double_damage_card.dart';
import 'package:gloomhaven_decks/src/cards/null_damage_card.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';

//TODO add modifier cards from negative item effects
class AttackModifierDeck {
  static const BASE_NUMBER_OF_ZERO_MODIFIERS = 6;
  static const BASE_NUMBER_OF_PLUS_ONE_MODIFIERS = 5;
  static const BASE_NUMBER_OF_MINUS_ONE_MODIFIERS = 5;

  final List<AttackModifierCard> _cardsInDeck = [];
  List _drawPile = [];
  List _discardPile = [];
  List cardsDrawn = [];
  bool needsShuffling = false;
  int blessCardCount = 0;
  int curseCardCount = 0;

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

    shuffle();
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
    _drawPile = [..._cardsInDeck];
    _drawPile.shuffle();
    _discardPile = [];
  }

  void addCards(List<AttackModifierCard> cards) {
    cards.forEach((card) => addCard(card));
    this.shuffle();
  }

  void addCard(card) {
    _cardsInDeck.add(card);
    _drawPile.add(card);
    _drawPile.shuffle();

    if (card is BlessCard) {
      blessCardCount++;
    }

    if (card is CurseCard) {
      curseCardCount++;
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
      blessCardCount--;
    }

    if (card is CurseCard) {
      curseCardCount--;
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
    return blessCardCount > 0;
  }

  bool isCursed() {
    return curseCardCount > 0;
  }

  void discardCardsDrawn() {
    cardsDrawn.removeWhere((card) => card is BlessCard || card is CurseCard);
    _discardPile += cardsDrawn;
    cardsDrawn = [];
  }

  List<AttackModifierCard> drawUntilNonRollingCard() {
    AttackModifierCard nextCard = draw();
    List<AttackModifierCard> cardsDrawn = [nextCard];

    while (nextCard.isRolling) {
      nextCard = draw();
      cardsDrawn.add(nextCard);
    }

    return cardsDrawn;
  }

  AttackModifierCard draw() {
    if (_drawPile.isEmpty) {
      _drawPile = [..._discardPile];
      _drawPile.shuffle();
    }

    AttackModifierCard cardDrawn = _drawPile.removeAt(0);

    if (cardDrawn is BlessCard || cardDrawn is CurseCard) {
      _removeCard(cardDrawn);
    } else if (cardDrawn is DoubleDamageCard || cardDrawn is NullDamageCard) {
      needsShuffling = true;
    }

    return cardDrawn;
  }

  bool _cardIsSingleUse(AttackModifierCard card) {
    return card is CurseCard || card is BlessCard;
  }
}
