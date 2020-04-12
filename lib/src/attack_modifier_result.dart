import 'package:gloomhaven_decks/src/elemental_infusions.dart';

class AttackModifierResult {
  int attackModification = 0;
  List infusions;
  List conditions;
  var isNull = false;

  void applyDamageDifference(int difference) {
    attackModification += difference;
  }

  void addInfusion(Infusion infusion) {
    if (!infusions.contains(infusion)) {
      infusions.add(infusion);
    }
  }

  void addCondition(condition) {
    if (!conditions.contains(condition)) {
      conditions.add(condition);
    }
  }
}
