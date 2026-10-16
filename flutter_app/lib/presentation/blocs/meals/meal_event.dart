import 'package:equatable/equatable.dart';

sealed class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object?> get props => [];
}

// Triggered when the Home screen opens.
final class LoadMeals extends MealEvent {
  const LoadMeals();
}

// Triggered when the user refreshes the menu.
final class RefreshMeals extends MealEvent {
  const RefreshMeals();
}
