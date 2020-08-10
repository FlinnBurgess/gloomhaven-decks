import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/decks/attack_modifier/attack_modifier_deck.dart';

import 'deck_display.dart';
import 'items_display.dart';

class AttackModifierDeckTab extends StatefulWidget {
  final Character character;
  final AttackModifierDeck deck;
  final Function saveCharacters;

  AttackModifierDeckTab(
      {Key key, @required this.character, @required this.saveCharacters})
      : deck = character.attackModifierDeck,
        super(key: key);

  @override
  State<StatefulWidget> createState() => AttackModifierDeckTabState();
}

class AttackModifierDeckTabState extends State<AttackModifierDeckTab>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool _showDecks = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    bool isWideScreen = MediaQuery.of(context).size.width > 1000;
    Widget uiToDisplay;

    if (isWideScreen) {
      uiToDisplay = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.45, child: DeckDisplay(character: this.widget.character)),
          Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: ItemsDisplay(
                character: this.widget.character,
              )),
        ],
      );
    } else if (_showDecks) {
      uiToDisplay = DeckDisplay(
        character: this.widget.character,
      );
    } else {
      uiToDisplay = ItemsDisplay(
        character: this.widget.character,
      );
    }

    return Stack(alignment: Alignment.bottomCenter, children: [
      uiToDisplay,
      isWideScreen
          ? Container()
          : Positioned(
              top: 70,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showDecks = true;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              _showDecks ? Colors.yellow : Colors.transparent,
                          width: 1.5),
                      color: Colors.black45),
                  child: Image(
                    image: AssetImage('images/deck.png'),
                    color: Colors.white,
                  ),
                ),
              )),
      isWideScreen
          ? Container()
          : Positioned(
              top: 130,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() => _showDecks = false);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              _showDecks ? Colors.transparent : Colors.yellow,
                          width: 1.5),
                      color: Colors.black45),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Image(
                        image: AssetImage('images/bag.png'),
                        color: Colors.brown[300],
                      )),
                ),
              )),
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}
