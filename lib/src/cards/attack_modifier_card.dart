import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';

abstract class AttackModifierCard {
  Function(AttackModifierResult) effect;
  bool isRolling;
  String cardImagePath;

  AttackModifierCard(this.effect, this.isRolling, this.cardImagePath);

  AttackModifierResult applyEffect(AttackModifierResult result) {
    effect(result);
    return result;
  }

  AttackModifierCard rolling() {
    if (isRolling) {
      return this;
    }

    isRolling = true;
    String regexString = r'/cards/[a-z]+/';
    RegExp regex = RegExp(regexString);
    String match = regex.stringMatch(cardImagePath);
    cardImagePath = cardImagePath.replaceFirst(match, match + 'rolling-');
    return this;
  }

  List<AttackModifierCard> times(int count) {
    List<AttackModifierCard> listOfCards = [];
    for (int i = 0; i < count; i++) {
      listOfCards.add(this);
    }
    return listOfCards;
  }

  Image getImage() {
    return Image(image: AssetImage(cardImagePath));
  }

  @override
  bool operator ==(other) {
    return identical(this, other) || this.cardImagePath == other.cardImagePath;
  }
}
