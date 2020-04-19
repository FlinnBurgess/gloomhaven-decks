import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
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
          options += _getCharacterList(characters);
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

  List<Widget> _getCharacterList(Characters characters) => characters.characters
      .map<Widget>((character) => Row(
            children: <Widget>[
              IconButton(
                onPressed: () => characters.deleteCharacter(character),
                icon: Icon(Icons.remove),
              ),
              RaisedButton(
                onPressed: () => null,
                child: Text(character.name +
                    " the " +
                    character.runtimeType.toString()),
              )
            ],
          ))
      .toList();
}
