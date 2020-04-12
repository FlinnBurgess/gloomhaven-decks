import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';

class DamageChangeCard extends AttackModifierCard {
  Infusion infusion;

  DamageChangeCard(int damageChange, bool isRolling)
      : super(damageChangeEffect(damageChange), isRolling);

  DamageChangeCard.withInfusion(
      int damageChange, Infusion infusion, bool isRolling)
      : infusion = infusion,
        super(
            damageChangeWithInfusionEffect(damageChange, infusion), isRolling);

  static DamageChangeCard minusOne() {
    return DamageChangeCard(-1, false);
  }

  static DamageChangeCard zero() {
    return DamageChangeCard(0, false);
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
