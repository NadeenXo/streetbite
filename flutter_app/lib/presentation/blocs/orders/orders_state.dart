import 'package:equatable/equatable.dart';

import '../../../domain/entities/order_entity.dart';

class OrdersState extends Equatable {
  final List<OrderEntity> orders;
  final bool isLoading;
  final bool isSubmitting;
  final bool orderPlaced;
  final String? errorMessage;

  const OrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.isSubmitting = false,
    this.orderPlaced = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    orders,
    isLoading,
    isSubmitting,
    orderPlaced,
    errorMessage,
  ];
}
