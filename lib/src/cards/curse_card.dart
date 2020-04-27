import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';

import '../attack_modifier_result.dart';

class CurseCard extends AttackModifierCard {
  static int totalCurseCardsInPlay = 0;

  CurseCard() : super(nullEffect(), false, 'images/cards/base/curse.png');
}

Function(AttackModifierResult) nullEffect() {
  return (AttackModifierResult result) async {
    bool lessRandomness = await getLessRandomnessSetting();
    result.applyDamageDifference(lessRandomness ? -2 : -result.totalDamage);
    result.isNull = true;
  };
}
