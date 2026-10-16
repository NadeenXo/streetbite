import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/meal_entity.dart';
import '../../../domain/repositories/favourite_repository.dart';
import '../../../domain/usecases/favourites/toggle_favourite_usecase.dart';
import 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final FavouriteRepository repository;
  final ToggleFavouriteUseCase toggleFavouriteUseCase;

  StreamSubscription<List<MealEntity>>? _subscription;
  String? _userId;

  FavouritesCubit({
    required this.repository,
    required this.toggleFavouriteUseCase,
  }) : super(const FavouritesState());

  void start(String userId) {
    if (_userId == userId && _subscription != null) return;

    _subscription?.cancel();
    _userId = userId;
    emit(const FavouritesState(isLoading: true));

    _subscription = repository
        .watchFavourites(userId)
        .listen(
          (meals) => emit(FavouritesState(meals: meals)),
          onError: (Object error) {
            emit(
              const FavouritesState(errorMessage: 'Could not load favourites'),
            );
          },
        );
  }

  Future<void> toggle(MealEntity meal) async {
    final userId = _userId;
    if (userId == null) return;

    try {
      await toggleFavouriteUseCase(userId: userId, meal: meal);
    } catch (_) {
      emit(
        FavouritesState(
          meals: state.meals,
          errorMessage: 'Could not update favourites',
        ),
      );
    }
  }

  Future<void> reset() async {
    _userId = null;
    await _subscription?.cancel();
    _subscription = null;
    emit(const FavouritesState());
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
