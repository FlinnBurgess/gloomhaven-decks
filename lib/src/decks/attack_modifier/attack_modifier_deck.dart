import 'dart:math';

import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/cards/bless_card.dart';
import 'package:gloomhaven_decks/src/cards/curse_card.dart';
import 'package:gloomhaven_decks/src/cards/damage_change_card.dart';
import 'package:gloomhaven_decks/src/cards/double_damage_card.dart';
import 'package:gloomhaven_decks/src/cards/null_damage_card.dart';

class AttackModifierDeck {
  static const BASE_NUMBER_OF_ZERO_MODIFIERS = 6;
  static const BASE_NUMBER_OF_PLUS_ONE_MODIFIERS = 5;
  static const BASE_NUMBER_OF_MINUS_ONE_MODIFIERS = 5;

  final List<AttackModifierCard> _cardsInDeck = [];
  List _drawPile = [];
  List _discardPile = [];
  List cardsDrawn = [];
  int blessCardCount = 0;
  int curseCardCount = 0;
  int scenarioEffectMinusOneCards = 0;
  bool doubleDamageDrawn = false;
  bool nullDrawn = false;
  int _cardsRemovedBySecondSkin = 0;

  AttackModifierDeck() {
    _cardsInDeck
        .addAll(DamageChangeCard.base(0).times(BASE_NUMBER_OF_ZERO_MODIFIERS));
    _cardsInDeck.addAll(
        DamageChangeCard.base(1).times(BASE_NUMBER_OF_PLUS_ONE_MODIFIERS));
    _cardsInDeck.addAll(
        DamageChangeCard.base(-1).times(BASE_NUMBER_OF_MINUS_ONE_MODIFIERS));
    _cardsInDeck.add(DamageChangeCard.base(2));
    _cardsInDeck.add(DamageChangeCard.base(-2));
    _cardsInDeck.add(NullDamageCard());
    _cardsInDeck.add(DoubleDamageCard());

    shuffle();
  }

  void shuffle() {
    _drawPile = [..._cardsInDeck];
    _drawPile.shuffle();
    _discardPile = [];
    nullDrawn = false;
    doubleDamageDrawn = false;
  }

  List<AttackModifierCard> getDeck() {
    return _cardsInDeck;
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
      BlessCard.totalBlessCardsInPlay++;
    }

    if (card is CurseCard) {
      curseCardCount++;
      CurseCard.totalCurseCardsInPlay++;
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
    _drawPile.remove(card);
    _drawPile.shuffle();

    if (card is BlessCard) {
      blessCardCount--;
      BlessCard.totalBlessCardsInPlay--;
    }

    if (card is CurseCard) {
      curseCardCount--;
      CurseCard.totalCurseCardsInPlay--;
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

  void applySecondSkin() {
    while (_cardsInDeck.contains(DamageChangeCard.base(-1)) &&
        _cardsRemovedBySecondSkin < 2) {
      _removeCard(DamageChangeCard.base(-1));
      _cardsRemovedBySecondSkin++;
    }
  }

  void unapplySecondSkin() {
    while (_cardsRemovedBySecondSkin > 0) {
      addCard(DamageChangeCard.base(-1));
      _cardsRemovedBySecondSkin--;
    }
  }

  void addItemEffectMinusOneCards(int numberOfCards) {
    addCards(DamageChangeCard.itemEffect(-1).times(numberOfCards));
  }

  void removeItemEffectMinusOneCards(int numberOfCards) {
    while (_cardsInDeck.contains(DamageChangeCard.itemEffect(-1)) &&
        numberOfCards > 0) {
      _removeCard(DamageChangeCard.itemEffect(-1));
      numberOfCards--;
    }
  }

  void addScenarioEffectMinusOneCard() {
    addCard(DamageChangeCard.extraMinusOne());
    scenarioEffectMinusOneCards++;
  }

  void removeScenarioEffectMinusOneCard() {
    _removeCard(DamageChangeCard.extraMinusOne());
    scenarioEffectMinusOneCards--;
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
      _discardPile = [];
    }

    AttackModifierCard cardDrawn = _drawPile.removeAt(0);

    if (cardDrawn is BlessCard || cardDrawn is CurseCard) {
      _removeCard(cardDrawn);
    } else if (cardDrawn is DoubleDamageCard) {
      doubleDamageDrawn = true;
    } else if (cardDrawn is NullDamageCard) {
      nullDrawn = true;
    }

    cardsDrawn.add(cardDrawn);

    return cardDrawn;
  }

  void cleanUp() {
    _cardsInDeck.removeWhere((card) => card is BlessCard || card is CurseCard);
    BlessCard.totalBlessCardsInPlay -= blessCardCount;
    CurseCard.totalCurseCardsInPlay -= curseCardCount;
    blessCardCount = 0;
    curseCardCount = 0;
  }

  int drawPileSize() {
    return _drawPile.length;
  }

  int discardPileSize() {
    return _discardPile.length;
  }

  List<AttackModifierCard> getCardsToRearrange(int numberOfCards) {
    return _drawPile
        .sublist(0, min(numberOfCards, _drawPile.length - 1))
        .cast<AttackModifierCard>();
  }

  void rearrangeCards(
      {List<AttackModifierCard> toTopDeck,
      List<AttackModifierCard> toGoOnBottom}) {
    _drawPile.removeRange(0, toTopDeck.length + toGoOnBottom.length);
    toTopDeck.forEach((card) {
      _drawPile.insert(0, card);
    });
    toGoOnBottom.forEach((card) {
      _drawPile.add(card);
    });
  }

  List get discardPile => _discardPile;
}
