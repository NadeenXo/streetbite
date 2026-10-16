import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/order_entity.dart';
import '../../models/order_model.dart';

abstract interface class OrderRemoteDataSource {
  Future<void> placeOrder(OrderEntity order);

  Stream<List<OrderEntity>> watchOrders(String userId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;

  OrderRemoteDataSourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>> _orders(String userId) {
    return firestore.collection('users').doc(userId).collection('orders');
  }

  @override
  Future<void> placeOrder(OrderEntity order) async {
    await _orders(order.userId).add(OrderModel.toJson(order));
  }

  @override
  Stream<List<OrderEntity>> watchOrders(String userId) {
    return _orders(userId).snapshots().map((snapshot) {
      final orders = snapshot.docs.map(OrderModel.fromDocument).toList();
      orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return orders;
    });
  }
}
