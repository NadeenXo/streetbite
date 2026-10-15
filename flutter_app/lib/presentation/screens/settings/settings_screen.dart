import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../blocs/locale/locale_cubit.dart';
import '../../blocs/locale/locale_state.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/theme/theme_event.dart';
import '../../blocs/theme/theme_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return SwitchListTile(
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.dark_mode_outlined),
                title: Text(l10n.darkMode),
                value: state.themeMode == ThemeMode.dark,
                onChanged: (_) {
                  context.read<ThemeBloc>().add(const ToggleTheme());
                },
              );
            },
          ),
          const Divider(),
          BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, state) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.language),
                title: Text(l10n.language),
                trailing: DropdownButton<Locale>(
                  value: state.locale,
                  onChanged: (locale) {
                    if (locale != null) {
                      context.read<LocaleCubit>().setLocale(locale);
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: const Locale('en'),
                      child: Text(l10n.english),
                    ),
                    DropdownMenuItem(
                      value: const Locale('ar'),
                      child: Text(l10n.arabic),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
