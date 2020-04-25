import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/characters/character_list_page/character_list_page.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/decks_page.dart';
import 'package:wakelock/wakelock.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Wakelock.disable();
    return Scaffold(
      appBar: AppBar(
        title: Text('Gloomhaven Deck Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CharacterListPage()));
                },
                child: Text('Characters')),
            RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DecksPage()));
                },
                child: Text('Decks')),
            RaisedButton(onPressed: null, child: Text('Settings')),
          ],
        ),
      ),
    );
  }
}
