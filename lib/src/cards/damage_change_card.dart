import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:recase/recase.dart';

class DamageChangeCard extends AttackModifierCard {
  DamageChangeCard.base(int damageChange)
      : super(damageChangeEffect(damageChange), false,
      generateBaseImagePath(damageChange));

  DamageChangeCard.extraMinusOne()
      : super(damageChangeEffect(-1), false,
      'images/cards/base/extra-minus-one.png');

  DamageChangeCard.forCharacter(int damageChange, String characterClass)
      : super(damageChangeEffect(damageChange), false,
      generateCharacterImagePath(damageChange, characterClass));

  DamageChangeCard.withInfusion(int damageChange, Infusion infusion,
      String characterClass)
      : super(damageChangeWithInfusionEffect(damageChange, infusion), false,
      generateInfusionImagePath(damageChange, infusion, characterClass));

  DamageChangeCard.withCondition(int damageChange, Condition condition,
      String characterClass)
      : super(
      damageChangeWithConditionEffect(damageChange, condition),
      false,
      generateConditionImagePath(
          damageChange, condition, characterClass));

  DamageChangeCard.withAttackEffect(int damageChange, AttackEffect attackEffect,
      int attackEffectAmount, String characterClass)
      : super(
            damageChangeWithAttackEffect(
                damageChange, attackEffect, attackEffectAmount),
      false,
      generateAttackEffectImagePath(damageChange, attackEffect,
          attackEffectAmount, characterClass));
}

String generateBaseImagePath(int damage) {
  return damage < 0
      ? 'images/cards/base/minus-${damage.abs()}-damage.png'
      : 'images/cards/base/plus-${damage.abs()}-damage.png';
}

String generateCharacterImagePath(int damage, String characterClass) {
  characterClass = characterClass.toLowerCase();
  return damage < 0
      ? 'images/cards/$characterClass/minus-${damage.abs()}-damage.png'
      : 'images/cards/$characterClass/plus-${damage.abs()}-damage.png';
}

String generateInfusionImagePath(int damage, Infusion infusion,
    String characterClass) {
  characterClass = characterClass.toLowerCase();
  String infusionString = infusion
      .toString()
      .split('.')
      .last
      .toLowerCase();
  return damage < 0
      ? 'images/cards/$characterClass/minus-${damage
      .abs()}-damage-and-$infusionString.png'
      : 'images/cards/$characterClass/plus-${damage
      .abs()}-damage-and-$infusionString.png';
}

String generateConditionImagePath(int damage, Condition condition,
    String characterClass) {
  characterClass = characterClass.toLowerCase();
  String conditionString = condition
      .toString()
      .split('.')
      .last
      .toLowerCase();
  return damage < 0
      ? 'images/cards/$characterClass/minus-${damage
      .abs()}-damage-and-$conditionString.png'
      : 'images/cards/$characterClass/plus-${damage
      .abs()}-damage-and-$conditionString.png';
}

String generateAttackEffectImagePath(int damage, AttackEffect attackEffect,
    int attackEffectAmount, String characterClass) {
  characterClass = characterClass.toLowerCase();

  String attackEffectString = attackEffect
      .toString()
      .split('.')
      .last
      .paramCase;

  return damage < 0
      ? 'images/cards/$characterClass/minus-${damage
      .abs()}-damage-and-$attackEffectString-$attackEffectAmount.png'
      : 'images/cards/$characterClass/plus-${damage
      .abs()}-damage-and-$attackEffectString-$attackEffectAmount.png';
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

Function(AttackModifierResult) damageChangeWithAttackEffect(
    damageChange, attackEffect, attackEffectAmount) {
  return (AttackModifierResult result) {
    result.applyDamageDifference(damageChange);
    result.addAttackEffect(attackEffect, attackEffectAmount);
  };
}
