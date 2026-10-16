import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/meal_model.dart';

abstract class FavouriteRemoteDataSource {
  Stream<List<MealModel>> watchFavourites(String userId);

  Future<bool> isFavourite(String userId, String mealId);

  Future<void> addFavourite(String userId, MealModel meal);

  Future<void> removeFavourite(String userId, String mealId);
}

class FavouriteRemoteDataSourceImpl implements FavouriteRemoteDataSource {
  final FirebaseFirestore firestore;

  FavouriteRemoteDataSourceImpl(this.firestore);

  CollectionReference<Map<String, dynamic>> _collection(String userId) {
    return firestore.collection('users').doc(userId).collection('favourites');
  }

  @override
  Stream<List<MealModel>> watchFavourites(String userId) {
    return _collection(userId).snapshots().map(
      (snapshot) => snapshot.docs.map((doc) {
        return MealModel.fromJson(doc.data());
      }).toList(),
    );
  }

  @override
  Future<bool> isFavourite(String userId, String mealId) async {
    final snapshot = await _collection(userId).doc(mealId).get();

    return snapshot.exists;
  }

  @override
  Future<void> addFavourite(String userId, MealModel meal) async {
    await _collection(userId).doc(meal.id).set(meal.toJson());
  }

  @override
  Future<void> removeFavourite(String userId, String mealId) async {
    await _collection(userId).doc(mealId).delete();
  }
}
