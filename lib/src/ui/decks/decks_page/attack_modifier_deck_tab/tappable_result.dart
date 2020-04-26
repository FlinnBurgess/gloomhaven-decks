import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';

class TappableResult extends StatelessWidget {
  final AttackModifierResult result;
  final List<AttackModifierCard> cardsApplied;

  TappableResult(this.result, this.cardsApplied);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: Container(
                    width: double.maxFinite,
                    child: ListView(
                      children: cardsApplied
                          .map((card) =>
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: card.getImage()))
                          .toList(),
                    ),
                  ),
                );
              });
        },
        child: Column(
          children: _extractInformationToDisplay(result),
        ));
  }

  static Widget ambiguousDisadvantage(AttackModifierResult firstResult,
      AttackModifierCard firstCard,
      AttackModifierResult secondResult,
      AttackModifierCard secondCard) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Select the worst of the two results')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('First result:'),
                TappableResult(firstResult, [firstCard])
              ],
            ),
            Column(
              children: <Widget>[
                Text('Second result:'),
                TappableResult(secondResult, [secondCard])
              ],
            )
          ],
        )
      ],
    );
  }

  static Widget ambiguousAdvantage(AttackModifierResult firstResult,
      AttackModifierCard firstCard,
      AttackModifierResult secondResult,
      AttackModifierCard secondCard) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Select the better of the two results')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('First result:'),
                TappableResult(firstResult, [firstCard])
              ],
            ),
            Column(
              children: <Widget>[
                Text('Second result:'),
                TappableResult(secondResult, [secondCard])
              ],
            )
          ],
        )
      ],
    );
  }

  List<Widget> _extractInformationToDisplay(AttackModifierResult result) {
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
