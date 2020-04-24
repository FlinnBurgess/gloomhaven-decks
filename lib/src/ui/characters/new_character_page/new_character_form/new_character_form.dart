import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:provider/provider.dart';

//TODO display characters icons instead of (/as well as? could be a setting?) class names, to prevent spoilers
class NewCharacterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewCharacterFormState();
}

class NewCharacterFormState extends State<NewCharacterForm> {
  final _formKey = GlobalKey<FormState>();
  String _selectedClass = 'Brute';
  String _newCharacterName;

  final _classes = Character.CLASS_LIST;

  @override
  Widget build(BuildContext context) {
    return Consumer<Characters> (
      builder: (context, characters, child) {
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DropdownButtonFormField(
                value: _selectedClass,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                onChanged: (value) => this.setState(() => _selectedClass = value),
                items: _classes.map((String className) {
                  return DropdownMenuItem(
                    value: className,
                    child: Text(className),
                  );
                }).toList(),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Give your character a name';
                  }
                  return null;
                },
                onChanged: (value) =>
                    this.setState(() => _newCharacterName = value),
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Character newCharacter =
                    Character.createCharacter(
                        _selectedClass, _newCharacterName);

                    characters.addCharacter(newCharacter);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Character'),
              )
            ],
          ),
        );
      },
    );
  }
}
