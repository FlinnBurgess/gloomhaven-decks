import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/player_characters.dart';
import 'package:gloomhaven_decks/src/perks/perk.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/card_list.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class CharacterPerkPage extends StatefulWidget {
  final Character character;

  CharacterPerkPage({Key key, @required this.character}) : super(key: key);

  @override
  _CharacterPerkPageState createState() => _CharacterPerkPageState();
}

class _CharacterPerkPageState extends State<CharacterPerkPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scrollIndicatorAnimation;
  ScrollController _scrollController = ScrollController();
  bool _canScrollDown = false;


  _CharacterPerkPageState() {
    _scrollController.addListener(_showScrollIndicator);
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showScrollIndicator());
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _scrollIndicatorAnimation =
        Tween<double>(begin: 0, end: 5).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });

    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerCharacters>(builder: (context, characters, child) {
      List<Widget> perkRows = [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          RaisedButton(
            child: Text("View deck"),
            onPressed: () => showCardList(
                context, this.widget.character.attackModifierDeck.getDeck()),
          )
        ])
      ];
      this.widget.character.perks.forEach((perk) {
        List<Widget> perkOptions = [];
        List<Widget> checkboxes = [];
        for (int i = 0; i < perk.perksUsed; i++) {
          checkboxes.add(Checkbox(
              value: true,
              onChanged: (value) {
                bool successfullyUnapplied =
                    this.widget.character.unapplyPerk(perk);
                if (successfullyUnapplied) {
                  characters.save();
                  setState(() {
                    perk.perksAvailable++;
                    perk.perksUsed--;
                  });
                } else {
                  showFailureMessage(context);
                }
              }));
        }
        for (int i = 0; i < perk.perksAvailable; i++) {
          checkboxes.add(Checkbox(
              value: false,
              onChanged: (value) {
                bool successfullyApplied =
                    this.widget.character.applyPerk(perk);
                if (successfullyApplied) {
                  characters.save();
                  setState(() {
                    perk.perksAvailable--;
                    perk.perksUsed++;
                  });
                } else {
                  showFailureMessage(context);
                }
              }));
        }
        perkOptions.add(Padding(
          padding: EdgeInsets.fromLTRB(0, 18, 0, 0),
          child: Row(
            children: checkboxes,
          ),
        ));
        perkOptions.add(Flexible(
            child: Padding(
          padding: EdgeInsets.fromLTRB(0, 17, 0, 0),
          child: perkText(perk.description),
        )));
        perkRows.add(Align(
            alignment: Alignment.centerLeft,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: perkOptions)));
      });

      var perkList = Stack(alignment: Alignment.bottomCenter, children: [
        ListView(controller: _scrollController, children: perkRows),
        Positioned(
            bottom: _scrollIndicatorAnimation.value,
            child: _canScrollDown
                ? Icon(
              Icons.keyboard_arrow_down,
              size: 50,
              color: Colors.white,
            )
                : Container())
      ]);

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: OutlinedText.blackAndWhite('Perks for ' +
              this.widget.character.name +
              ' the ' +
              this.widget.character.runtimeType.toString().titleCase),
        ),
        body: AppBackground(
            child: SafeArea(
                child: Center(
          child: perkList,
        ))),
      );
    });
  }

  _showScrollIndicator() {
    setState(() {
      _canScrollDown =
          _scrollController.offset < _scrollController.position.maxScrollExtent;
    });
  }

  void showFailureMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Failed to apply/unapply perk"),
            content: Text(
                "This is usually because you're trying to remove cards that aren't in your deck. Does this perk depend on another one?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Close"))
            ],
          );
        });
  }
}
