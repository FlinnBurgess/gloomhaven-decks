import 'package:collection/collection.dart';
import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';

import 'conditions/condition.dart';

AttackModifierResult betterResult(AttackModifierResult firstResult,
    AttackModifierResult secondResult) {
  if (addedEffectsAreEqual(firstResult, secondResult)) {
    if (firstResult.totalDamage > secondResult.totalDamage) {
      return firstResult;
    } else if (secondResult.totalDamage > firstResult.totalDamage) {
      return secondResult;
    }
    return null;
  }

  if (firstResult.hasAddedEffect() && !secondResult.hasAddedEffect()) {
    if (firstResult.totalDamage >= secondResult.totalDamage) {
      return firstResult;
    }
    return null;
  }

  if (secondResult.hasAddedEffect() && !firstResult.hasAddedEffect()) {
    if (secondResult.totalDamage >= firstResult.totalDamage) {
      return secondResult;
    }
    return null;
  }

  return null;
}

AttackModifierResult worseResult(AttackModifierResult firstResult,
    AttackModifierResult secondResult) {
  AttackModifierResult bestResult = betterResult(firstResult, secondResult);

  if (bestResult == null) {
    return null;
  } else if (bestResult == firstResult) {
    return secondResult;
  } else {
    return firstResult;
  }
}

bool addedEffectsAreEqual(AttackModifierResult firstResult,
    AttackModifierResult secondResult) {
  return firstResult.infusions == secondResult.infusions &&
      firstResult.conditions == secondResult.conditions &&
      firstResult.healAmount == secondResult.healAmount &&
      firstResult.addTargetAmount == secondResult.addTargetAmount &&
      firstResult.pierceAmount == secondResult.pierceAmount &&
      firstResult.pullAmount == secondResult.pullAmount &&
      firstResult.pushAmount == secondResult.pushAmount &&
      firstResult.shieldAmount == secondResult.shieldAmount &&
      firstResult.refreshItemAmount == secondResult.refreshItemAmount;
}

class AttackModifierResult {
  int totalDamage;
  List infusions = [];
  List conditions = [];
  bool isNull = false;
  int healAmount = 0;
  int addTargetAmount = 0;
  int pierceAmount = 0;
  int pullAmount = 0;
  int pushAmount = 0;
  int shieldAmount = 0;
  int refreshItemAmount = 0;

  Future<AttackModifierResult> applyCardEffect(AttackModifierCard card) async {
    await card.applyEffect(this);
    return this;
  }

  Future<AttackModifierResult> applyCards(
      List<AttackModifierCard> cards) async {
    cards.forEach((card) async => await applyCardEffect(card));
    return this;
  }

  void reset() {
    totalDamage = null;
    infusions = [];
    conditions = [];
    isNull = false;
    healAmount = 0;
    addTargetAmount = 0;
    pierceAmount = 0;
    pullAmount = 0;
    pushAmount = 0;
    shieldAmount = 0;
    refreshItemAmount = 0;
  }

  void applyDamageDifference(int difference) {
    if (totalDamage == null) {
      totalDamage = difference;
    } else {
      totalDamage += difference;
    }
    if (totalDamage < 0) {
      totalDamage = 0;
    }
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
        return;
      case AttackEffect.refreshItem:
        refreshItemAmount += amount;
        return;
    }
  }

  bool hasAddedEffect() {
    return infusions.isNotEmpty || conditions.isNotEmpty || healAmount > 0 ||
        addTargetAmount > 0 || pierceAmount > 0 || pullAmount > 0 ||
        pushAmount > 0 || shieldAmount > 0 || refreshItemAmount > 0;
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
              shieldAmount == other.shieldAmount &&
              refreshItemAmount == other.refreshItemAmount;
}
