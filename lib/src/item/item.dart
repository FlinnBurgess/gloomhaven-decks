class Item {
  int _itemNumber;
  bool _equipped;
  bool _used;

  Item(this._itemNumber) {
    _equipped = false;
    _used = false;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          _itemNumber == other._itemNumber;

  @override
  int get hashCode => _itemNumber.hashCode;
}
