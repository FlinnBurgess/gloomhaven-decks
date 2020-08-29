import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/cards/attack_modifier_card.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';

showCardList(context, List<AttackModifierCard> cards) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.maxFinite,
                child: ListView(
                  children: cards
                      .map((card) => Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: card.getImage()))
                      .toList(),
                ),
              )),
        );
      });
}

showDivinerRearrangeableCardList(
    context, Character character, int numberOfCards) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return DivinerRearrangeableCardList(
          context,
          character: character,
          numberOfCards: numberOfCards,
        );
      });
}

class DivinerRearrangeableCardList extends StatefulWidget {
  final BuildContext context;
  final Character character;
  final int numberOfCards;

  DivinerRearrangeableCardList(this.context,
      {this.character, this.numberOfCards});

  @override
  _DivinerRearrangeableCardListState createState() =>
      _DivinerRearrangeableCardListState();
}

class _DivinerRearrangeableCardListState
    extends State<DivinerRearrangeableCardList> {
  List<AttackModifierCard> cardsToDisplay;
  List<AttackModifierCard> toTopDeck;
  List<AttackModifierCard> toGoOnBottom;

  @override
  void initState() {
    super.initState();
    cardsToDisplay = widget.character.attackModifierDeck
        .getCardsToRearrange(widget.numberOfCards);
    toTopDeck = [];
    toGoOnBottom = [];
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      title: OutlinedText.blackAndWhite(
          'Rearrange ${widget.character.name}\'s deck'),
      children: cardsToDisplay
              .map((card) => Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Stack(children: [
                    card.getImage(),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              onPressed: () => setState(() {
                                toTopDeck.add(card);
                                cardsToDisplay.remove(card);
                              }),
                              child: Text('Top'),
                            ),
                            RaisedButton(
                              onPressed: () => setState(() {
                                toGoOnBottom.add(card);
                                cardsToDisplay.remove(card);
                              }),
                              child: Text('Bottom'),
                            ),
                          ],
                        ))
                  ])))
              .toList() +
          [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: Colors.redAccent,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel'),
                  ),
                  RaisedButton(
                    color: Colors.greenAccent,
                    disabledColor: Colors.grey,
                    onPressed: cardsToDisplay.isEmpty
                        ? () {
                            setState(() => widget.character.attackModifierDeck
                                .rearrangeCards(
                                    toTopDeck: toTopDeck,
                                    toGoOnBottom: toGoOnBottom));
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: Text('Confirm'),
                  ),
                ],
              ),
            )
          ],
    );
  }
}
