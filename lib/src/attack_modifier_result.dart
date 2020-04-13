import 'package:gloomhaven_decks/src/attack_effects/attack_effect.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';

import 'conditions/condition.dart';

class AttackModifierResult {
  int attackModification = 0;
  List infusions;
  List conditions;
  var isNull = false;
  int healAmount = 0;
  int addTargetAmount = 0;
  int pierceAmount = 0;
  int pullAmount = 0;
  int pushAmount = 0;

  void applyDamageDifference(int difference) {
    attackModification += difference;
  }

  void addInfusion(Infusion infusion) {
    if (!infusions.contains(infusion)) {
      infusions.add(infusion);
    }
  }

  void addCondition(Condition condition) {
    if (!conditions.contains(condition)) {
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
    }
  }
}
