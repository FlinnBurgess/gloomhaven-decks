import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/classes/character_class.dart';

class CharacterPerkPage extends StatefulWidget {
  final CharacterClass character;

  CharacterPerkPage({Key key, @required this.character}) : super(key: key);

  @override
  _CharacterPerkPageState createState() => _CharacterPerkPageState();
}

class _CharacterPerkPageState extends State<CharacterPerkPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> perkRows = [];
    this.widget.character.perks.forEach((perk) {
      List<Widget> perkOptions = [];
      for (int i = 0; i < perk.perksUsed; i++) {
        perkOptions.add(Checkbox(value: true, onChanged: (value) {
          setState(() {
            perk.perksUsed--;
            perk.perksAvailable++;
          });
        }));
      }
      for (int i = 0; i < perk.perksAvailable; i++) {
        perkOptions.add(Checkbox(value: false, onChanged: (value) {
          setState(() {
            perk.perksAvailable--;
            perk.perksUsed++;
          });
        }));
      }
      perkOptions.add(Padding(padding: EdgeInsets.fromLTRB(0, 17, 0, 0), child: Text(perk.description),));
      perkRows.add(Wrap(alignment: WrapAlignment.start, children: perkOptions));
    });

    var perkList = Column(children: perkRows);

    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.character.name + ' the ' + this.widget.character.runtimeType.toString()),
      ),
      body: Center(
        child: perkList,
      ),
    );
  }

}