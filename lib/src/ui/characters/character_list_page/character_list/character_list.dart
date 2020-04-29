import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/ui/characters/character_perk_page/character_perk_page.dart';
import 'package:gloomhaven_decks/src/ui/characters/new_character_page/new_character_page.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:provider/provider.dart';

class CharacterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Characters>(
      builder: (context, characters, child) {
        List<Widget> options = List<Widget>();

        if (characters.characters.isEmpty) {
          options.add(Text(
              "You don't have any characters at the moment! Try adding a new one."));
        } else {
          options += _getCharacterList(characters, context);
        }

        options.add(RaisedButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewCharacterPage())),
          child: Text('Add New Character'),
        ));

        return SingleChildScrollView(
            child: Column(
          children: options,
        ));
      },
    );
  }

  List<Widget> _getCharacterList(Characters characters, BuildContext context) =>
      characters.characters
          .map<Widget>(
            (character) =>
            Card(
                color: Color.fromRGBO(125, 205, 225, 1),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(character.backgroundImagePath),
                            fit: BoxFit.cover)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(character.characterIcon, color: Colors.grey[350]),
                        Column(
                          children: <Widget>[
                            OutlinedText('Active', Colors.white, Colors.black),
                            Checkbox(
                                value: character.isActive,
                                onChanged: (value) {
                                  character.attackModifierDeck.cleanUp();
                                  character.attackModifierDeck.shuffle();
                                  characters.setCharacterActiveState(
                                      character, value);
                                })
                          ],
                        ),
                        Flexible(
                          child: OutlinedText(
                              character.name, Colors.white, Colors.black),
                        ),
                        RaisedButton(
                          onPressed: () =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CharacterPerkPage(
                                              character: character))),
                          child: Text('Perks'),
                        ),
                        IconButton(
                          onPressed: () =>
                              _confirmCharacterDeletion(
                                  characters, character, context),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey[350],
                          ),
                        ),
                      ],
                    ))),
      )
          .toList();

  void _confirmCharacterDeletion(characters, character, context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete ' + character.name + '?'),
            content:
            Text('Are you sure you would like to delete this character?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              FlatButton(
                color: Colors.red[700],
                onPressed: () {
                  characters.deleteCharacter(character);
                  Navigator.of(context).pop();
                },
                child: Text('Delete'),
              )
            ],
          );
        });
  }
}
