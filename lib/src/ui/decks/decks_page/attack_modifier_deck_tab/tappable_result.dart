import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/elemental_infusions.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';

class TappableResult extends StatelessWidget {
  final AttackModifierResult result;
  final List<AttackModifierCard> cardsApplied;

  TappableResult(this.result, this.cardsApplied);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showCardList(context);
        },
        child: Column(
          children: _extractInformationToDisplay(result) +
              [
                RaisedButton(
                  child: Text('See cards'),
                  onPressed: () => showCardList(context),
                )
              ],
        ));
  }

  showCardList(context) {
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
  }

  static Widget ambiguousDisadvantage(AttackModifierResult firstResult,
      AttackModifierCard firstCard,
      AttackModifierResult secondResult,
      AttackModifierCard secondCard) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedText.blackAndWhite('Select the worst of the two results')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                OutlinedText.blackAndWhite('First result:'),
                TappableResult(firstResult, [firstCard])
              ],
            ),
            Column(
              children: <Widget>[
                OutlinedText.blackAndWhite('Second result:'),
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
          children: <Widget>[
            OutlinedText.blackAndWhite('Select the better of the two results')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                OutlinedText.blackAndWhite('First result:'),
                TappableResult(firstResult, [firstCard])
              ],
            ),
            Column(
              children: <Widget>[
                OutlinedText.blackAndWhite('Second result:'),
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
      OutlinedText.blackAndWhite(
          'Total damage: ' + result.totalDamage.toString()),
      result.infusions.isEmpty
          ? null
          : infusionsDisplay(result.infusions),
      result.conditions.isEmpty
          ? null
          : OutlinedText.blackAndWhite(result.conditions.toString()),
      result.isNull ? OutlinedText.blackAndWhite("NULL") : null,
      result.addTargetAmount == 0
          ? null
          : OutlinedText.blackAndWhite(
          "Added targets: " + result.addTargetAmount.toString()),
      result.pierceAmount == 0
          ? null
          : OutlinedText.blackAndWhite(
          "Pierce: " + result.pierceAmount.toString()),
      result.pullAmount == 0
          ? null
          : OutlinedText.blackAndWhite("Pull: " + result.pullAmount.toString()),
      result.pushAmount == 0
          ? null
          : OutlinedText.blackAndWhite("Push: " + result.pushAmount.toString()),
      result.healAmount == 0
          ? null
          : OutlinedText.blackAndWhite(
          "Heal amount: " + result.healAmount.toString()),
      result.shieldAmount == 0
          ? null
          : OutlinedText.blackAndWhite(
          "Shield amount: " + result.shieldAmount.toString()),
      result.refreshItemAmount == 0
          ? null
          : OutlinedText.blackAndWhite(
          "Refreshed items: " + result.refreshItemAmount.toString())
    ];

    displayInformation.removeWhere((widget) => widget == null);

    return displayInformation;
  }

  Widget infusionsDisplay(List infusions) {
    var children = infusions
        .map<Widget>((infusion) =>
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: getInfusionIcon(infusion)))
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[OutlinedText.blackAndWhite('Infusions: ')] + children,
    );
  }
}
