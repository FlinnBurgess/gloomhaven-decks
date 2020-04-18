import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/characters/new_character_page/new_character_form/new_character_form.dart';

class NewCharacterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gloomhaven Deck Tracker'),
      ),
      body: NewCharacterForm(),
    );
  }
}