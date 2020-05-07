import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/app_ads.dart';
import 'package:gloomhaven_decks/src/attack_modifier_result.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/cards/bless_card.dart';
import 'package:gloomhaven_decks/src/cards/curse_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/attack_modifier_deck_tab/tappable_result.dart';
import 'package:gloomhaven_decks/src/ui/icrementer.dart';
import 'package:gloomhaven_decks/src/ui/misc_icons.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';

//TODO Animate the result when user draws cards, to make it more obvious that they tapped it when thee result is the same
class AttackModifierDeckTab extends StatefulWidget {
  final AttackModifierDeck deck;
  final Function saveCharacters;

  AttackModifierDeckTab({Key key, @required Character character, @required this.saveCharacters})
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
  AssetImage doubleDamageImage = AssetImage(
      'images/attack_modifiers/double.png');

  @override
  void initState() {
    initAds();
    super.initState();
    ads.showBannerAd(adUnitId: deckPageBannerAdId, size: AdSize.smartBanner);
  }

  @override
  void dispose() {
    ads.dispose();
    super.dispose();
  }

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
                  child: Row(
                    children: <Widget>[
                      Text('Shuffle deck'),
                      this.widget.deck.doubleDamageDrawn
                          ? Image(
                        image: doubleDamageImage, width: 40, height: 40,)
                          : Container(),
                      this.widget.deck.nullDrawn ? Image(
                        image: nullImage, width: 40, height: 40,) : Container(),
                    ],
                  ),
                  onPressed: () =>
                      setState(() {
                        this.widget.deck.shuffle();
                        resultDisplay = null;
                      }),
                ),
                RaisedButton(
                  child: Text("Draw cards"),
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
                      label: '-1 item effect',
                      incrementBehaviour: () {
                        setState(() {
                          this.widget.deck.addItemEffectMinusOneCard();
                          this.widget.saveCharacters();
                        });
                      },
                      decrementBehaviour: () {
                        setState(() {
                          this.widget.deck.removeItemEffectMinusOneCard();
                          this.widget.saveCharacters();
                        });
                      },
                      decrementEnabledCondition: () =>
                      this.widget.deck.itemEffectMinusOneCards > 0,
                      valueCalculation: () =>
                      this.widget.deck.itemEffectMinusOneCards,
                    ),
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
              Container(
                height: 60,
              )
            ])));
  }

  Widget getDeckStatus(AttackModifierDeck deck) {
    var rowItems = <Widget>[];
    if (deck.isCursed()) {
      rowItems.add(curseIcon);
    }
    if (deck.isBlessed()) {
      rowItems.add(blessIcon);
    }
    if (deck.itemEffectMinusOneCards > 0 ||
        deck.scenarioEffectMinusOneCards > 0) {
      rowItems.add(Icon(
        MiscIcons.minus_one,
        color: Colors.red[700],
      ));
    }

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
        return TappableResult.ambiguousAdvantage(
            firstResult, cardsInPlay[0], secondResult, cardsInPlay[1]);
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
        return TappableResult.ambiguousDisadvantage(
            firstResult, cardsInPlay[0], secondResult, cardsInPlay[1]);
      }
    } else {
      var result = await firstResult.applyCardEffect(cardsInPlay.last);
      return TappableResult(result, cardsInPlay);
    }
  }
}
