import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/bless_card.dart';
import 'package:gloomhaven_decks/src/cards/curse_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/attack_modifier_deck_tab/advantaged_result_display.dart';

import 'default_result_display.dart';
import 'disadvantaged_result_display.dart';

class AttackModifierDeckTab extends StatefulWidget {
  final AttackModifierDeck deck;

  AttackModifierDeckTab({Key key, @required Character character})
      : deck = character.attackModifierDeck,
        super(key: key);

  @override
  State<StatefulWidget> createState() => AttackModifierDeckTabState();
}

//TODO Persist state of the decks page tabs so that navigating away doesn't reset them
class AttackModifierDeckTabState extends State<AttackModifierDeckTab> {
  AttackModifierResult result = AttackModifierResult();
  Widget resultDisplay;
  int initialDamage;
  bool targetIsPoisoned = false;
  bool characterHasAdvantage = false;
  bool characterDisadvantaged = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      resultDisplay == null ? Text("Draw cards to see results") : resultDisplay,
      Padding(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          children: <Widget>[
            Text('Enter initial attack damage'),
            TextFormField(
              onChanged: ((value) =>
                  setState(() => initialDamage = int.tryParse(value))),
            )
          ],
        ),
      ),
      RaisedButton(
        child: Text("Draw cards"),
        onPressed: initialDamage == null
            ? null
            : () {
          this.widget.deck.discardCardsDrawn();
          if (this.widget.deck.needsShuffling) {
            this.widget.deck.shuffle();
          }
          setState(() {
            if (characterHasAdvantage) {
              resultDisplay = AdvantagedResultDisplay(
                  this.widget.deck, initialDamage, targetIsPoisoned);
            } else if (characterDisadvantaged) {
              resultDisplay = DisadvantagedResultDisplay(
                  this.widget.deck, initialDamage, targetIsPoisoned);
            } else {
              resultDisplay = DefaultResultDisplay(
                  this.widget.deck, initialDamage, targetIsPoisoned);
            }
          });
        },
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Curse cards')],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () =>
            this.widget.deck.isCursed()
                ? setState(() => this.widget.deck.removeCards([CurseCard()]))
                : null,
          ),
          Text(this.widget.deck.curseCardCount.toString()),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
            CurseCard.totalCurseCardsInPlay < 10
                ? setState(() => this.widget.deck.addCard(CurseCard()))
                : null,
          )
        ],
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Bless cards')],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () =>
            this.widget.deck.isBlessed()
                ? setState(() => this.widget.deck.removeCards([BlessCard()]))
                : null,
          ),
          Text(this.widget.deck.blessCardCount.toString()),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
            BlessCard.totalBlessCardsInPlay < 10
                ? setState(() => this.widget.deck.addCard(BlessCard()))
                : null,
          )
        ],
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Target is poisoned"),
                  Checkbox(
                    value: targetIsPoisoned,
                    onChanged: (value) =>
                        setState(() => targetIsPoisoned = value),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text("Advantage"),
                  Checkbox(
                    value: characterHasAdvantage,
                    onChanged: characterDisadvantaged
                        ? null
                        : (value) =>
                        setState(() => characterHasAdvantage = value),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text("Disadvantage"),
                  Checkbox(
                    value: characterDisadvantaged,
                    onChanged: characterHasAdvantage
                        ? null
                        : (value) =>
                        setState(() => characterDisadvantaged = value),
                  )
                ],
              )
            ],
          ))
    ]);
  }
}
