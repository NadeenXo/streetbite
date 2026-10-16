import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/orders/order_remote_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remote;

  OrderRepositoryImpl(this.remote);

  @override
  Future<void> placeOrder(OrderEntity order) {
    return remote.placeOrder(order);
  }

  @override
  Stream<List<OrderEntity>> watchOrders(String userId) {
    return remote.watchOrders(userId);
  }
}
