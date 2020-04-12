import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';

class DamageChangeCard extends AttackModifierCard {
  DamageChangeCard(int damageChange, bool isRolling)
      : super(damageChangeEffect(damageChange), isRolling);

  DamageChangeCard.withInfusion(
      int damageChange, Infusion infusion, bool isRolling)
      : super(
            damageChangeWithInfusionEffect(damageChange, infusion), isRolling);

  DamageChangeCard.withCondition(
      int damageChange, Condition condition, bool isRolling)
      : super(damageChangeWithConditionEffect(damageChange, condition),
            isRolling);

  static DamageChangeCard minusOne() {
    return DamageChangeCard(-1, false);
  }

  static DamageChangeCard zero() {
    return DamageChangeCard(0, false);
  }

  static DamageChangeCard plusOne() {
    return DamageChangeCard(1, false);
  }

  static DamageChangeCard plusTwo() {
    return DamageChangeCard(2, false);
  }

  static DamageChangeCard minusTwo() {
    return DamageChangeCard(-2, false);
  }
}

Function(AttackModifierResult) damageChangeEffect(amount) {
  return (AttackModifierResult result) => result.applyDamageDifference(amount);
}

Function(AttackModifierResult) damageChangeWithInfusionEffect(
    amount, infusion) {
  return (AttackModifierResult result) {
    result.applyDamageDifference(amount);
    result.addInfusion(infusion);
  };
}

Function(AttackModifierResult) damageChangeWithConditionEffect(
    amount, condition) {
  return (AttackModifierResult result) {
    result.applyDamageDifference(amount);
    result.addCondition(condition);
  };
}
