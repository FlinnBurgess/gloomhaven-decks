import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/attack_modifier_deck_tab/tappable_result.dart';

class AdvantagedResultDisplay extends StatelessWidget {
  final AttackModifierDeck deck;
  final int initialAttackDamage;
  final bool targetIsPoisoned;
  final AttackModifierResult firstResult = AttackModifierResult();
  final AttackModifierResult secondResult = AttackModifierResult();

  AdvantagedResultDisplay(
      this.deck, this.initialAttackDamage, this.targetIsPoisoned);

  @override
  Widget build(BuildContext context) {
    firstResult.applyDamageDifference(initialAttackDamage);
    secondResult.applyDamageDifference(initialAttackDamage);
    if (targetIsPoisoned) {
      firstResult.applyDamageDifference(1);
      secondResult.applyDamageDifference(1);
    }

    List<AttackModifierCard> cardsInPlay = deck.drawUntilNonRollingCard();
    if (cardsInPlay.length == 1) {
      cardsInPlay.add(deck.draw());
      if (!cardsInPlay[1].isRolling) {
        cardsInPlay[0].applyEffect(firstResult);
        cardsInPlay[1].applyEffect(secondResult);
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text('Select the better of the two results')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(children: <Widget>[
                  Text('First result:'),
                  TappableResult(firstResult, [cardsInPlay[0]])
                ]),
                Column(children: <Widget>[
                  Text('Second result:'),
                  TappableResult(secondResult, [cardsInPlay[1]])
                ])
              ],
            )
          ],
        );
      }
    }

    cardsInPlay.forEach((card) => card.applyEffect(firstResult));
    return TappableResult(firstResult, cardsInPlay);
  }
}
