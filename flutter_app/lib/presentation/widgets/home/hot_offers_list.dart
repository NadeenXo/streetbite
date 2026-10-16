import 'package:flutter/material.dart';

import '../../../domain/entities/meal_entity.dart';

class HotOffersList extends StatelessWidget {
  final List<MealEntity> meals;

  const HotOffersList({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final offers = meals.take(5).toList();

    if (offers.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 145,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: offers.length,
        separatorBuilder: (_, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final meal = offers[index];

          return SizedBox(
            width: 125,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    meal.imageUrl,
                    width: 125,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (_, error, stackTrace) {
                      return const SizedBox(
                        width: 125,
                        height: 100,
                        child: Icon(Icons.restaurant),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 6),
                Text(meal.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          );
        },
      ),
    );
  }
}
