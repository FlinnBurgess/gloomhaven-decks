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

  Shop(this._unlockedItems, this._prosperity) {
    _includeHeadItems = true;
    _includeBodyItems = true;
    _includeTwoHandedItems = true;
    _includeOneHandedItems = true;
    _includeSmallItems = true;
    _includeFeetItems = true;
    _sortBy = ShopSortType.none;
  }

  Map itemsToDisplay() {
    var itemsAvailable = Map.from(items)
      ..removeWhere((key, value) =>
      (key > _prosperityItems[prosperity] &&
          !unlockedItems.contains(key)) ||
          value['stock'] < 1);

    filterItems(itemsAvailable);
    return sortItems(itemsAvailable);
  }

  void unlockItems(List<int> itemNumbers) {
    for (var i = 0; i < itemNumbers.length; i++) {
      var itemNumber = itemNumbers[i];

      if (unlockedItems.contains(itemNumber) ||
          itemNumber < 1 ||
          itemNumber > items.length) {
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
      return Shop(decodedShopInfo['unlockedItems'].cast<int>(),
          decodedShopInfo['prosperity']);
    } catch (error) {
      try {
        print('Error sent to sentry.io: $error');
      } catch (e) {
        print('Sending report to sentry.io failed: $e');
        print('Original error: $error');
      }
      return Shop([], 1);
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
        (itemDetails['type'] == ItemType.head && !_includeHeadItems) ||
        (itemDetails['type'] == ItemType.body && !_includeBodyItems) ||
        (itemDetails['type'] == ItemType.oneHanded &&
            !_includeOneHandedItems) ||
        (itemDetails['type'] == ItemType.twoHanded &&
            !_includeTwoHandedItems) ||
        (itemDetails['type'] == ItemType.smallItem && !_includeSmallItems) ||
        (itemDetails['type'] == ItemType.feet && !_includeFeetItems) ||
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
      return Map.fromEntries(items.entries.toList()..sort((e1, e2) => e1.value['cost'].compareTo(e2.value['cost'])));
    } else if (_sortBy == ShopSortType.itemType) {
      return Map.fromEntries(items.entries.toList()..sort((e1, e2) => e1.value['type'].toString().compareTo(e2.value['type'].toString())));
    }

    return items;
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
