import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/entities/cart_pricing.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>(_onAdd);
    on<RemoveFromCart>(_onRemove);
    on<IncreaseQuantity>(_onIncrease);
    on<DecreaseQuantity>(_onDecrease);
    on<ClearCart>(_onClear);
  }

  void _update(
    List<CartItemEntity> items,
    Emitter<CartState> emit, {
    CartAction action = CartAction.none,
  }) {
    emit(
      CartState(
        items: List.unmodifiable(items),
        lastAction: action,
        actionId: state.actionId + 1,
      ),
    );
  }

  void _onAdd(AddToCart event, Emitter<CartState> emit) {
    final items = [...state.items];
    final index = items.indexWhere((item) => item.meal.id == event.meal.id);

    if (index == -1) {
      items.add(
        CartItemEntity(
          meal: event.meal,
          quantity: 1,
          unitPrice: CartPricing.demoMealPrice,
        ),
      );
    } else {
      final item = items[index];
      items[index] = item.copyWith(quantity: item.quantity + 1);
    }

    _update(items, emit, action: CartAction.added);
  }

  void _onRemove(RemoveFromCart event, Emitter<CartState> emit) {
    final items = state.items
        .where((item) => item.meal.id != event.mealId)
        .toList();

    if (items.length == state.items.length) return;

    _update(
      items,
      emit,
      action: items.isEmpty ? CartAction.emptied : CartAction.none,
    );
  }

  void _onIncrease(IncreaseQuantity event, Emitter<CartState> emit) {
    final items = state.items.map((item) {
      if (item.meal.id == event.mealId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();

    _update(items, emit);
  }

  void _onDecrease(DecreaseQuantity event, Emitter<CartState> emit) {
    final items = <CartItemEntity>[];

    for (final item in state.items) {
      if (item.meal.id != event.mealId) {
        items.add(item);
      } else if (item.quantity > 1) {
        items.add(item.copyWith(quantity: item.quantity - 1));
      }
    }

    _update(
      items,
      emit,
      action: items.isEmpty && state.items.isNotEmpty
          ? CartAction.emptied
          : CartAction.none,
    );
  }

  void _onClear(ClearCart event, Emitter<CartState> emit) {
    if (state.items.isEmpty) return;

    _update([], emit, action: CartAction.emptied);
  }
}
