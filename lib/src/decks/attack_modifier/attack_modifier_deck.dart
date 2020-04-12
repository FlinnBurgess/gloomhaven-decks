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

  List _cardsInDeck = [];
  final List _cardsDrawn = [];
  bool needsShuffling = false;
  int _blessCardCount = 0;
  int _curseCardCount = 0;

  AttackModifierDeck() {
    for (var i = 0; i < BASE_NUMBER_OF_ZERO_MODIFIERS; i++) {
      _cardsInDeck.add(DamageChangeCard(0, false));
    }

    for (var i = 0; i < BASE_NUMBER_OF_PLUS_ONE_MODIFIERS; i++) {
      _cardsInDeck.add(DamageChangeCard(1, false));
    }

    for (var i = 0; i < BASE_NUMBER_OF_MINUS_ONE_MODIFIERS; i++) {
      _cardsInDeck.add(DamageChangeCard(-1, false));
    }

    _cardsInDeck.add(DamageChangeCard(2, false));

    _cardsInDeck.add(DamageChangeCard(-2, false));

    _cardsInDeck.add(NullDamageCard());

    _cardsInDeck.add(DoubleDamageCard());
  }

  void shuffle() {
    // Needs reworking, since if you have to shuffle due to running out of cards
    // then you shouldn't includee the cards drawn this round (which are currently
    // included in _cardsDrawn)
    _cardsInDeck = _cardsInDeck + _cardsDrawn;
    _cardsInDeck.shuffle();
  }

  void addCard(card) {
    _cardsInDeck.add(card);

    if (card is BlessCard) {
      _blessCardCount++;
    }

    if (card is CurseCard) {
      _curseCardCount++;
    }
  }

  void removeCard(card) {
    var cardExisted = _cardsInDeck.remove(card);

    if (!cardExisted) {
      return;
    }

    if (card is BlessCard) {
      _blessCardCount--;
    }

    if (card is CurseCard) {
      _curseCardCount--;
    }
  }

  bool isBlessed() {
    return _blessCardCount > 0;
  }

  bool isCursed() {
    return _curseCardCount > 0;
  }

  AttackModifierCard draw() {
    if (_cardsInDeck.isEmpty) {
      shuffle();
    }

    AttackModifierCard cardDrawn = _cardsInDeck.removeAt(0);
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
