import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';

class ConditionCard extends AttackModifierCard {
  ConditionCard(Condition condition, String cardImagePath)
      : super(conditionEffect(condition), true, cardImagePath);
}

Function(AttackModifierResult) conditionEffect(Condition condition) {
  return (AttackModifierResult result) => result.addCondition(condition);
}
