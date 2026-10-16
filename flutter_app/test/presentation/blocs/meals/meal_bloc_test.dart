import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:streetbite/core/errors/failures.dart';
import 'package:streetbite/core/errors/result.dart';
import 'package:streetbite/domain/entities/meal_entity.dart';
import 'package:streetbite/domain/repositories/meal_repository.dart';
import 'package:streetbite/domain/usecases/meals/get_meals_usecase.dart';
import 'package:streetbite/presentation/blocs/meals/meal_bloc.dart';
import 'package:streetbite/presentation/blocs/meals/meal_event.dart';
import 'package:streetbite/presentation/blocs/meals/meal_state.dart';

class MockMealRepository extends Mock implements MealRepository {}

void main() {
  late MockMealRepository repository;

  setUp(() {
    repository = MockMealRepository();
  });

  MealBloc createBloc() {
    return MealBloc(getMealsUseCase: GetMealsUseCase(repository));
  }

  const meals = [
    MealEntity(
      id: '123',
      name: 'Apple Tart',
      category: 'Dessert',
      area: 'British',
      imageUrl: 'https://example.com/meal.jpg',
      instructions: 'Prepare and bake.',
    ),
  ];

  blocTest<MealBloc, MealState>(
    'emits loading and loaded when fetching succeeds',
    build: () {
      when(
        () => repository.getMeals(),
      ).thenAnswer((_) async => const Success<List<MealEntity>>(meals));

      return createBloc();
    },
    act: (bloc) => bloc.add(const LoadMeals()),
    expect: () => [const MealLoading(), const MealLoaded(meals)],
    verify: (_) {
      verify(() => repository.getMeals()).called(1);
    },
  );

  blocTest<MealBloc, MealState>(
    'emits loading and error when fetching fails',
    build: () {
      when(() => repository.getMeals()).thenAnswer(
        (_) async => const ErrorResult<List<MealEntity>>(NetworkFailure()),
      );

      return createBloc();
    },
    act: (bloc) => bloc.add(const LoadMeals()),
    expect: () => [const MealLoading(), const MealError(NetworkFailure())],
  );

  blocTest<MealBloc, MealState>(
    'refresh requests meals again',
    build: () {
      when(
        () => repository.getMeals(),
      ).thenAnswer((_) async => const Success<List<MealEntity>>(meals));

      return createBloc();
    },
    act: (bloc) => bloc.add(const RefreshMeals()),
    expect: () => [const MealLoading(), const MealLoaded(meals)],
    verify: (_) {
      verify(() => repository.getMeals()).called(1);
    },
  );
}
