import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../blocs/auth/auth_cubit.dart';
import '../blocs/auth/auth_state.dart';
import 'settings/settings_screen.dart';

// Temporary post-login screen until the real API-driven Home is implemented.
class AuthenticatedLandingScreen extends StatelessWidget {
  final UserEntity user;
  const AuthenticatedLandingScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.settings,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.authSignedInAs(user.fullName)),
              const SizedBox(height: 8),
              Text(user.email),
              const SizedBox(height: 24),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final loading =
                      state is AuthLoading && state.action == AuthAction.logout;
                  return FilledButton(
                    onPressed: loading
                        ? null
                        : () => context.read<AuthCubit>().logout(),
                    child: Text(l10n.authLogout),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
