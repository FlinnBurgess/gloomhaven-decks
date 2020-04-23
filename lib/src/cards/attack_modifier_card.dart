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
    isRolling = true;
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
