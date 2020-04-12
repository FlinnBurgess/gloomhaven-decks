import 'package:gloomhaven_decks/src/attack_modifier_result.dart';

abstract class AttackModifierCard {
  Function(AttackModifierResult) effect;
  bool isRolling;

  AttackModifierCard(this.effect, this.isRolling);

  AttackModifierResult applyEffect(AttackModifierResult result) {
    effect(result);
    return result;
  }
}
