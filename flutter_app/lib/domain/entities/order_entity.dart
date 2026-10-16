import 'package:equatable/equatable.dart';

import 'cart_item_entity.dart';

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final List<CartItemEntity> items;
  final int totalAmount;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    items,
    totalAmount,
    paymentMethod,
    status,
    createdAt,
  ];
}
