import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/ui/decks/decks_page/attack_modifier_deck_tab/attack_modifier_deck_tab.dart';
import 'package:provider/provider.dart';

class DecksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Characters>(
      builder: (context, characters, child) {
        List<Character> activeCharacters = characters.characters
            .where((character) => character.isActive)
            .toList();

        List<Tab> characterTabs = activeCharacters
            .map<Tab>((character) => Tab(
                  text: character.name,
                ))
            .toList();

        List<AttackModifierDeckTab> characterDeckPages =
        activeCharacters.map((character) =>
            AttackModifierDeckTab(character: character)).toList();

        return DefaultTabController(
          length: activeCharacters.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Decks'),
              bottom: TabBar(
                tabs: characterTabs,
              ),
            ),
            body: TabBarView(
              children: characterDeckPages,
            ),
          ),
        );
      },
    );
  }
}
