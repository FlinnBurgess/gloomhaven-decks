import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/player_characters.dart';
import 'package:gloomhaven_decks/src/shop/shop.dart';
import 'package:gloomhaven_decks/src/ui/characters/character_perk_page/character_perk_page.dart';
import 'package:gloomhaven_decks/src/ui/characters/new_character_page/new_character_page.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:provider/provider.dart';

class CharacterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerCharacters>(
      builder: (context, characters, child) {
        List<Widget> options = List<Widget>();

        if (characters.characters.isEmpty) {
          options.add(Padding(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              child: OutlinedText.blackAndWhite(
                  "You don't have any characters at the moment!",
                  TextAlign.center)));
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

  List<Widget> _getCharacterList(PlayerCharacters characters, BuildContext context) =>
      characters.characters
          .map<Widget>(
            (character) => Card(
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
                            OutlinedText.blackAndWhite('Active'),
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
                          child: OutlinedText.blackAndWhite(character.name),
                        ),
                        RaisedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CharacterPerkPage(character: character))),
                          child: Text('Perks'),
                        ),
                        IconButton(
                          onPressed: () => _confirmCharacterDeletion(
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

  void _confirmCharacterDeletion(characters, Character character, context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete ' + character.name + '?'),
            content: Text(
                'Are you sure you would like to delete this character? Owned items will be returned to the shop.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              FlatButton(
                color: Colors.red[700],
                onPressed: () {
                  Provider.of<Shop>(context, listen: false).returnItems(
                      character.items.map((item) => item.itemNumber).toList());
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
