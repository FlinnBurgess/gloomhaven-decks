import 'package:collection/collection.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';

import 'conditions/condition.dart';

class AttackModifierResult {
  int totalDamage = 0;
  List infusions = [];
  List conditions = [];
  bool isNull = false;
  int healAmount = 0;
  int addTargetAmount = 0;
  int pierceAmount = 0;
  int pullAmount = 0;
  int pushAmount = 0;
  int shieldAmount = 0;

  void applyCardEffect(AttackModifierCard card) {
    card.applyEffect(this);
  }

  void reset() {
    totalDamage = 0;
    infusions = [];
    conditions = [];
    isNull = false;
    healAmount = 0;
    addTargetAmount = 0;
    pierceAmount = 0;
    pullAmount = 0;
    pushAmount = 0;
    shieldAmount = 0;
  }

  void applyDamageDifference(int difference) {
    totalDamage += difference;
  }

  void addInfusion(Infusion infusion) {
    if (!infusions.contains(infusion)) {
      infusions.add(infusion);
    }
  }

  void addCondition(Condition condition) {
    if (!conditions.contains(condition) ||
        condition == Condition.bless ||
        condition == Condition.curse) {
      conditions.add(condition);
    }
  }

  void addAttackEffect(AttackEffect attackEffect, int amount) {
    switch (attackEffect) {
      case AttackEffect.heal:
        healAmount += amount;
        return;
      case AttackEffect.addTarget:
        addTargetAmount += amount;
        return;
      case AttackEffect.pierce:
        pierceAmount += amount;
        return;
      case AttackEffect.push:
        pushAmount += amount;
        return;
      case AttackEffect.pull:
        pullAmount += amount;
        return;
      case AttackEffect.shield:
        shieldAmount += amount;
        break;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AttackModifierResult &&
              runtimeType == other.runtimeType &&
              totalDamage == other.totalDamage &&
              DeepCollectionEquality().equals(infusions, other.infusions) &&
              DeepCollectionEquality().equals(conditions, other.conditions) &&
              isNull == other.isNull &&
              healAmount == other.healAmount &&
              addTargetAmount == other.addTargetAmount &&
              pierceAmount == other.pierceAmount &&
              pullAmount == other.pullAmount &&
              pushAmount == other.pushAmount &&
              shieldAmount == other.shieldAmount;
}
