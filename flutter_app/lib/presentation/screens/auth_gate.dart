import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/presentation/blocs/auth/auth_cubit.dart';
import 'package:streetbite/presentation/blocs/auth/auth_state.dart';
import 'package:streetbite/presentation/widgets/auth_failure_message.dart';
import 'package:streetbite/injection.dart';
import 'package:streetbite/presentation/blocs/cart/cart_bloc.dart';
import 'package:streetbite/presentation/blocs/favourites/favourites_cubit.dart';
import 'package:streetbite/presentation/blocs/orders/orders_cubit.dart';
import '../../../core/errors/failures.dart';

import '../../../l10n/app_localizations.dart';

import 'authenticated_landing_screen.dart';
import 'login_screen.dart';

// A single navigation decision point for restored and new auth sessions.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return MultiBlocProvider(
            key: ValueKey(state.user.id),
            providers: [
              BlocProvider<CartBloc>(create: (_) => sl<CartBloc>()),
              BlocProvider<FavouritesCubit>(
                create: (_) => sl<FavouritesCubit>()..start(state.user.id),
              ),
              BlocProvider<OrdersCubit>(create: (_) => sl<OrdersCubit>()),
            ],
            child: const AuthenticatedLandingScreen(),
          );
        }

        if (state is AuthInitial ||
            (state is AuthLoading && state.action == AuthAction.restore)) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthError &&
            (state.action == AuthAction.restore ||
                state.action == AuthAction.logout)) {
          return _SessionProblem(failure: state.failure);
        }

        return const LoginScreen();
      },
    );
  }
}

class _SessionProblem extends StatelessWidget {
  final Failure failure;
  const _SessionProblem({required this.failure});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AuthFailureMessage.forFailure(failure, l10n),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  final cubit = context.read<AuthCubit>();
                  if (cubit.state is AuthError &&
                      (cubit.state as AuthError).action == AuthAction.logout) {
                    cubit.logout();
                  } else {
                    cubit.restoreSession();
                  }
                },
                child: Text(l10n.authTryAgain),
              ),
              TextButton(
                onPressed: () => context.read<AuthCubit>().logout(),
                child: Text(l10n.authLogout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
