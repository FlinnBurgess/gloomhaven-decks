import 'package:gloomhaven_decks/src/ui/items/items.dart';

class Item {
  int _itemNumber;
  bool _equipped;
  bool _used;
  bool _isMultiUse = false;
  int _maxUses;
  int _timesUsed;

  Item(this._itemNumber) {
    _equipped = false;
    _used = false;
    if (multiUseItems.containsKey(itemNumber)) {
      _isMultiUse = true;
      _maxUses = multiUseItems[itemNumber]['uses'];
      _timesUsed = 0;
    }
  }

  bool get used => _used;

  set used(bool value) {
    _used = value;
  }

  bool get equipped => _equipped;

  set equipped(bool value) {
    _equipped = value;
  }

  int get itemNumber => _itemNumber;


  int get maxUses => _maxUses;

  set maxUses(int value) {
    _maxUses = value;
  }

  int get timesUsed => _timesUsed;

  set timesUsed(int value) {
    _timesUsed = value;
  }

  bool get isMultiUse => _isMultiUse;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          _itemNumber == other._itemNumber;

  @override
  int get hashCode => _itemNumber.hashCode;
}
