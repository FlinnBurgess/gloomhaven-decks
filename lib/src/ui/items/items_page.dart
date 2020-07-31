import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/item/item.dart';
import 'package:gloomhaven_decks/src/shop/shop.dart';
import 'package:gloomhaven_decks/src/ui/app_background.dart';
import 'package:gloomhaven_decks/src/ui/characters/character_list_page/character_list_page.dart';
import 'package:gloomhaven_decks/src/ui/navigation_drawer.dart';
import 'package:gloomhaven_decks/src/ui/outlined_text.dart';
import 'package:provider/provider.dart';

import 'items.dart';

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
    List<Item> availableItems = this
        .widget
        .character
        .items
        .where((item) => item.equipped && !item.used)
        .toList();

    List<Item> usedItems = this
        .widget
        .character
        .items
        .where((item) => item.equipped && item.used)
        .toList();

    List<Item> unequippedItems =
        this.widget.character.items.where((item) => !item.equipped).toList();

    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text("Refresh Spent Items"),
              onPressed: () => setState(() {
                usedItems.forEach((item) {
                  if (items[item.itemNumber]['usage'] == 'spend') {
                    item.used = false;
                  }
                });
              }),
            ),
            RaisedButton(
              child: Text("Unequip all items"),
              onPressed: () => setState(() {
                this.widget.character.items.forEach((item) {
                  item.equipped = false;
                });
              }),
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: OutlinedText.blackAndWhite('Available:')),
        SizedBox(
            height: availableItems.isNotEmpty ? 350 : 0,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: availableItems.length,
              itemBuilder: (BuildContext context, int index) {
                Item item = availableItems[index];
                String itemName = items[item.itemNumber]['name'];

                return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Stack(alignment: Alignment.center, children: [
                      Image.asset(
                        'images/items/${item.itemNumber}.png',
                        scale: 1.7,
                      ),
                      RaisedButton(
                        onPressed: () => setState(() => item.used = true),
                        child: Text(
                          "Use",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: 10,
                        child: IconButton(
                          icon: Icon(Icons.monetization_on),
                          onPressed: () =>
                              _confirmItemSale(item.itemNumber, context),
                          iconSize: 50,
                          color: Colors.green[700],
                        ),
                      ),
                      Positioned(
                        top: 70,
                        right: 10,
                        child: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            setState(() {
                              availableItems[index].equipped = false;
                              Fluttertoast.showToast(
                                  msg: itemName + ' unequipped.',
                                  backgroundColor: Colors.black);
                            });
                          },
                          iconSize: 50,
                          color: Colors.red[900],
                        ),
                      )
                    ]));
              },
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: OutlinedText.blackAndWhite('Used:')),
        SizedBox(
            height: usedItems.isNotEmpty ? 350 : 0,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: usedItems.length,
              itemBuilder: (BuildContext context, int index) {
                Item item = usedItems[index];
                String itemName = items[item.itemNumber]['name'];
                return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Stack(alignment: Alignment.center, children: [
                      Image.asset(
                        'images/items/${item.itemNumber}.png',
                        scale: 1.7,
                      ),
                      RaisedButton(
                        onPressed: () =>
                            setState(() => item.used = false),
                        child: Text(
                          "Refresh",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: 10,
                        child: IconButton(
                          icon: Icon(Icons.monetization_on),
                          onPressed: () => _confirmItemSale(
                              usedItems[index].itemNumber, context),
                          iconSize: 50,
                          color: Colors.green[700],
                        ),
                      ),
                      Positioned(
                        top: 70,
                        right: 10,
                        child: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            setState(() {
                              usedItems[index].equipped = false;
                              Fluttertoast.showToast(
                                  msg: itemName + ' unequipped.',
                                  backgroundColor: Colors.black);
                            });
                          },
                          iconSize: 50,
                          color: Colors.red[900],
                        ),
                      )
                    ]));
              },
            )),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: OutlinedText.blackAndWhite('Not Equipped:')),
        SizedBox(
            height: unequippedItems.isNotEmpty ? 350 : 0,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: unequippedItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Stack(alignment: Alignment.center, children: [
                      Image.asset(
                        'images/items/${unequippedItems[index].itemNumber}.png',
                        scale: 1.7,
                      ),
                      RaisedButton(
                        onPressed: () => setState(() {
                          unequippedItems[index].used = false;
                          unequippedItems[index].equipped = true;
                        }),
                        child: Text(
                          "Equip",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: 10,
                        child: IconButton(
                          icon: Icon(Icons.monetization_on),
                          onPressed: () => _confirmItemSale(
                              unequippedItems[index].itemNumber, context),
                          iconSize: 50,
                          color: Colors.green[700],
                        ),
                      ),
                    ]));
              },
            )),
      ],
    ));
  }

  void _confirmItemSale(itemNumber, context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String itemBeingSold = items[itemNumber]['name'];
          return AlertDialog(
            title: Text('Sell ' + itemBeingSold + '?'),
            content: Text('Are you sure you would like to sell this item?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              FlatButton(
                color: Colors.red[700],
                onPressed: () {
                  Provider.of<Shop>(context, listen: false)
                      .returnItem(itemNumber);
                  Provider.of<Characters>(context, listen: false).save();
                  setState(() {
                    this.widget.character.removeItem(Item(itemNumber));
                  });
                  Fluttertoast.showToast(
                      msg: itemBeingSold + ' sold.',
                      backgroundColor: Colors.black);
                  Navigator.of(context).pop();
                },
                child: Text('Delete'),
              )
            ],
          );
        });
  }
}
