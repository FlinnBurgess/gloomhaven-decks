import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';

class InfusionCard extends AttackModifierCard {
  InfusionCard(Infusion infusion, String characterClass)
      : super(infusionEffect(infusion), true,
      'images/cards/${characterClass.toLowerCase()}/rolling-${infusion
          .toString()
          .split('.')
          .last
          .toLowerCase()}.png');
}

Function(AttackModifierResult) infusionEffect(Infusion infusion) {
  return (AttackModifierResult result) => result.addInfusion(infusion);
}
