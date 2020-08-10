import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';

import '../../../card_list.dart';

class TappableResult extends StatelessWidget {
  final AttackModifierResult result;
  final List<AttackModifierCard> cardsApplied;

  TappableResult(this.result, this.cardsApplied);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showCardList(context, cardsApplied);
        },
        child: Column(
          children: _extractInformationToDisplay(result) +
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('See cards'),
                      onPressed: () => showCardList(context, cardsApplied),
                    )
                  ],
                )
              ],
        ));
  }

  List<Widget> _extractInformationToDisplay(AttackModifierResult result) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            OutlinedText.blackAndWhite(
                'Total damage: ' + result.totalDamage.toString()),
            infusionsDisplay(result.infusions),
            conditionsDisplay(result.conditions),
            numericalDisplay(result.addTargetAmount, 'Added targets'),
            numericalDisplay(result.pierceAmount, 'Pierce'),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            numericalDisplay(result.pullAmount, 'Pull'),
            numericalDisplay(result.pushAmount, 'Push'),
            numericalDisplay(result.healAmount, 'Heal amount'),
            numericalDisplay(result.shieldAmount, 'Shield amount'),
            numericalDisplay(result.refreshItemAmount, 'Refreshed items'),
          ],
        ),
      ])
    ];
  }

  Widget infusionsDisplay(List infusions) {
    if (infusions.isEmpty) {
      return OutlinedText('Infusions: none', Colors.black45, Colors.black45);
    }
    var children = infusions
        .map<Widget>((infusion) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: getInfusionIcon(infusion)))
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[OutlinedText.blackAndWhite('Infusions: ')] + children,
    );
  }

  Widget conditionsDisplay(List conditions) {
    if (conditions.isEmpty) {
      return OutlinedText('Conditions: none', Colors.black38, Colors.black38);
    }
    var children = conditions
        .map<Widget>((condition) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: getConditionIcon(condition)))
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[OutlinedText.blackAndWhite('Conditions: ')] + children,
    );
  }

  Widget numericalDisplay(int amount, String label) {
    if (amount > 0) {
      return OutlinedText.blackAndWhite(label + ': ' + amount.toString());
    } else {
      return OutlinedText(
          label + ': ' + amount.toString(), Colors.black38, Colors.black38);
    }
  }
}
