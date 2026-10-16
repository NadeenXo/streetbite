import 'package:flutter/material.dart';

class MealInstructions extends StatelessWidget {
  final String title;
  final String instructions;

  const MealInstructions({
    super.key,
    required this.title,
    required this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Text(instructions, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
