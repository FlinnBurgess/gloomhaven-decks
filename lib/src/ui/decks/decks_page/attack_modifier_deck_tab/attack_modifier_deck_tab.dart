import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/cards/bless_card.dart';
import 'package:gloomhaven_decks/src/cards/curse_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';

class AttackModifierDeckTab extends StatefulWidget {
  final AttackModifierDeck deck;

  AttackModifierDeckTab({Key key, @required Character character})
      : deck = character.attackModifierDeck,
        super(key: key);

  @override
  State<StatefulWidget> createState() => AttackModifierDeckTabState();
}

//TODO advantage/disadvantage, this will difficult as which is better/worse is not objective. Idea: Display two results if needs be and let the player pick the best/worst one. If one or both of the cards are rolling, then there will only be a single result anyway
//TODO double damage effect is currently broken, since the damage modifier starts at zero, rather than the damage of the attack being used. User might have to input starting damage.
//TODO Persist state of the decks page tabs so that navigating away doesn't reset them
//TODO attackModification should start at 1 if the opponent is poisoned
class AttackModifierDeckTabState extends State<AttackModifierDeckTab> {
  List<AttackModifierCard> cardsInPlay = [];
  AttackModifierResult result = AttackModifierResult();
  int initialDamage;
  bool targetIsPoisoned = false;
  bool characterHasAdvantage = false;
  bool characterDisadvantaged = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      result.getDisplayWidget(),
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
          cardsInPlay = this.widget.deck.drawUntilNonRollingCard();
          setState(() {
            result.reset();
            if (targetIsPoisoned) {
              result.applyDamageDifference(1);
            }
            result.applyDamageDifference(initialDamage);
            cardsInPlay.forEach((card) => result.applyCardEffect(card));
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
