import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/settings/settings.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:provider/provider.dart';

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
    return Consumer2<Characters, Settings>(
      builder: (context, characters, settings, _) {
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Theme(
                      data: ThemeData(canvasColor: Colors.black54),
                      child: DropdownButtonFormField(
                        value: _selectedClass,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (value) =>
                            this.setState(() => _selectedClass = value),
                        items: _classes.map((String className) {
                          return DropdownMenuItem(
                              value: className,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                      Character.createCharacter(className, '')
                                          .characterIcon,
                                      color: Colors.white),
                                  Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: OutlinedText.blackAndWhite(
                                          settings.hideUnlockableClassNamesSetting &&
                                                  !STARTING_CLASSES
                                                      .contains(className)
                                              ? '???'
                                              : className))
                                ],
                              ));
                        }).toList(),
                      ))),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "New Character Name",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Give your character a name';
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        this.setState(() => _newCharacterName = value),
                  )),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Character newCharacter = Character.createCharacter(
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
