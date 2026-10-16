import 'package:flutter/material.dart';

import '../../../domain/entities/meal_entity.dart';

class FeaturedMealBanner extends StatelessWidget {
  final List<MealEntity> meals;

  const FeaturedMealBanner({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final featured = meals.take(3).toList();

    if (featured.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 210,
      child: PageView.builder(
        itemCount: featured.length,
        itemBuilder: (context, index) {
          final meal = featured[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    meal.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, error, stackTrace) {
                      return const Center(child: Icon(Icons.restaurant));
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87],
                        ),
                      ),
                      child: Text(
                        meal.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
