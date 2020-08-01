import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/cards/bless_card.dart';
import 'package:gloomhaven_decks/src/cards/curse_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/attack_modifier_deck_tab/tappable_result.dart';
import 'package:gloomhaven_decks/src/ui/incrementer.dart';
import 'package:gloomhaven_decks/src/ui/misc_icons.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';

//TODO Animate the result when user draws cards, to make it more obvious that they tapped it when thee result is the same
class AttackModifierDeckTab extends StatefulWidget {
  final AttackModifierDeck deck;
  final Function saveCharacters;

  AttackModifierDeckTab(
      {Key key, @required Character character, @required this.saveCharacters})
      : deck = character.attackModifierDeck,
        super(key: key);

  @override
  State<StatefulWidget> createState() => AttackModifierDeckTabState();
}

class AttackModifierDeckTabState extends State<AttackModifierDeckTab> {
  Widget resultDisplay;
  int initialDamage = 0;
  bool targetIsPoisoned = false;
  bool characterHasAdvantage = false;
  bool characterDisadvantaged = false;
  ScrollController _scrollController = ScrollController();
  AssetImage nullImage = AssetImage('images/attack_modifiers/null.png');
  AssetImage doubleDamageImage =
  AssetImage('images/attack_modifiers/double.png');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
            padding: EdgeInsets.only(top: 25),
            child: Column(children: <Widget>[
              resultDisplay == null
                  ? OutlinedText.blackAndWhite("Draw cards to see results")
                  : resultDisplay,
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: <Widget>[
                    OutlinedText.blackAndWhite('Starting attack damage'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            onPressed: initialDamage == 0
                                ? null
                                : () =>
                                this.setState(
                                      () => initialDamage--,
                                )),
                        OutlinedText.blackAndWhite(initialDamage.toString()),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () => this.setState(() => initialDamage++),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                RaisedButton(
                  child: Column(
                    children: <Widget>[
                      Text('Shuffle deck (' +
                          this.widget.deck.discardPileSize().toString() +
                          ')'),
                      Row(children: [
                        this.widget.deck.doubleDamageDrawn
                            ? Image(
                          image: doubleDamageImage,
                          width: 20,
                          height: 20,
                        )
                            : Container(),
                        this.widget.deck.nullDrawn
                            ? Image(
                          image: nullImage,
                          width: 20,
                          height: 20,
                        )
                            : Container(),
                      ])
                    ],
                  ),
                  onPressed: () =>
                      setState(() {
                        this.widget.deck.shuffle();
                        resultDisplay = null;
                      }),
                ),
                RaisedButton(
                  child: Text("Draw cards (" +
                      this.widget.deck.drawPileSize().toString() +
                      ')'),
                  splashColor: Colors.black,
                  onPressed: () {
                    setState(() {
                      resultDisplay = FutureBuilder<Widget>(
                        future: getResultsBasedOnSettings(),
                        initialData: Container(),
                        builder: (context, snapshot) =>
                        snapshot.hasData
                            ? resultDisplay = snapshot.data
                            : Container(),
                      );
                    });
                    this.widget.deck.discardCardsDrawn();
                    _scrollController.animateTo(0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                  },
                )
              ]),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          OutlinedText.blackAndWhite("Target is poisoned"),
                          Checkbox(
                            value: targetIsPoisoned,
                            onChanged: (value) =>
                                setState(() => targetIsPoisoned = value),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          OutlinedText.blackAndWhite("Advantage"),
                          Checkbox(
                            value: characterHasAdvantage,
                            onChanged: characterDisadvantaged
                                ? null
                                : (value) =>
                                setState(
                                        () => characterHasAdvantage = value),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          OutlinedText.blackAndWhite("Disadvantage"),
                          Checkbox(
                            value: characterDisadvantaged,
                            onChanged: characterHasAdvantage
                                ? null
                                : (value) =>
                                setState(
                                        () => characterDisadvantaged = value),
                          )
                        ],
                      )
                    ],
                  )),
              getDeckStatus(this.widget.deck),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Incrementer(
                      label: '-1 scenario effect',
                      incrementBehaviour: () {
                        setState(() {
                          this.widget.deck.addScenarioEffectMinusOneCard();
                        });
                      },
                      decrementBehaviour: () {
                        setState(() {
                          this.widget.deck.removeScenarioEffectMinusOneCard();
                        });
                      },
                      decrementEnabledCondition: () =>
                      this.widget.deck.scenarioEffectMinusOneCards > 0,
                      valueCalculation: () =>
                      this.widget.deck.scenarioEffectMinusOneCards,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Incrementer(
                      label: 'Curse Cards',
                      incrementBehaviour: () {
                        setState(() {
                          this.widget.deck.addCard(CurseCard());
                        });
                      },
                      incrementEnabledCondition: () =>
                      CurseCard.totalCurseCardsInPlay < 10,
                      decrementBehaviour: () {
                        setState(() {
                          this.widget.deck.removeCards([CurseCard()]);
                        });
                      },
                      decrementEnabledCondition: () =>
                          this.widget.deck.isCursed(),
                      valueCalculation: () => this.widget.deck.curseCardCount,
                    ),
                    Incrementer(
                      label: 'Bless Cards',
                      incrementBehaviour: () {
                        setState(() {
                          this.widget.deck.addCard(BlessCard());
                        });
                      },
                      incrementEnabledCondition: () =>
                      BlessCard.totalBlessCardsInPlay < 10,
                      decrementBehaviour: () {
                        setState(() {
                          this.widget.deck.removeCards([BlessCard()]);
                        });
                      },
                      decrementEnabledCondition: () =>
                          this.widget.deck.isBlessed(),
                      valueCalculation: () => this.widget.deck.blessCardCount,
                    )
                  ],
                ),
              ),
            ])));
  }

  Widget getDeckStatus(AttackModifierDeck deck) {
    var rowItems = <Widget>[];
    rowItems.add(deck.isCursed() ? curseIcon : inactiveCurseIcon);
    rowItems.add(deck.isBlessed() ? blessIcon : inactiveBlessIcon);
    rowItems.add(deck.scenarioEffectMinusOneCards > 0 ? Icon(
      MiscIcons.minus_one,
      color: Colors.red[900],
    ) : Icon(
      MiscIcons.minus_one,
      color: Colors.black45,
    ));

    return rowItems.isEmpty
        ? Container()
        : Padding(
        padding: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowItems,
        ));
  }

  Future<Widget> getResultsBasedOnSettings() async {
    if (characterHasAdvantage) {
      return await getAdvantageResults();
    } else if (characterDisadvantaged) {
      return await getDisadvantageResults();
    }

    return await getResult();
  }

  getResult() async {
    var result = AttackModifierResult();
    result.applyDamageDifference(initialDamage + (targetIsPoisoned ? 1 : 0));
    List<AttackModifierCard> cardsInPlay =
    this.widget.deck.drawUntilNonRollingCard();

    result = await result.applyCards(cardsInPlay);
    return TappableResult(result, cardsInPlay);
  }

  getAdvantageResults() async {
    var firstResult = AttackModifierResult();
    var secondResult = AttackModifierResult();

    firstResult
        .applyDamageDifference(initialDamage + (targetIsPoisoned ? 1 : 0));
    secondResult
        .applyDamageDifference(initialDamage + (targetIsPoisoned ? 1 : 0));

    List<AttackModifierCard> cardsInPlay =
    this.widget.deck.drawUntilNonRollingCard();
    if (cardsInPlay.length == 1) {
      cardsInPlay.add(this.widget.deck.draw());
      if (!cardsInPlay[1].isRolling) {
        firstResult = await firstResult.applyCardEffect(cardsInPlay[0]);
        secondResult = await secondResult.applyCardEffect(cardsInPlay[1]);

        AttackModifierResult result = betterResult(firstResult, secondResult);
        if (result == null || result == firstResult) {
          return TappableResult(firstResult, cardsInPlay);
        } else {
          return TappableResult(secondResult, cardsInPlay);
        }
      }
    }

    var result = await firstResult.applyCards(cardsInPlay);
    return TappableResult(result, cardsInPlay);
  }

  getDisadvantageResults() async {
    var firstResult = AttackModifierResult();
    var secondResult = AttackModifierResult();

    firstResult
        .applyDamageDifference(initialDamage + (targetIsPoisoned ? 1 : 0));
    secondResult
        .applyDamageDifference(initialDamage + (targetIsPoisoned ? 1 : 0));

    List<AttackModifierCard> cardsInPlay =
    this.widget.deck.drawUntilNonRollingCard();
    if (cardsInPlay.length == 1) {
      cardsInPlay.add(this.widget.deck.draw());
      if (cardsInPlay[1].isRolling) {
        var result = await firstResult.applyCardEffect(cardsInPlay[0]);
        return TappableResult(result, cardsInPlay);
      } else {
        firstResult = await firstResult.applyCardEffect(cardsInPlay[0]);
        secondResult = await secondResult.applyCardEffect(cardsInPlay[1]);
        AttackModifierResult result = worseResult(firstResult, secondResult);
        if (result == null || result == firstResult) {
          return TappableResult(firstResult, cardsInPlay);
        } else {
          return TappableResult(secondResult, cardsInPlay);
        }
      }
    } else {
      var result = await firstResult.applyCardEffect(cardsInPlay.last);
      return TappableResult(result, cardsInPlay);
    }
  }
}
