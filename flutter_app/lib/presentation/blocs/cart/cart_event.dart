import 'package:equatable/equatable.dart';

import '../../../domain/entities/meal_entity.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

final class AddToCart extends CartEvent {
  final MealEntity meal;

  const AddToCart(this.meal);

  @override
  List<Object?> get props => [meal];
}

final class RemoveFromCart extends CartEvent {
  final String mealId;

  const RemoveFromCart(this.mealId);

  @override
  List<Object?> get props => [mealId];
}

final class IncreaseQuantity extends CartEvent {
  final String mealId;

  const IncreaseQuantity(this.mealId);

  @override
  List<Object?> get props => [mealId];
}

final class DecreaseQuantity extends CartEvent {
  final String mealId;

  const DecreaseQuantity(this.mealId);

  @override
  List<Object?> get props => [mealId];
}

final class ClearCart extends CartEvent {
  const ClearCart();
}
