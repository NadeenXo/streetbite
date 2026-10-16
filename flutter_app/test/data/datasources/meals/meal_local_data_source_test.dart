import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:streetbite/data/datasources/meals/meal_local_data_source_impl.dart';
import 'package:streetbite/data/models/meal_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('saves meals and restores them from cache', () async {
    final preferences = await SharedPreferences.getInstance();

    final dataSource = MealLocalDataSourceImpl(preferences: preferences);

    const meals = [
      MealModel(
        id: '123',
        name: 'Apple Tart',
        category: 'Dessert',
        area: 'British',
        imageUrl: 'https://example.com/meal.jpg',
        instructions: 'Prepare and bake.',
      ),
    ];

    await dataSource.cacheMeals(meals);

    final cachedMeals = await dataSource.getCachedMeals();

    expect(cachedMeals.length, 1);
    expect(cachedMeals.first.id, '123');
    expect(cachedMeals.first.name, 'Apple Tart');
  });
}
