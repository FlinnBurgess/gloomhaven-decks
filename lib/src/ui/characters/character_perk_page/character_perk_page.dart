import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:provider/provider.dart';

//TODO save characters to phone on perk update
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
        for (int i = 0; i < perk.perksUsed; i++) {
          perkOptions.add(Checkbox(
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
          perkOptions.add(Checkbox(
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
          padding: EdgeInsets.fromLTRB(0, 17, 0, 0),
          child: Text(perk.description),
        ));
        perkRows.add(Align(
            alignment: Alignment.centerLeft,
            child: Wrap(children: perkOptions)));
      });

      var perkList = Column(children: perkRows);

      return Scaffold(
        appBar: AppBar(
          title: Text(this.widget.character.name +
              ' the ' +
              this.widget.character.runtimeType.toString()),
        ),
        body: Center(
          child: perkList,
        ),
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
