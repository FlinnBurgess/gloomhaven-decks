import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:gloomhaven_decks/src/ui/settings/settings_page/settings_page.dart';

import 'characters/character_list_page/character_list_page.dart';
import 'decks/decks_page/decks_page.dart';
import 'items/shop_page.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 40),
          color: Colors.grey[800],
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(children: <Widget>[
              FlatButton(
                child: OutlinedText.blackAndWhite('Decks'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DecksPage(true)));
                },
              ),
              FlatButton(
                child: OutlinedText.blackAndWhite('Characters'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CharacterListPage()));
                },
              ),
              FlatButton(
                child: OutlinedText.blackAndWhite('Shop'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopPage()));
                },
              ),
              FlatButton(
                child: OutlinedText.blackAndWhite('Settings'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsPage()));
                },
              ),
            ]),
          )),
    ));
  }
}
