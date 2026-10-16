import 'package:equatable/equatable.dart';

import '../../../domain/entities/meal_entity.dart';

class FavouritesState extends Equatable {
  final List<MealEntity> meals;
  final bool isLoading;
  final String? errorMessage;

  const FavouritesState({
    this.meals = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  bool contains(String mealId) {
    return meals.any((meal) => meal.id == mealId);
  }

  @override
  List<Object?> get props => [meals, isLoading, errorMessage];
}
