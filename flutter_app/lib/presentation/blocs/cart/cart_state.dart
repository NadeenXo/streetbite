import 'package:equatable/equatable.dart';

import '../../../domain/entities/cart_item_entity.dart';

enum CartAction { none, added, emptied }

class CartState extends Equatable {
  final List<CartItemEntity> items;
  final CartAction lastAction;
  final int actionId;

  const CartState({
    this.items = const [],
    this.lastAction = CartAction.none,
    this.actionId = 0,
  });

  int get itemCount => items.fold<int>(0, (sum, item) => sum + item.quantity);

  int get totalPrice =>
      items.fold<int>(0, (sum, item) => sum + item.totalPrice);

  @override
  List<Object?> get props => [items, lastAction, actionId];
}
