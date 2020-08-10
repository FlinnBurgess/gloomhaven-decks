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
  ScrollController _scrollController = ScrollController();
  bool _canScrollDown = false;

  AnimationController _scrollIndicatorAnimationController;
  Animation<double> _scrollIndicatorAnimation;

  bool _showDecks = true;

  AttackModifierDeckTabState() {
    _scrollController.addListener(_showScrollIndicator);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollIndicatorAnimationController.stop();
    _scrollIndicatorAnimationController.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(alignment: Alignment.bottomCenter, children: [
      _showDecks
          ? DeckDisplay(
              character: this.widget.character,
              scrollController: _scrollController)
          : ItemsDisplay(
              character: this.widget.character,
              scrollController: _scrollController,
            ),
      Positioned(
          bottom: _scrollIndicatorAnimation.value,
          child: _canScrollDown
              ? Icon(
                  Icons.keyboard_arrow_down,
                  size: 50,
                  color: Colors.white,
                )
              : Container()),
      Positioned(
          top: 70,
          right: 0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showDecks = true;
              });
              _showScrollIndicator();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: _showDecks ? Colors.yellow : Colors.transparent, width: 1.5),
                  color: Colors.black45),
              child: Image(
                image: AssetImage('images/deck.png'),
                color: Colors.white,
              ),
            ),
          )),
      Positioned(
          top: 130,
          right: 0,
          child: GestureDetector(
            onTap: () {
              setState(() => _showDecks = false);
              _showScrollIndicator();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: _showDecks ? Colors.transparent : Colors.yellow, width: 1.5),
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

  _showScrollIndicator() {
    setState(() {
      _canScrollDown =
          _scrollController.offset < _scrollController.position.maxScrollExtent;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
