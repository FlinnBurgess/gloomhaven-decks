import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/navigation_drawer.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';

import 'character_list/character_list.dart';

class CharacterListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: OutlinedText.blackAndWhite('Characters'),
        ),
        drawer: NavigationDrawer(),
        body: AppBackground(
          child: SafeArea(child: CharacterList()),
        ));
  }
}
