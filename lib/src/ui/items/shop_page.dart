import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/items/items.dart';

import '../app_background.dart';
import '../navigation_drawer.dart';
import '../outlined_text.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: OutlinedText.blackAndWhite('Shop'),
        ),
        drawer: NavigationDrawer(),
        body: AppBackground(
          child: SafeArea(child: ShopItems()),
        ));
  }
}

class ShopItems extends StatefulWidget {
  @override
  _ShopItemsState createState() => _ShopItemsState();
}

class _ShopItemsState extends State<ShopItems> {

  Map itemsAvailable;
  int prosperity = 1;
  Map prosperityItems = {
    1: 14,
    2: 21,
    3: 28,
    4: 35,
    5: 42,
    6: 49,
    7: 56,
    8: 63,
    9: 70,
  };

  List unlockedItems = [];

  @override
  Widget build(BuildContext context) {
    itemsAvailable = Map.from(items)..removeWhere((key, value) => (key > prosperityItems[prosperity] && !unlockedItems.contains(key)) || value['stock'] < 1);
    return ListView.builder(
        itemCount: itemsAvailable.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(bottom: 35),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/items/${itemsAvailable.keys.toList()[index]}.png',
                    scale: 1.2,
                  ),
                  RaisedButton(
                    onPressed: () => null,
                    child: Text(
                      "Buy",
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ));
        });
  }
}
