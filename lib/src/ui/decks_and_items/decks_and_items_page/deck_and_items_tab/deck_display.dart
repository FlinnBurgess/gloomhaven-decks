import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/cards/bless_card.dart';
import 'package:gloomhaven_decks/src/cards/curse_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/player_characters.dart';
import 'package:gloomhaven_decks/src/conditions/condition.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';
import 'package:gloomhaven_decks/src/ui/card_list.dart';
import 'package:gloomhaven_decks/src/ui/decks_and_items/decks_and_items_page/deck_and_items_tab/tappable_result.dart';
import 'package:provider/provider.dart';

import '../../../../attack_modifier_result.dart';
import '../../../incrementer.dart';
import '../../../misc_icons.dart';
import '../../../outlined_text.dart';

class DeckDisplay extends StatefulWidget {
  final Character character;
  final AttackModifierDeck deck;

  @override
  _DeckDisplayState createState() => _DeckDisplayState();

  DeckDisplay({Key key, @required this.character})
      : deck = character.attackModifierDeck;
}

class _DeckDisplayState extends State<DeckDisplay>
    with TickerProviderStateMixin {
  Widget resultDisplay;
  int initialDamage = 0;
  bool targetIsPoisoned = false;
  bool characterHasAdvantage = false;
  bool characterDisadvantaged = false;
  int numberOfCardsToReorder = 1;

  AssetImage nullImage = AssetImage('images/attack_modifiers/null.png');
  AssetImage nullImageGrey =
      AssetImage('images/attack_modifiers/null-grey.png');
  AssetImage doubleDamageImage =
      AssetImage('images/attack_modifiers/double.png');
  AssetImage doubleDamageImageGrey =
      AssetImage('images/attack_modifiers/double-grey.png');

  AnimationController _animationController;
  Animation<double> _resultAnimation;

  ScrollController _scrollController = ScrollController();
  bool _canScrollDown = false;

  AnimationController _scrollIndicatorAnimationController;
  Animation<double> _scrollIndicatorAnimation;

  _DeckDisplayState() {
    _scrollController.addListener(_showScrollIndicator);
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    _scrollIndicatorAnimationController.stop();
    _scrollIndicatorAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showScrollIndicator());
    _scrollIndicatorAnimationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _scrollIndicatorAnimation = Tween<double>(begin: 0, end: 5)
        .animate(_scrollIndicatorAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _scrollIndicatorAnimationController.repeat(reverse: true);
    _animationController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    _resultAnimation =
        Tween<double>(begin: 1, end: 1.1).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.only(top: 25),
            child: Column(children: <Widget>[
              resultDisplay == null
                  ? Container(
                      height: 178,
                      child: Center(
                          child: OutlinedText.blackAndWhite(
                              "Draw cards to see results")))
                  : Transform.scale(
                      scale: _resultAnimation.value, child: resultDisplay),
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
                                : () => this.setState(
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
                  child: Text('Shuffle deck (' +
                      this.widget.deck.discardPileSize().toString() +
                      ')'),
                  onPressed: () => setState(() {
                    this.widget.deck.shuffle();
                    resultDisplay = null;
                  }),
                ),
                RaisedButton(
                  child: Text("Draw cards (" +
                      this.widget.deck.drawPileSize().toString() +
                      ')'),
                  splashColor: Colors.black,
                  onPressed: () async {
                    setState(() {
                      resultDisplay = getResultsBasedOnSettings(
                          Provider.of<Settings>(context).lessRandomnessSetting);
                    });
                    await _animationController.forward();
                    _animationController.reverse();
                    this.widget.deck.discardCardsDrawn();
                    await _scrollController.animateTo(0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                  },
                )
              ]),
              Wrap(
                spacing: 10,
                children: <Widget>[
                  Icon(
                    Icons.refresh,
                    size: 50,
                    color: (this.widget.deck.doubleDamageDrawn ||
                            this.widget.deck.nullDrawn)
                        ? Colors.green
                        : Colors.black38,
                  ),
                  Image(
                    image: this.widget.deck.doubleDamageDrawn
                        ? doubleDamageImage
                        : doubleDamageImageGrey,
                    width: 50,
                    height: 50,
                  ),
                  Image(
                    image:
                        this.widget.deck.nullDrawn ? nullImage : nullImageGrey,
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15),
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
                                : (value) => setState(
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
                                : (value) => setState(
                                    () => characterDisadvantaged = value),
                          )
                        ],
                      )
                    ],
                  )),
              widget.character.runtimeType.toString() == 'Diviner'
                  ? Padding(padding: EdgeInsets.only(top: 30), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      RaisedButton(
                        onPressed: () => _rearrangeAttackModifierDeck(
                            context,
                            numberOfCardsToReorder,
                            Provider.of<PlayerCharacters>(context,
                                    listen: false)
                                .characters),
                        child: Text(
                          'Rearrange cards\n(Diviner)',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Incrementer(
                        label: 'Number of cards',
                        incrementBehaviour: () =>
                            setState(() => numberOfCardsToReorder++),
                        incrementEnabledCondition: () => true,
                        decrementBehaviour: () =>
                            setState(() => numberOfCardsToReorder--),
                        decrementEnabledCondition: () =>
                            numberOfCardsToReorder > 1,
                        valueCalculation: () => numberOfCardsToReorder,
                      )
                    ])
)                  : Container(),
              getDeckStatus(this.widget.deck),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Incrementer(
                      label: '-1 scenario effect',
                      incrementBehaviour: () {
                        if (this
                            .widget
                            .character
                            .ignoreNegativeScenarioEffects) {
                          Fluttertoast.showToast(
                              msg: 'Reminder: ' +
                                  this.widget.character.name +
                                  ' should ignore negative scenario effects.',
                              backgroundColor: Colors.black);
                        }
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
                padding: EdgeInsets.only(top: 30),
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
                height: 30,
              )
            ]),
          )),
      Positioned(
          bottom: _scrollIndicatorAnimation.value,
          child: _canScrollDown
              ? Icon(
                  Icons.keyboard_arrow_down,
                  size: 50,
                  color: Colors.white,
                )
              : Container()),
    ]);
  }

  Widget getDeckStatus(AttackModifierDeck deck) {
    var rowItems = <Widget>[];
    rowItems.add(deck.isCursed() ? curseIcon : inactiveCurseIcon);
    rowItems.add(deck.isBlessed() ? blessIcon : inactiveBlessIcon);
    rowItems.add(deck.scenarioEffectMinusOneCards > 0
        ? Icon(
            MiscIcons.minus_one,
            color: Colors.red[900],
          )
        : Icon(
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

  Widget getResultsBasedOnSettings(lessRandomness) {
    if (characterHasAdvantage) {
      return getAdvantageResults(lessRandomness);
    } else if (characterDisadvantaged) {
      return getDisadvantageResults(lessRandomness);
    }

    return getResult(lessRandomness);
  }

  getResult(lessRandomness) {
    var result = AttackModifierResult();
    result.applyDamageDifference(initialDamage + (targetIsPoisoned ? 1 : 0));
    List<AttackModifierCard> cardsInPlay =
        this.widget.deck.drawUntilNonRollingCard();

    result = result.applyCards(cardsInPlay, lessRandomness);
    return TappableResult(result, cardsInPlay);
  }

  getAdvantageResults(lessRandomness) {
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
        firstResult =
            firstResult.applyCardEffect(cardsInPlay[0], lessRandomness);
        secondResult =
            secondResult.applyCardEffect(cardsInPlay[1], lessRandomness);

        AttackModifierResult result = betterResult(firstResult, secondResult);
        if (result == null || result == firstResult) {
          return TappableResult(firstResult, cardsInPlay);
        } else {
          return TappableResult(secondResult, cardsInPlay);
        }
      }
    }

    var result = firstResult.applyCards(cardsInPlay, lessRandomness);
    return TappableResult(result, cardsInPlay);
  }

  getDisadvantageResults(lessRandomness) {
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
        var result =
            firstResult.applyCardEffect(cardsInPlay[0], lessRandomness);
        return TappableResult(result, cardsInPlay);
      } else {
        firstResult =
            firstResult.applyCardEffect(cardsInPlay[0], lessRandomness);
        secondResult =
            secondResult.applyCardEffect(cardsInPlay[1], lessRandomness);
        AttackModifierResult result = worseResult(firstResult, secondResult);
        if (result == null || result == firstResult) {
          return TappableResult(firstResult, cardsInPlay);
        } else {
          return TappableResult(secondResult, cardsInPlay);
        }
      }
    } else {
      var result =
          firstResult.applyCardEffect(cardsInPlay.last, lessRandomness);
      return TappableResult(result, cardsInPlay);
    }
  }

  _showScrollIndicator() {
    setState(() {
      _canScrollDown =
          _scrollController.offset < _scrollController.position.maxScrollExtent;
    });
  }

  _rearrangeAttackModifierDeck(
      context, int numberOfCardsToReorder, List<Character> characters) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Choose a character'),
            children: characters
                .map((character) => SimpleDialogOption(
                      onPressed: () => showDivinerRearrangeableCardList(context, character, numberOfCardsToReorder),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(character.characterIcon),
                            SizedBox(
                              width: 10,
                            ),
                            Text(character.name)
                          ]),
                    ))
                .toList(),
          );
        });
  }
}
