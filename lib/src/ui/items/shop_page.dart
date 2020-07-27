import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gloomhaven_decks/src/shop/shop.dart';
import 'package:gloomhaven_decks/src/ui/incrementer.dart';
import 'package:gloomhaven_decks/src/ui/items/items.dart';
import 'package:provider/provider.dart';

import '../app_background.dart';
import '../navigation_drawer.dart';
import '../outlined_text.dart';
import 'item_type_icons.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
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

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, shop, child) {
        itemsAvailable = Map.from(items)
          ..removeWhere((key, value) =>
              (key > prosperityItems[shop.prosperity] &&
                  !shop.unlockedItems.contains(key)) ||
              value['stock'] < 1);

        shop.filterItems(itemsAvailable);

        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Incrementer(
                label: 'Prosperity',
                incrementBehaviour: () =>
                    setState(() => shop.setProsperity(shop.prosperity + 1)),
                incrementEnabledCondition: () => shop.prosperity < 9,
                decrementBehaviour: () =>
                    setState(() => shop.setProsperity(shop.prosperity - 1)),
                decrementEnabledCondition: () => shop.prosperity > 1,
                valueCalculation: () => shop.prosperity,
              ),
              RaisedButton(
                child: Text('Add Items'),
                onPressed: (() => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Add items to shop'),
                        content: Column(
                          children: <Widget>[
                            Text(
                                'Insert a comma-separated list of item numbers to add to the shop. e.g. 1 or 1, 2, 3'),
                            AddItemsForm(
                                (itemNumbers) => shop.unlockItems(itemNumbers)),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                              color: Colors.red[700],
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel')),
                        ],
                      );
                    })),
              ),
              RaisedButton(
                child: Text('Filter'),
                onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(18.0))),
                    context: context,
                    builder: (_) => ShopFilterOptions()),
              )
            ],
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: itemsAvailable.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
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
                  }))
        ]);
      },
    );
  }
}

class AddItemsForm extends StatefulWidget {
  final Function unlockItems;

  AddItemsForm(this.unlockItems);

  @override
  State<StatefulWidget> createState() => AddItemsFormState();
}

class AddItemsFormState extends State<AddItemsForm> {
  final _formKey = GlobalKey<FormState>();
  String _input;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Item Numbers",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                validator: (value) {
                  if (_inputIsInvalid(value)) {
                    return 'Enter a comma-separated list of item numbers. e.g. 1 or 1, 2, 3';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => _input = value),
              )),
          RaisedButton(
            color: Colors.green[700],
            textColor: Colors.white,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                this.widget.unlockItems(_convertInput(_input));
                Fluttertoast.showToast(
                    msg: 'Added items: ' + _input,
                    backgroundColor: Colors.black);
                Navigator.pop(context);
              }
            },
            child: Text('Add Items'),
          )
        ],
      ),
    );
  }

  bool _inputIsInvalid(String input) {
    try {
      _convertInput(input);
    } on Exception {
      return true;
    }
    return input.isEmpty;
  }

  List<int> _convertInput(String input) {
    var itemNumbers = input.split(",");

    return itemNumbers.map((itemNumberString) {
      return int.parse(itemNumberString);
    }).toList();
  }
}

class ShopFilterOptions extends StatefulWidget {
  @override
  _ShopFilterOptionsState createState() => _ShopFilterOptionsState();
}

class _ShopFilterOptionsState extends State<ShopFilterOptions> {
  var _itemSearchInputController = TextEditingController();
  var _itemPriceFilterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(),
        child: Consumer<Shop>(builder: (context, shop, child) {
          String currentItemSearchTerm;
          if (shop.itemNameSearchTerm != null) {
            currentItemSearchTerm = shop.itemNameSearchTerm;
          } else if (shop.itemNumberSearchTerm != null) {
            currentItemSearchTerm = shop.itemNumberSearchTerm.toString();
          }
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(ItemTypeIcons.head),
                        Checkbox(
                          value: shop.includeHeadItems,
                          onChanged: (value) => shop.includeHeadItems = value,
                        ),
                        Icon(ItemTypeIcons.body),
                        Checkbox(
                          value: shop.includeBodyItems,
                          onChanged: (value) => shop.includeBodyItems = value,
                        ),
                        Icon(ItemTypeIcons.two_handed),
                        Checkbox(
                          value: shop.includeTwoHandedItems,
                          onChanged: (value) =>
                              shop.includeTwoHandedItems = value,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(ItemTypeIcons.one_handed),
                        Checkbox(
                          value: shop.includeOneHandedItems,
                          onChanged: (value) =>
                              shop.includeOneHandedItems = value,
                        ),
                        Icon(ItemTypeIcons.small_item),
                        Checkbox(
                          value: shop.includeSmallItems,
                          onChanged: (value) => shop.includeSmallItems = value,
                        ),
                        Icon(ItemTypeIcons.feet),
                        Checkbox(
                          value: shop.includeFeetItems,
                          onChanged: (value) => shop.includeFeetItems = value,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Costing less than: '),
                        Expanded(
                            child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _itemPriceFilterController
                            ..text = shop.filterByLessThan == null
                                ? null
                                : shop.filterByLessThan.toString(),
                          onFieldSubmitted: (value) => {
                            if (int.tryParse(value) != null)
                              {shop.filterByLessThan = int.parse(value)}
                            else
                              {shop.filterByLessThan = null}
                          },
                        ))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Item name or number: '),
                        Expanded(
                            child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: _itemSearchInputController..text = currentItemSearchTerm,
                          onFieldSubmitted: (value) => {
                            if (int.tryParse(value) != null)
                              {shop.itemNumberSearchTerm = int.parse(value)}
                            else
                              {shop.itemNameSearchTerm = value}
                          },
                        ))
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 20,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              child: Text('Reset Filters'),
                              onPressed: () {
                                shop.resetFilters();
                                _itemPriceFilterController.clear();
                                _itemSearchInputController.clear();
                              },
                            )
                          ],
                        )),
                  ]));
        }));
  }
}
