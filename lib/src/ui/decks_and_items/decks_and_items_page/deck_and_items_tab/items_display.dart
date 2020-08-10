import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gloomhaven_decks/src/characters/character.dart';
import 'package:gloomhaven_decks/src/characters/characters.dart';
import 'package:gloomhaven_decks/src/item/item.dart';
import 'package:gloomhaven_decks/src/shop/shop.dart';
import 'package:gloomhaven_decks/src/ui/items/items.dart';
import 'package:provider/provider.dart';

import '../../../outlined_text.dart';

class ItemsDisplay extends StatefulWidget {
  final Character character;
  final ScrollController scrollController;

  @override
  _ItemsDisplayState createState() => _ItemsDisplayState();

  ItemsDisplay(
      {Key key, @required this.character, @required this.scrollController});
}

class _ItemsDisplayState extends State<ItemsDisplay> {
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
    List<int> wishList = this.widget.character.itemWishList;
    var itemPlaceholderImage =
        Opacity(opacity: 0.6, child: Image.asset('images/items/no-item.png'));

    return SingleChildScrollView(
        controller: this.widget.scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Refresh spent items"),
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
                          if (itemEquipEffects.containsKey(item.itemNumber)) {
                            itemEquipEffects[item.itemNumber]['unequip'](
                                this.widget.character.attackModifierDeck);
                            Fluttertoast.showToast(
                                msg:
                                    'Item effects removed from attack modified deck.',
                                backgroundColor: Colors.black);
                          }
                          item.equipped = false;
                        });
                      }),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: OutlinedText.blackAndWhite('Available:')),
            SizedBox(
                height: 350,
                child: availableItems.isNotEmpty
                    ? ListView.builder(
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
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Image.asset(
                                  'images/items/${item.itemNumber}.png',
                                  scale: 1.7,
                                ),
                                items[item.itemNumber]['usage'] == 'passive'
                                    ? Container()
                                    : RaisedButton(
                                        onPressed: () => setState(() {
                                          if (item.isMultiUse) {
                                            if (item.timesUsed < item.maxUses) {
                                              item.timesUsed++;
                                            } else {
                                              item.timesUsed = 0;
                                              item.used = true;
                                            }
                                          } else {
                                            item.used = true;
                                          }
                                        }),
                                        child: Text(
                                          "Use",
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                Positioned(
                                  top: 110,
                                  left: 0,
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.monetization_on),
                                          onPressed: () => _confirmItemSale(
                                              item.itemNumber, context),
                                          iconSize: 50,
                                          color: Colors.green[700],
                                        )
                                      ]),
                                ),
                                Positioned(
                                  top: 30,
                                  left: 0,
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.remove_circle),
                                          onPressed: () {
                                            bool itemEffectNeedsRemoving =
                                                itemEquipEffects.containsKey(
                                                    item.itemNumber);
                                            if (itemEffectNeedsRemoving) {
                                              itemEquipEffects[item.itemNumber]
                                                      ['unequip'](
                                                  this
                                                      .widget
                                                      .character
                                                      .attackModifierDeck);
                                            }

                                            setState(() {
                                              availableItems[index].equipped =
                                                  false;
                                              Fluttertoast.showToast(
                                                  msg: itemName +
                                                      ' unequipped' +
                                                      (itemEffectNeedsRemoving
                                                          ? ' and effect removed from attack modifier deck.'
                                                          : '.'),
                                                  backgroundColor:
                                                      Colors.black);
                                            });
                                          },
                                          iconSize: 50,
                                          color: Colors.red[900],
                                        )
                                      ]),
                                ),
                                item.isMultiUse && item.timesUsed > 0
                                    ? Positioned(
                                        bottom: multiUseItems[item.itemNumber]
                                                ['locations']
                                            [item.timesUsed - 1]['bottom'],
                                        left: multiUseItems[item.itemNumber]
                                                ['locations']
                                            [item.timesUsed - 1]['left'],
                                        child: Icon(
                                          this.widget.character.characterIcon,
                                          size: 31,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container()
                              ]));
                        },
                      )
                    : itemPlaceholderImage),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: OutlinedText.blackAndWhite('Used:')),
            SizedBox(
                height: 350,
                child: usedItems.isNotEmpty
                    ? ListView.builder(
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
                              child:
                                  Stack(alignment: Alignment.center, children: [
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
                                  top: 110,
                                  left: 0,
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.monetization_on),
                                          onPressed: () => _confirmItemSale(
                                              item.itemNumber, context),
                                          iconSize: 50,
                                          color: Colors.green[700],
                                        )
                                      ]),
                                ),
                                Positioned(
                                  top: 30,
                                  left: 0,
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.remove_circle),
                                          onPressed: () {
                                            bool itemEffectNeedsRemoving =
                                                itemEquipEffects.containsKey(
                                                    item.itemNumber);
                                            if (itemEffectNeedsRemoving) {
                                              itemEquipEffects[item.itemNumber]
                                                      ['unequip'](
                                                  this
                                                      .widget
                                                      .character
                                                      .attackModifierDeck);
                                            }
                                            setState(() {
                                              usedItems[index].equipped = false;
                                              Fluttertoast.showToast(
                                                  msg: itemName +
                                                      ' unequipped' +
                                                      (itemEffectNeedsRemoving
                                                          ? ' and effect removed from attack modifier deck.'
                                                          : '.'),
                                                  backgroundColor:
                                                      Colors.black);
                                            });
                                          },
                                          iconSize: 50,
                                          color: Colors.red[900],
                                        )
                                      ]),
                                )
                              ]));
                        },
                      )
                    : itemPlaceholderImage),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: OutlinedText.blackAndWhite('Not Equipped:')),
            SizedBox(
                height: 350,
                child: usedItems.isNotEmpty
                    ? ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: unequippedItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          int itemNumber = unequippedItems[index].itemNumber;
                          return Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Image.asset(
                                  'images/items/${itemNumber}.png',
                                  scale: 1.7,
                                ),
                                RaisedButton(
                                  onPressed: () => setState(() {
                                    if (itemEquipEffects
                                        .containsKey(itemNumber)) {
                                      if (this
                                              .widget
                                              .character
                                              .ignoreNegativeItemEffects &&
                                          itemNumber != 101) {
                                        Fluttertoast.showToast(
                                            msg: this.widget.character.name +
                                                ' ignores negative item effects.',
                                            backgroundColor: Colors.black);
                                      } else {
                                        itemEquipEffects[itemNumber]['equip'](
                                            this
                                                .widget
                                                .character
                                                .attackModifierDeck);
                                        Fluttertoast.showToast(
                                            msg:
                                                'Item effect applied to attack modifier deck.',
                                            backgroundColor: Colors.black);
                                      }
                                    }
                                    if (unequippedItems[index].isMultiUse) {
                                      unequippedItems[index].timesUsed = 0;
                                    }
                                    unequippedItems[index].used = false;
                                    unequippedItems[index].equipped = true;
                                  }),
                                  child: Text(
                                    "Equip",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                                Positioned(
                                  top: 110,
                                  left: 0,
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.monetization_on),
                                          onPressed: () => _confirmItemSale(
                                              itemNumber, context),
                                          iconSize: 50,
                                          color: Colors.green[700],
                                        )
                                      ]),
                                ),
                              ]));
                        },
                      )
                    : itemPlaceholderImage),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: OutlinedText.blackAndWhite('Wish List:')),
            SizedBox(
                height: wishList.isEmpty ? 100 : 350,
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: wishList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    var itemNumber = index == 0 ? null : wishList[index - 1];

                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: index == 0
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    SizedBox(
                                        height: 80,
                                        width: 100,
                                        child: IconButton(
                                          onPressed: () =>
                                              _addItemToWishlist(context),
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.black,
                                            size: 80,
                                          ),
                                        ))
                                  ])
                            : Stack(alignment: Alignment.center, children: [
                                Image.asset(
                                  'images/items/${itemNumber}.png',
                                  scale: 1.7,
                                ),
                                RaisedButton(
                                  onPressed: () => setState(() {
                                    Shop shop = Provider.of<Shop>(context);
                                    if (shop
                                            .itemsToDisplay()
                                            .containsKey(itemNumber) &&
                                        shop.itemsToDisplay()[itemNumber]
                                                ['stock'] <
                                            1) {
                                      Fluttertoast.showToast(
                                          msg: items[itemNumber]['name']
                                                  .toString() +
                                              ' out of stock.',
                                          backgroundColor: Colors.red[900]);
                                    } else {
                                      shop.removeItem(itemNumber);
                                      this
                                          .widget
                                          .character
                                          .addItem(Item(itemNumber));
                                      this
                                          .widget
                                          .character
                                          .removeWishListItem(itemNumber);
                                      Provider.of<Characters>(context).save();
                                    }
                                  }),
                                  child: Text(
                                    "Buy",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    top: 110,
                                    child: IconButton(
                                      onPressed: () => setState(() => this
                                          .widget
                                          .character
                                          .removeWishListItem(itemNumber)),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red[900],
                                        size: 50,
                                      ),
                                    ))
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
                child: Text('Sell'),
              )
            ],
          );
        });
  }

  void _addItemToWishlist(context) {
    Map itemsAvailable =
        Provider.of<Shop>(context, listen: false).itemsToDisplay();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black12,
            title: OutlinedText.blackAndWhite('Add an item to your wish list'),
            content: Container(
                height: 350,
                width: double.maxFinite,
                child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: itemsAvailable.length,
                    itemBuilder: (BuildContext context, int index) {
                      int itemNumber = itemsAvailable.keys.toList()[index];
                      return itemsAvailable[itemNumber]['stock'] > 0
                          ? Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'images/items/${itemNumber}.png',
                                    scale: 1,
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      if (this
                                          .widget
                                          .character
                                          .ownsItem(Item(itemNumber))) {
                                        Fluttertoast.showToast(
                                            msg: this.widget.character.name +
                                                ' already owns ' +
                                                items[itemNumber]['name'],
                                            backgroundColor: Colors.red[900]);
                                      } else {
                                        setState(() {
                                          this
                                              .widget
                                              .character
                                              .addWishListItem(itemNumber);
                                        });
                                        Provider.of<Characters>(context).save();
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      "Add",
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  )
                                ],
                              ))
                          : ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Colors.grey, BlendMode.saturation),
                              child: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'images/items/${itemNumber}.png',
                                        scale: 1.3,
                                      ),
                                      RaisedButton(
                                        onPressed: () => null,
                                        child: Text(
                                          "OUT OF STOCK",
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      )
                                    ],
                                  )));
                    })),
            actions: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }
}
