import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';

class AttackModifierDeckTab extends StatefulWidget {
  final Character character;

  AttackModifierDeckTab({Key key, @required this.character}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AttackModifierDeckTabState();
}

class AttackModifierDeckTabState extends State<AttackModifierDeckTab> {
  List<AttackModifierCard> cardsInPlay = [];
  AttackModifierResult result = AttackModifierResult();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Column(
        children: <Widget>[
          Text("Damage change: " + result.attackModification.toString()),
          Text("Infusions: " + result.infusions.toString()),
          Text("Conditions: " + result.conditions.toString()),
          Text("NULL? " + result.isNull.toString()),
          Text("Heal self for: " + result.healAmount.toString()),
          Text("Added targets: " + result.addTargetAmount.toString()),
          Text("Pierce amount: " + result.pierceAmount.toString()),
          Text("Pull amount: " + result.pullAmount.toString()),
          Text("Push amount: " + result.pushAmount.toString()),
          Text("Shield amount: " + result.shieldAmount.toString()),
        ],
      ),
      RaisedButton(
        child: Text("Draw card"),
        onPressed: () => setState(() {
          this.widget.character.attackModifierDeck.draw().applyEffect(result);
        }),
      )
    ]);
  }
}
