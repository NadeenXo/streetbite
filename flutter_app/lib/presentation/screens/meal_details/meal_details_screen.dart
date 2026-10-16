import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/meal_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../blocs/favourites/favourites_cubit.dart';
import '../../blocs/favourites/favourites_state.dart';
import '../../widgets/meal_details/meal_instructions.dart';

class MealDetailsScreen extends StatelessWidget {
  final MealEntity meal;

  const MealDetailsScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) =>
          previous.actionId != current.actionId &&
          current.lastAction == CartAction.added,
      listener: (context, state) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.addedToCart)));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(meal.name),
          actions: [
            BlocBuilder<FavouritesCubit, FavouritesState>(
              builder: (context, state) {
                final isFavourite = state.contains(meal.id);

                return IconButton(
                  tooltip: isFavourite
                      ? l10n.removeFavourite
                      : l10n.addFavourite,
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: isFavourite ? Colors.red : null,
                  ),
                  onPressed: state.isLoading
                      ? null
                      : () {
                          context.read<FavouritesCubit>().toggle(meal);
                        },
                );
              },
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth > 700 ? 32.0 : 16.0;

            return SingleChildScrollView(
              padding: EdgeInsets.all(horizontalPadding),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          meal.imageUrl,
                          height: 260,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const SizedBox(
                            height: 260,
                            child: Center(
                              child: Icon(Icons.restaurant, size: 64),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        meal.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      Text('${l10n.category}: ${meal.category}'),
                      Text('${l10n.area}: ${meal.area}'),
                      const SizedBox(height: 24),
                      MealInstructions(
                        title: l10n.instructions,
                        instructions: meal.instructions,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: FilledButton.icon(
            icon: const Icon(Icons.add_shopping_cart),
            label: Text(l10n.addToCart),
            onPressed: () {
              context.read<CartBloc>().add(AddToCart(meal));
            },
          ),
        ),
      ),
    );
  }
}
