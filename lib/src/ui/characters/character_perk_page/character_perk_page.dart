import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

// TODO replace placeholder with icons in text (https://stackoverflow.com/questions/56840994/how-to-show-icon-in-text-widget-in-flutter)
class CharacterPerkPage extends StatefulWidget {
  final Character character;

  CharacterPerkPage({Key key, @required this.character}) : super(key: key);

  @override
  _CharacterPerkPageState createState() => _CharacterPerkPageState();
}

class _CharacterPerkPageState extends State<CharacterPerkPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Characters>(builder: (context, characters, child) {
      List<Widget> perkRows = [];
      this.widget.character.perks.forEach((perk) {
        List<Widget> perkOptions = [];
        List<Widget> checkboxes = [];
        for (int i = 0; i < perk.perksUsed; i++) {
          checkboxes.add(Checkbox(
              value: true,
              onChanged: (value) {
                bool successfullyUnapplied =
                this.widget.character.attackModifierDeck.unapplyPerk(perk);
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
                this.widget.character.attackModifierDeck.applyPerk(perk);
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
              child: OutlinedText.blackAndWhite(perk.description),
            )));
        perkRows.add(Align(
            alignment: Alignment.centerLeft,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: perkOptions)));
      });

      var perkList = ListView(children: perkRows);

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: OutlinedText.blackAndWhite(
              'Perks for ' + this.widget.character.name +
                  ' the ' +
                  this.widget.character.runtimeType
                      .toString()
                      .titleCase),
        ),
        body: AppBackground(child: SafeArea(child: Center(
          child: perkList,
        ))),
      );
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
