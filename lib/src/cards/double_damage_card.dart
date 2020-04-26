import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';

class DoubleDamageCard extends AttackModifierCard {
  DoubleDamageCard()
      : super(
      doubleDamageEffect(), false, 'images/cards/base/double-damage.png');
}

Function(AttackModifierResult) doubleDamageEffect() {
  return (AttackModifierResult result) async {
    bool lessRandomness = await getLessRandomnessSetting();
    result.applyDamageDifference(lessRandomness ? 2 : result.totalDamage);
  };
}
