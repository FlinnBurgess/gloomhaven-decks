import 'package:flutter/cupertino.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';

class DisadvantagedResultDisplay extends StatelessWidget {
  final AttackModifierDeck deck;
  final int initialAttackDamage;
  final bool targetIsPoisoned;
  final AttackModifierResult firstResult = AttackModifierResult();
  final AttackModifierResult secondResult = AttackModifierResult();

  DisadvantagedResultDisplay(
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
      if (cardsInPlay[1].isRolling) {
        cardsInPlay[0].applyEffect(firstResult);
        return Column(children: extractInformationToDisplay(firstResult));
      } else {
        cardsInPlay[0].applyEffect(firstResult);
        cardsInPlay[1].applyEffect(secondResult);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: extractInformationToDisplay(firstResult),
            ),
            Column(
              children: extractInformationToDisplay(secondResult),
            )
          ],
        );
      }
    } else if (cardsInPlay.length == 2) {
      cardsInPlay[1].applyEffect(firstResult);
      return Column(
        children: extractInformationToDisplay(firstResult),
      );
    } else {
      cardsInPlay.last.applyEffect(firstResult);
      return Column(
        children: extractInformationToDisplay(firstResult),
      );
    }
  }

  List<Widget> extractInformationToDisplay(AttackModifierResult result) {
    List<Widget> displayInformation = [
      Text('Total damage: ' + result.totalDamage.toString()),
      result.infusions.isEmpty ? null : Text(result.infusions.toString()),
      result.conditions.isEmpty ? null : Text(result.conditions.toString()),
      result.isNull ? Text("NULL") : null,
      result.addTargetAmount == 0
          ? null
          : Text("Added targets: " + result.addTargetAmount.toString()),
      result.pierceAmount == 0
          ? null
          : Text("Pierce: " + result.pierceAmount.toString()),
      result.pullAmount == 0
          ? null
          : Text("Pull: " + result.pullAmount.toString()),
      result.pushAmount == 0
          ? null
          : Text("Push: " + result.pushAmount.toString()),
      result.healAmount == 0
          ? null
          : Text("Heal amount: " + result.healAmount.toString()),
      result.shieldAmount == 0
          ? null
          : Text("Shield amount: " + result.shieldAmount.toString()),
    ];

    displayInformation.removeWhere((widget) => widget == null);

    return displayInformation;
  }
}
