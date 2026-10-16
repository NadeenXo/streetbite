import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/meal_entity.dart';

sealed class MealState extends Equatable {
  const MealState();

  @override
  List<Object?> get props => [];
}

final class MealInitial extends MealState {
  const MealInitial();
}

final class MealLoading extends MealState {
  const MealLoading();
}

final class MealLoaded extends MealState {
  final List<MealEntity> meals;

  const MealLoaded(this.meals);

  @override
  List<Object?> get props => [meals];
}

final class MealError extends MealState {
  final Failure failure;

  const MealError(this.failure);

  @override
  List<Object?> get props => [failure];
}
