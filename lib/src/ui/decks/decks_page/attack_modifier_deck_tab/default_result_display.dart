import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/attack_modifier_deck_tab/tappable_result.dart';

class DefaultResultDisplay extends StatelessWidget {
  final AttackModifierDeck deck;
  final int initialAttackDamage;
  final bool targetIsPoisoned;
  final AttackModifierResult result = AttackModifierResult();

  DefaultResultDisplay(
      this.deck, this.initialAttackDamage, this.targetIsPoisoned);

  @override
  Widget build(BuildContext context) {
    result.applyDamageDifference(initialAttackDamage);
    if (targetIsPoisoned) {
      result.applyDamageDifference(1);
    }

    List<AttackModifierCard> cardsInPlay = deck.drawUntilNonRollingCard();
    cardsInPlay.forEach((card) => card.applyEffect(result));

    return TappableResult(result, cardsInPlay);
  }
}
