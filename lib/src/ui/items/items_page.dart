import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/characters/character_list_page/character_list_page.dart';
import 'package:gloomhaven_decks/src/ui/navigation_drawer.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Characters>(
      builder: (context, characters, _) {
        List<Character> activeCharacters = characters.characters
            .where((character) => character.isActive)
            .toList();

        List<Tab> characterTabs = activeCharacters
            .map<Tab>((character) => Tab(
                  icon: Icon(character.characterIcon),
                  text: character.name,
                ))
            .toList();

        List<CharacterItemsTab> characterItemsPages = activeCharacters
            .map((character) => CharacterItemsTab(
                  character: character,
                  saveCharacters: () => characters.save(),
                ))
            .toList();

        return DefaultTabController(
          length: activeCharacters.length,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: OutlinedText.blackAndWhite('Items'),
              bottom: TabBar(
                tabs: characterTabs,
                indicatorWeight: 3,
                indicatorColor: Colors.white,
              ),
            ),
            drawer: NavigationDrawer(),
            body: AppBackground(
              child: SafeArea(
                child: activeCharacters.isEmpty
                    ? Column(
                        children: <Widget>[
                          OutlinedText.blackAndWhite(
                              "You don't have any active characters!"),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: RaisedButton(
                              child: Text("Add some now"),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CharacterListPage()));
                              },
                            ),
                          )
                        ],
                      )
                    : TabBarView(
                        children: characterItemsPages,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CharacterItemsTab extends StatefulWidget {
  final Function saveCharacters;
  final Character character;

  CharacterItemsTab(
      {Key key, @required this.character, @required this.saveCharacters});

  @override
  _CharacterItemsTabState createState() => _CharacterItemsTabState();
}

class _CharacterItemsTabState extends State<CharacterItemsTab> {
  @override
  Widget build(BuildContext context) {
    List charactersItems = Map.from(this.widget.character.items).keys.toList();
    List availableItems = charactersItems
        .where((itemNumber) => this.widget.character.items[itemNumber] == false)
        .toList();
    List usedItems = charactersItems
        .where((itemNumber) => this.widget.character.items[itemNumber] == true)
        .toList();

    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(vertical: 15), child: OutlinedText.blackAndWhite('Available:')),
        Wrap(
          children: availableItems.map((itemNumber) {
            return Stack(alignment: Alignment.center, children: [
              Image.asset(
                'images/items/${itemNumber}.png',
                scale: 2,
              ),
              RaisedButton(
                onPressed: () => setState(
                    () => this.widget.character.items[itemNumber] = true),
                child: Text(
                  "Use",
                  style: TextStyle(fontSize: 30),
                ),
              )
            ]);
          }).toList(),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 15), child: OutlinedText.blackAndWhite('Used:')),
        Wrap(
          children: usedItems.map((itemNumber) {
            return Stack(alignment: Alignment.center, children: [
              Image.asset(
                'images/items/${itemNumber}.png',
                scale: 2,
              ),
              RaisedButton(
                onPressed: () => setState(
                    () => this.widget.character.items[itemNumber] = true),
                child: Text(
                  "Use",
                  style: TextStyle(fontSize: 30),
                ),
              )
            ]);
          }).toList(),
        ),
      ],
    ));
  }
}
