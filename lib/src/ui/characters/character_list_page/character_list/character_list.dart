import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/ui/characters/character_perk_page/character_perk_page.dart';
import 'package:gloomhaven_decks/src/ui/characters/new_character_page/new_character_page.dart';
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

        return Column(
          children: options,
        );
      },
    );
  }

  List<Widget> _getCharacterList(Characters characters, BuildContext context) =>
      characters.characters
          .map<Widget>((character) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Active'),
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
              character.characterIcon,
              Text(character.name),
              RaisedButton(
                onPressed: () =>
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CharacterPerkPage(character: character))),
                child: Text('Perks'),
              ),
              IconButton(
                onPressed: () => characters.deleteCharacter(character),
                icon: Icon(Icons.delete),
              ),
            ],
          ))
          .toList();
}
