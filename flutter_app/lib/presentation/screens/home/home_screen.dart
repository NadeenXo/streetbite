import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failures.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/meals/meal_bloc.dart';
import '../../blocs/meals/meal_event.dart';
import '../../blocs/meals/meal_state.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/theme/theme_event.dart';
import '../../blocs/theme/theme_state.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              final isDark = state.themeMode == ThemeMode.dark;

              return IconButton(
                tooltip: isDark ? l10n.lightMode : l10n.darkMode,
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  context.read<ThemeBloc>().add(const ToggleTheme());
                },
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
                        return MealCard(meal: meals[index]);
                      },
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
