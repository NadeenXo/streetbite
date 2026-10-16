import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failures.dart';
import '../../../injection.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../blocs/favourites/favourites_cubit.dart';
import '../../blocs/meals/meal_bloc.dart';
import '../../blocs/meals/meal_event.dart';
import '../../blocs/meals/meal_state.dart';
import '../../blocs/orders/orders_cubit.dart';
import '../cart/cart_screen.dart';
import '../favourites/favourites_screen.dart';
import '../meal_details/meal_details_screen.dart';
import '../orders/orders_screen.dart';
import '../settings/settings_screen.dart';
import '../../widgets/home/featured_meal_banner.dart';
import '../../widgets/home/hot_offers_list.dart';
import '../../widgets/home/meal_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final padding = screenWidth < 400 ? 12.0 : 20.0;

    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) =>
          previous.actionId != current.actionId &&
          current.lastAction == CartAction.added,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.addedToCart),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.appTitle),
          actions: [
            IconButton(
              tooltip: l10n.favourites,
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider<CartBloc>.value(
                          value: context.read<CartBloc>(),
                        ),
                        BlocProvider<FavouritesCubit>.value(
                          value: context.read<FavouritesCubit>(),
                        ),
                      ],
                      child: const FavouritesScreen(),
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return IconButton(
                  tooltip: l10n.cart,
                  icon: Badge(
                    isLabelVisible: state.itemCount > 0,
                    label: Text('${state.itemCount}'),
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => BlocProvider.value(
                          value: context.read<CartBloc>(),
                          child: const CartScreen(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.receipt_long_outlined),
              tooltip: l10n.myOrders,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => BlocProvider<OrdersCubit>(
                      create: (_) => sl<OrdersCubit>(),
                      child: const OrdersScreen(),
                    ),
                  ),
                );
              },
            ),
            // BlocBuilder<ThemeBloc, ThemeState>(
            //   builder: (context, state) {
            //     final isDark = state.themeMode == ThemeMode.dark;

            //     return IconButton(
            //       tooltip: isDark ? l10n.lightMode : l10n.darkMode,
            //       icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            //       onPressed: () {
            //         context.read<ThemeBloc>().add(const ToggleTheme());
            //       },
            //     );
            //   },
            // ),
            IconButton(
              tooltip: l10n.settings,
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<MealBloc, MealState>(
          builder: (context, state) {
            switch (state) {
              case MealInitial():
              case MealLoading():
                return const Center(child: CircularProgressIndicator());
              case MealError(:final failure):
                final message = failure is NetworkFailure
                    ? l10n.checkInternet
                    : l10n.mealLoadError;

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off_outlined, size: 56),
                        const SizedBox(height: 16),
                        Text(message, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<MealBloc>().add(const LoadMeals());
                          },
                          child: Text(l10n.retry),
                        ),
                      ],
                    ),
                  ),
                );
              case MealLoaded(:final meals):
                if (meals.isEmpty) {
                  return Center(child: Text(l10n.noMealsAvailable));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    final bloc = context.read<MealBloc>();

                    bloc.add(const RefreshMeals());

                    await bloc.stream.firstWhere(
                      (state) => state is MealLoaded || state is MealError,
                    );
                  },
                  child: ListView(
                    padding: EdgeInsets.all(padding),
                    children: [
                      Text(
                        l10n.featuredMeals,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      FeaturedMealBanner(meals: meals),
                      const SizedBox(height: 24),
                      Text(
                        l10n.hotOffers,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      HotOffersList(meals: meals),
                      const SizedBox(height: 24),
                      Text(
                        l10n.exploreMeals,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: meals.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          mainAxisExtent: screenWidth < 400 ? 210 : 240,
                        ),
                        itemBuilder: (context, index) {
                          return MealCard(
                            meal: meals[index],
                            onAddToCart: () {
                              context.read<CartBloc>().add(
                                AddToCart(meals[index]),
                              );
                            },
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<CartBloc>.value(
                                        value: context.read<CartBloc>(),
                                      ),
                                      BlocProvider<FavouritesCubit>.value(
                                        value: context.read<FavouritesCubit>(),
                                      ),
                                    ],
                                    child: MealDetailsScreen(
                                      meal: meals[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
