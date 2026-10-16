import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/order_entity.dart';
import 'meal_model.dart';

class OrderModel {
  OrderModel._();

  static Map<String, dynamic> toJson(OrderEntity order) {
    return {
      'userId': order.userId,
      'totalAmount': order.totalAmount,
      'paymentMethod': order.paymentMethod,
      'status': order.status,
      'createdAt': Timestamp.fromDate(order.createdAt),
      'items': order.items.map((item) {
        return {
          'meal': {
            'id': item.meal.id,
            'name': item.meal.name,
            'category': item.meal.category,
            'area': item.meal.area,
            'imageUrl': item.meal.imageUrl,
            'instructions': item.meal.instructions,
          },
          'quantity': item.quantity,
          'unitPrice': item.unitPrice,
        };
      }).toList(),
    };
  }

  static OrderEntity fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    final items = (data['items'] as List).map((rawItem) {
      final item = Map<String, dynamic>.from(rawItem as Map);
      final mealData = Map<String, dynamic>.from(item['meal'] as Map);
      final meal = MealModel(
        id: mealData['id'] as String,
        name: mealData['name'] as String,
        category: mealData['category'] as String,
        area: mealData['area'] as String,
        imageUrl: mealData['imageUrl'] as String,
        instructions: mealData['instructions'] as String,
      );

      return CartItemEntity(
        meal: meal,
        quantity: (item['quantity'] as num).toInt(),
        unitPrice: (item['unitPrice'] as num).toInt(),
      );
    }).toList();

    return OrderEntity(
      id: document.id,
      userId: data['userId'] as String,
      items: List.unmodifiable(items),
      totalAmount: (data['totalAmount'] as num).toInt(),
      paymentMethod: data['paymentMethod'] as String,
      status: data['status'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
