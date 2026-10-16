import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failures.dart';
import '../../../core/errors/result.dart';
import '../../../domain/entities/meal_entity.dart';
import '../../../domain/usecases/meals/get_meals_usecase.dart';
import 'meal_event.dart';
import 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final GetMealsUseCase getMealsUseCase;

  MealBloc({required this.getMealsUseCase}) : super(const MealInitial()) {
    on<LoadMeals>(_onLoadMeals);
    on<RefreshMeals>(_onRefreshMeals);
  }

  Future<void> _onLoadMeals(LoadMeals event, Emitter<MealState> emit) async {
    emit(const MealLoading());
    await _fetchMeals(emit);
  }

  Future<void> _onRefreshMeals(
    RefreshMeals event,
    Emitter<MealState> emit,
  ) async {
    emit(const MealLoading());
    await _fetchMeals(emit);
  }

  Future<void> _fetchMeals(Emitter<MealState> emit) async {
    try {
      final result = await getMealsUseCase();

      if (emit.isDone) return;

      switch (result) {
        case Success<List<MealEntity>>(:final data):
          emit(MealLoaded(List.unmodifiable(data)));

        case ErrorResult<List<MealEntity>>(:final failure):
          emit(MealError(failure));
      }
    } catch (_) {
      if (!emit.isDone) {
        emit(const MealError(UnknownFailure()));
      }
    }
  }
}
