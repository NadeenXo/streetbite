import '../../entities/cart_item_entity.dart';
import '../../entities/order_entity.dart';
import '../../repositories/order_repository.dart';
import '../../services/payment_strategy.dart';

class PlaceOrderUseCase {
  final OrderRepository repository;

  PlaceOrderUseCase(this.repository);

  Future<void> call({
    required String userId,
    required List<CartItemEntity> items,
    required PaymentStrategy paymentStrategy,
    required String paymentMethod,
  }) async {
    if (userId.isEmpty || items.isEmpty) {
      throw StateError('Invalid order');
    }

    final orderItems = List<CartItemEntity>.unmodifiable(items);
    final total = orderItems.fold<int>(0, (sum, item) => sum + item.totalPrice);

    if (total <= 0) {
      throw StateError('Invalid order total');
    }

    final accepted = await paymentStrategy.pay(total);
    if (!accepted) {
      throw StateError('Payment was not accepted');
    }

    final order = OrderEntity(
      id: '',
      userId: userId,
      items: orderItems,
      totalAmount: total,
      paymentMethod: paymentMethod,
      status: 'placed',
      createdAt: DateTime.now().toUtc(),
    );

    await repository.placeOrder(order);
  }
}
