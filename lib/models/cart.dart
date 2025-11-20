// lib/models/cart.dart
// A lightweight, flexible Cart implementation that works with your sandwich model(s).
// It expects each sandwich object to expose at least a `price` (num) and a `name` (String)
// or provide equivalent getters/methods (e.g. `id`, `getPrice()`, `toMap()`, `copyWith()`).
//
// The implementation uses `dynamic` where necessary so it can interoperate with
// existing models in your lib folder without requiring a specific interface.

class CartItem {
  dynamic sandwich;
  int quantity;

  CartItem({required this.sandwich, this.quantity = 1});

  String getName() {
    try {
      return (sandwich as dynamic).name as String;
    } catch (_) {
      try {
        return (sandwich as dynamic).title as String;
      } catch (_) {
        return sandwich.toString();
      }
    }
  }

  num getUnitPrice() {
    try {
      return (sandwich as dynamic).price as num;
    } catch (_) {
      try {
        return (sandwich as dynamic).getPrice() as num;
      } catch (_) {
        return 0;
      }
    }
  }

  num getTotalPrice() => getUnitPrice() * quantity;

  Map<String, dynamic> toMap() {
    try {
      // prefer the sandwich's toMap if available
      final sMap = (sandwich as dynamic).toMap();
      return {
        'sandwich': sMap,
        'quantity': quantity,
        'unitPrice': getUnitPrice(),
        'totalPrice': getTotalPrice(),
      };
    } catch (_) {
      return {
        'sandwich': sandwich,
        'quantity': quantity,
        'unitPrice': getUnitPrice(),
        'totalPrice': getTotalPrice(),
      };
    }
  }
}

class Cart {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  bool _sameSandwich(dynamic a, dynamic b) {
    // Try common identifiers: id, name, title; fall back to equality.
    try {
      final aId = (a as dynamic).id;
      final bId = (b as dynamic).id;
      if (aId != null && bId != null) return aId == bId;
    } catch (_) {}
    try {
      final aName = (a as dynamic).name ?? (a as dynamic).title;
      final bName = (b as dynamic).name ?? (b as dynamic).title;
      if (aName != null && bName != null) return aName == bName;
    } catch (_) {}
    return a == b;
  }

  void add(dynamic sandwich, {int quantity = 1}) {
    if (quantity <= 0) return;
    final idx = _items.indexWhere((it) => _sameSandwich(it.sandwich, sandwich));
    if (idx >= 0) {
      _items[idx].quantity += quantity;
    } else {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
  }

  void remove(dynamic sandwich, {int quantity = 0}) {
    final idx = _items.indexWhere((it) => _sameSandwich(it.sandwich, sandwich));
    if (idx < 0) return;
    if (quantity <= 0 || quantity >= _items[idx].quantity) {
      _items.removeAt(idx);
    } else {
      _items[idx].quantity -= quantity;
    }
  }

  void updateQuantity(dynamic sandwich, int quantity) {
    if (quantity < 0) return;
    final idx = _items.indexWhere((it) => _sameSandwich(it.sandwich, sandwich));
    if (idx < 0) {
      if (quantity > 0) _items.add(CartItem(sandwich: sandwich, quantity: quantity));
      return;
    }
    if (quantity == 0) {
      _items.removeAt(idx);
    } else {
      _items[idx].quantity = quantity;
    }
  }

  // If the underlying sandwich model supports copyWith, attempts to replace
  // the sandwich instance for an item (e.g. to change toppings/options).
  bool replaceSandwich(dynamic oldSandwich, dynamic newSandwich) {
    final idx = _items.indexWhere((it) => _sameSandwich(it.sandwich, oldSandwich));
    if (idx < 0) return false;
    _items[idx] = CartItem(sandwich: newSandwich, quantity: _items[idx].quantity);
    return true;
  }

  num get totalPrice {
    num sum = 0;
    for (final it in _items) {
      sum += it.getTotalPrice();
    }
    return sum;
  }

  bool get isEmpty => _items.isEmpty;
  int get totalItems => _items.fold(0, (p, e) => p + e.quantity);

  List<Map<String, dynamic>> toMapList() => _items.map((i) => i.toMap()).toList();

  @override
  String toString() {
    if (_items.isEmpty) return 'Cart(empty)';
    final lines = <String>[];
    for (final it in _items) {
      lines.add('${it.getName()} x${it.quantity} — ${it.getTotalPrice()}');
    }
    lines.add('Total: $totalPrice');
    return lines.join('\n');
  }

  // Convenience: try to edit an individual sandwich using its copyWith if available.
  // Example: cart.editWithCopy(sandwich, (s) => s.copyWith(quantity: newQty));
  bool editWithCopy(dynamic sandwiche, dynamic Function(dynamic) editFn) {
    final idx = _items.indexWhere((it) => _sameSandwich(it.sandwich, sandwiche));
    if (idx < 0) return false;
    try {
      final edited = editFn(_items[idx].sandwich);
      if (edited != null) {
        _items[idx].sandwich = edited;
        return true;
      }
    } catch (_) {}
    return false;
  }

  void clear() => _items.clear();
}