import 'package:gloomhaven_decks/src/attack_modifier_result.dart';

abstract class AttackModifierCard {
  Function(AttackModifierResult) effect;
  bool isRolling;

  AttackModifierCard(this.effect, this.isRolling);

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

  @override
  bool operator ==(other) {
    AttackModifierResult thisResult = AttackModifierResult();
    AttackModifierResult othersResult = AttackModifierResult();
    this.applyEffect(thisResult);
    other.applyEffect(othersResult);
    return identical(this, other) || (other.runtimeType == this.runtimeType && thisResult == othersResult);
  }


}
