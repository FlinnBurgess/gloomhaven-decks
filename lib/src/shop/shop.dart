import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/items/items.dart';
import 'package:path_provider/path_provider.dart';

enum ShopSortType { none, itemType, cost }

class Shop extends ChangeNotifier {
  List<int> _unlockedItems;
  int _prosperity;
  bool _includeHeadItems;
  bool _includeBodyItems;
  bool _includeTwoHandedItems;
  bool _includeOneHandedItems;
  bool _includeSmallItems;
  bool _includeFeetItems;
  int _filterByLessThan;
  int _itemNumberSearchTerm;
  String _itemNameSearchTerm;
  ShopSortType _sortBy;
  Map _items = {};

  Map _prosperityItems = {
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

  Shop(this._unlockedItems, this._prosperity, this._items) {
    _includeHeadItems = true;
    _includeBodyItems = true;
    _includeTwoHandedItems = true;
    _includeOneHandedItems = true;
    _includeSmallItems = true;
    _includeFeetItems = true;
    _sortBy = ShopSortType.none;
  }

  Map itemsToDisplay() {
    var itemsAvailable = Map.from(_items)
      ..removeWhere((itemNumber, _) =>
          (itemNumber > _prosperityItems[prosperity] &&
              !unlockedItems.contains(itemNumber)));

    filterItems(itemsAvailable);
    return sortItems(itemsAvailable);
  }

  void unlockItems(List<int> itemNumbers) {
    for (var i = 0; i < itemNumbers.length; i++) {
      var itemNumber = itemNumbers[i];

      if (unlockedItems.contains(itemNumber) ||
          itemNumber < 1 ||
          itemNumber > _items.length) {
        continue;
      }

      unlockedItems.add(itemNumber);
    }
    save();
    notifyListeners();
  }

  static Future<Shop> load() async {
    try {
      final file = await _localFile;
      String encodedShopInfo = await file.readAsString();
      Map<String, dynamic> decodedShopInfo = jsonDecode(encodedShopInfo);
      Map decodedItems;

      if (decodedShopInfo['items'] == null) {
        decodedItems = Map.from(items);
      } else {
        decodedItems = decodedShopInfo['items'];
        decodedItems = decodedItems.map((itemNumber, itemDetails) =>
            MapEntry(int.parse(itemNumber), itemDetails));
      }

      return Shop(
          decodedShopInfo['unlockedItems'].cast<int>(),
          decodedShopInfo['prosperity'],
          decodedItems);
    } catch (error) {
      try {
        print('Error sent to sentry.io: $error');
      } catch (e) {
        print('Sending report to sentry.io failed: $e');
        print('Original error: $error');
      }
      return Shop([], 1, Map.from(items));
    }
  }

  Future<void> save() async {
    try {
      final file = await _localFile;
      return file.writeAsString(jsonEncode(this.toJson()));
    } catch (e) {
      print('Error saving characters: $e');
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> asJson = {};
    asJson['prosperity'] = _prosperity;
    asJson['unlockedItems'] = _unlockedItems;
    asJson['items'] = _items.map((itemNumber, itemDetails) =>
        MapEntry(itemNumber.toString(), itemDetails));
    return asJson;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/shop.json');
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  void filterItems(Map<dynamic, dynamic> itemsAvailable) {
    itemsAvailable.removeWhere((itemNumber, itemDetails) =>
        (itemDetails['type'] == 'head' && !_includeHeadItems) ||
        (itemDetails['type'] == 'body' && !_includeBodyItems) ||
        (itemDetails['type'] == 'one handed' && !_includeOneHandedItems) ||
        (itemDetails['type'] == 'two handed' && !_includeTwoHandedItems) ||
        (itemDetails['type'] == 'small item' && !_includeSmallItems) ||
        (itemDetails['type'] == 'feet' && !_includeFeetItems) ||
        (_filterByLessThan != null &&
            itemDetails['cost'] > _filterByLessThan) ||
        (_itemNameSearchTerm != null &&
            !itemDetails['name']
                .toString()
                .toLowerCase()
                .contains(_itemNameSearchTerm.toLowerCase())) ||
        _itemNumberSearchTerm != null && itemNumber != _itemNumberSearchTerm);
  }

  Map sortItems(Map items) {
    if (_sortBy == ShopSortType.cost) {
      return Map.fromEntries(items.entries.toList()
        ..sort((e1, e2) => e1.value['cost'].compareTo(e2.value['cost'])));
    } else if (_sortBy == ShopSortType.itemType) {
      return Map.fromEntries(items.entries.toList()
        ..sort((e1, e2) => e1.value['type']
            .toString()
            .compareTo(e2.value['type'].toString())));
    }

    return items;
  }

  void removeItem(int itemNumber) {
    _items[itemNumber]['stock'] = _items[itemNumber]['stock'] - 1;
    save();
    notifyListeners();
  }

  void returnItem(int itemNumber) {
    _items[itemNumber]['stock'] = _items[itemNumber]['stock'] + 1;
    save();
    notifyListeners();
  }

  void returnItems(List<int> itemNumbers) {
    itemNumbers.forEach((itemNumber) {
      returnItem(itemNumber);
    });
  }

  void resetFilters() {
    _itemNameSearchTerm = null;
    _itemNumberSearchTerm = null;
    _includeHeadItems = true;
    _includeBodyItems = true;
    _includeTwoHandedItems = true;
    _includeOneHandedItems = true;
    _includeSmallItems = true;
    _includeFeetItems = true;
    _filterByLessThan = null;
    notifyListeners();
  }

  bool get includeTwoHandedItems => _includeTwoHandedItems;

  bool get includeOneHandedItems => _includeOneHandedItems;

  bool get includeSmallItems => _includeSmallItems;

  bool get includeFeetItems => _includeFeetItems;

  bool get includeHeadItems => _includeHeadItems;

  bool get includeBodyItems => _includeBodyItems;

  List<int> get unlockedItems => _unlockedItems;

  set includeFeetItems(bool value) {
    _includeFeetItems = value;
    notifyListeners();
  }

  set includeSmallItems(bool value) {
    _includeSmallItems = value;
    notifyListeners();
  }

  set includeOneHandedItems(bool value) {
    _includeOneHandedItems = value;
    notifyListeners();
  }

  set includeTwoHandedItems(bool value) {
    _includeTwoHandedItems = value;
    notifyListeners();
  }

  set includeBodyItems(bool value) {
    _includeBodyItems = value;
    notifyListeners();
  }

  set includeHeadItems(bool value) {
    _includeHeadItems = value;
    notifyListeners();
  }

  int get filterByLessThan => _filterByLessThan;

  set filterByLessThan(int value) {
    _filterByLessThan = value;
    notifyListeners();
  }

  String get itemNameSearchTerm => _itemNameSearchTerm;

  set itemNameSearchTerm(String value) {
    _itemNumberSearchTerm = null;
    _itemNameSearchTerm = value;
    notifyListeners();
  }

  int get itemNumberSearchTerm => _itemNumberSearchTerm;

  set itemNumberSearchTerm(int value) {
    _itemNameSearchTerm = null;
    _itemNumberSearchTerm = value;
    notifyListeners();
  }

  ShopSortType get sortBy => _sortBy;

  set sortBy(ShopSortType value) {
    _sortBy = value;
    notifyListeners();
  }

  int get prosperity => _prosperity;

  void setProsperity(int prosperity) {
    _prosperity = prosperity;
    save();
    notifyListeners();
  }
}
