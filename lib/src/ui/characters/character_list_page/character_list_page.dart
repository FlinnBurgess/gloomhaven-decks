import 'package:flutter/material.dart';

import 'character_list/character_list.dart';

class CharacterListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gloomhaven Deck Tracker'),
      ),
      body: CharacterList(),
    );
  }
}