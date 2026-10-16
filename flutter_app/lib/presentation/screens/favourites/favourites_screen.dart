import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/favourites/favourites_cubit.dart';
import '../../blocs/favourites/favourites_state.dart';
import '../meal_details/meal_details_screen.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.favourites)),
      body: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.errorMessage != null) {
            return Center(child: Text(l10n.favouritesError));
          }
          if (state.meals.isEmpty) {
            return Center(child: Text(l10n.noFavourites));
          }

          return ListView.builder(
            itemCount: state.meals.length,
            itemBuilder: (context, index) {
              final meal = state.meals[index];

              return ListTile(
                leading: Image.network(
                  meal.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(Icons.restaurant),
                ),
                title: Text(meal.name),
                subtitle: Text(meal.category),
                trailing: IconButton(
                  tooltip: l10n.removeFavourite,
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    context.read<FavouritesCubit>().toggle(meal);
                  },
                ),
                onTap: () {
                  final cartBloc = context.read<CartBloc>();
                  final favouritesCubit = context.read<FavouritesCubit>();

                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider<CartBloc>.value(value: cartBloc),
                          BlocProvider<FavouritesCubit>.value(
                            value: favouritesCubit,
                          ),
                        ],
                        child: MealDetailsScreen(meal: meal),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
