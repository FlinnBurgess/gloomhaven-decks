import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';

class InfusionCard extends AttackModifierCard {
  InfusionCard(Infusion infusion)
      : super(infusionEffect(infusion), true);
}

Function(AttackModifierResult) infusionEffect(Infusion infusion) {
  return (AttackModifierResult result) => result.addInfusion(infusion);
}
