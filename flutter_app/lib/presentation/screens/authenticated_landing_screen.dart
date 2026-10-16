import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/meals/meal_bloc.dart';
import '../blocs/meals/meal_event.dart';
import 'home/home_screen.dart';

class AuthenticatedLandingScreen extends StatelessWidget {
  const AuthenticatedLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MealBloc>(
          create: (_) => sl<MealBloc>()..add(const LoadMeals()),
        ),
        BlocProvider<CartBloc>.value(value: context.read<CartBloc>()),
      ],
      child: const HomeScreen(),
    );
  }
}
