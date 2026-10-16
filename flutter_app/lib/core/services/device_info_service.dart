import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfoService {
  final DeviceInfoPlugin plugin;

  DeviceInfoService(this.plugin);

  Future<String> getDeviceDescription() async {
    try {
      if (kIsWeb) {
        final info = await plugin.webBrowserInfo;
        return 'Browser: ${info.browserName.name}';
      }

      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          final info = await plugin.androidInfo;
          return 'Android: ${info.manufacturer} ${info.model}';
        case TargetPlatform.iOS:
          final info = await plugin.iosInfo;
          return 'iOS: ${info.name}';
        case TargetPlatform.windows:
          return 'Windows';
        case TargetPlatform.macOS:
          return 'macOS';
        case TargetPlatform.linux:
          return 'Linux';
        case TargetPlatform.fuchsia:
          return 'Unsupported platform';
      }
    } catch (_) {
      return 'Device information unavailable';
    }
  }
}
