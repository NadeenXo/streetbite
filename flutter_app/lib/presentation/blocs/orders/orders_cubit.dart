import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/repositories/order_repository.dart';
import '../../../domain/services/payment_strategy.dart';
import '../../../domain/usecases/orders/place_order_usecase.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final PlaceOrderUseCase placeOrderUseCase;
  final OrderRepository repository;

  StreamSubscription<List<OrderEntity>>? _subscription;

  OrdersCubit({required this.placeOrderUseCase, required this.repository})
    : super(const OrdersState());

  Future<void> placeOrder({
    required String userId,
    required List<CartItemEntity> items,
    required PaymentStrategy paymentStrategy,
    required String paymentMethod,
  }) async {
    if (state.isSubmitting) return;

    emit(const OrdersState(isSubmitting: true));

    try {
      await placeOrderUseCase(
        userId: userId,
        items: items,
        paymentStrategy: paymentStrategy,
        paymentMethod: paymentMethod,
      );
      emit(const OrdersState(orderPlaced: true));
    } catch (_) {
      emit(const OrdersState(errorMessage: 'Could not place your order'));
    }
  }

  void watchOrders(String userId) {
    _subscription?.cancel();
    emit(const OrdersState(isLoading: true));

    _subscription = repository
        .watchOrders(userId)
        .listen(
          (orders) => emit(OrdersState(orders: orders)),
          onError: (Object error) {
            emit(const OrdersState(errorMessage: 'Could not load orders'));
          },
        );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
