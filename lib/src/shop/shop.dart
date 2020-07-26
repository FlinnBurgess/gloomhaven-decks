import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gloomhaven_decks/src/ui/items/items.dart';
import 'package:path_provider/path_provider.dart';

class Shop extends ChangeNotifier {
  List<int> _unlockedItems;
  int _prosperity;

  List<int> get unlockedItems => _unlockedItems;

  int get prosperity => _prosperity;

  Shop(this._unlockedItems, this._prosperity);

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

  void setProsperity(int prosperity) {
    _prosperity = prosperity;
    save();
    notifyListeners();
  }

  static Future<Shop> load() async {
    try {
      final file = await _localFile;
      String encodedShopInfo = await file.readAsString();
      Map<String, dynamic> decodedShopInfo = jsonDecode(encodedShopInfo);
      return Shop(decodedShopInfo['unlockedItems'].cast<int>(), decodedShopInfo['prosperity']);
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
}
