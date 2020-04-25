import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/characters/character_list_page/character_list_page.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/decks_page.dart';
import 'package:wakelock/wakelock.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Wakelock.disable();
    return Scaffold(
      appBar: null,
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/backgrounds/dark-wood.jpg'),
                  fit: BoxFit.cover),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromRGBO(255, 25, 10, 1),
                    Color.fromRGBO(173, 96, 42, 1)
                  ])),
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
      ),
    );
  }
}
