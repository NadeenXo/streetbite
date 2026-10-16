import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/presentation/screens/auth_gate.dart';

import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'injection.dart';
import 'l10n/app_localizations.dart';

import 'presentation/blocs/locale/locale_cubit.dart';
import 'presentation/blocs/locale/locale_state.dart';
import 'presentation/blocs/auth/auth_cubit.dart';
import 'presentation/blocs/auth/auth_state.dart';
import 'presentation/blocs/cart/cart_bloc.dart';
import 'presentation/blocs/favourites/favourites_cubit.dart';
import 'presentation/blocs/theme/theme_bloc.dart';
import 'presentation/blocs/theme/theme_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initDependencies();

  runApp(const StreetBiteApp());
}

class StreetBiteApp extends StatelessWidget {
  const StreetBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()..start()),
        BlocProvider<CartBloc>(create: (_) => sl<CartBloc>()),
        BlocProvider<FavouritesCubit>(create: (_) => sl<FavouritesCubit>()),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, localeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              onGenerateTitle: (context) =>
                  AppLocalizations.of(context).appTitle,

              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeState.themeMode,

              locale: localeState.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,

              home: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    context.read<FavouritesCubit>().start(state.user.id);
                  } else if (state is AuthUnauthenticated) {
                    context.read<FavouritesCubit>().reset();
                  }
                },
                child: const AuthGate(),
              ),
            );
          },
        );
      },
    );
  }
}
