import 'package:equatable/equatable.dart';

class MealEntity extends Equatable {
  final String id;
  final String name;
  final String category;
  final String area;
  final String imageUrl;
  final String instructions;

  const MealEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.imageUrl,
    required this.instructions,
  });

  @override
  List<Object?> get props => [id, name, category, area, imageUrl, instructions];
}
