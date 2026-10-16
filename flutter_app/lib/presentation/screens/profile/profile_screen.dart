import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/services/device_info_service.dart';
import '../../../injection.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/auth/auth_state.dart';
import '../settings/settings_screen.dart';
import '../vendors/nearby_vendors_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  Uint8List? _selectedPhoto;

  Future<void> _changeProfilePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 75,
        maxWidth: 800,
      );

      if (image == null) return;

      final bytes = await image.readAsBytes();

      if (!mounted) return;

      setState(() {
        _selectedPhoto = bytes;
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not select profile photo')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profile)),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is! AuthAuthenticated) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = state.user;

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _selectedPhoto != null
                          ? MemoryImage(_selectedPhoto!)
                          : null,
                      child: _selectedPhoto == null
                          ? const Icon(Icons.person, size: 48)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: -5,
                      child: IconButton.filled(
                        tooltip: 'Change profile photo',
                        onPressed: _changeProfilePhoto,
                        icon: const Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user.fullName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(user.email, textAlign: TextAlign.center),
              const SizedBox(height: 32),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: Text(l10n.settings),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.map_outlined),
                title: Text(l10n.nearbyVendors),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const NearbyVendorsScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              FutureBuilder<String>(
                future: sl<DeviceInfoService>().getDeviceDescription(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LinearProgressIndicator();
                  }

                  return ListTile(
                    leading: const Icon(Icons.devices),
                    title: const Text('Device Information'),
                    subtitle: Text(snapshot.data ?? 'Information unavailable'),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(l10n.authLogout),
                onTap: () {
                  context.read<AuthCubit>().logout();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
