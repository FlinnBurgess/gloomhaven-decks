import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';

class NullDamageCard extends AttackModifierCard {
  NullDamageCard() : super(nullEffect(), false, 'images/cards/base/null.png');
}

Function(AttackModifierResult) nullEffect() {
  return (AttackModifierResult result) async {
    bool lessRandomness = await getLessRandomnessSetting();
    result.applyDamageDifference(lessRandomness ? -2 : -result.totalDamage);
    result.isNull = true;
  };
}
