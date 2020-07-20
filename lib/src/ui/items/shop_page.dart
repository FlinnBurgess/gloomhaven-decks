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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            'images/items/${index + 1}.png',
            scale: 1.2,
          );
        });
  }
}
