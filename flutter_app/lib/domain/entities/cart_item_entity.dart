import 'package:equatable/equatable.dart';

import 'meal_entity.dart';

class CartItemEntity extends Equatable {
  final MealEntity meal;
  final int quantity;
  final int unitPrice;

  const CartItemEntity({
    required this.meal,
    required this.quantity,
    required this.unitPrice,
  });

  int get totalPrice => quantity * unitPrice;

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(
      meal: meal,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice,
    );
  }

  @override
  List<Object?> get props => [meal, quantity, unitPrice];
}
