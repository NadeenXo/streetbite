
<p align="center">
  <img src="screenshots/streetbite_logo.png" width="400" alt="StreetBite Logo">
</p>

<p align="center">
  <strong>Good Food. Closer to You.</strong>
</p>
## About

**StreetBite V1.0** is a Flutter food discovery and demo ordering app. Browse meals from **TheMealDB**, save favourites, manage a cart, and view orders.

## Features

- Firebase email/password authentication and Firestore-backed profiles, favourites and orders
- Live meals via Dio, with `shared_preferences` menu caching
- Featured meals, Hot Offers, meal details and reactive cart using BLoC/Cubit
- Demo checkout: cash on delivery and simulated card payment (**no real charges**)
- English / Arabic (RTL), light / dark themes and device information
- Nearby Vendors (Google Maps) and fingerprint profile access: **optional Android features; require device and API configuration**

## Technology

Flutter · Dart · Firebase Auth · Cloud Firestore · Dio · `flutter_bloc` · GetIt · `shared_preferences` · `google_maps_flutter` · `local_auth`

**Architecture:** `lib/data/` → `lib/domain/` ← `lib/presentation/` (Clean Architecture). Uses Builder, Factory, Singleton and Strategy patterns.

## Run locally

```bash
cd flutter_app
flutter pub get
flutterfire configure
flutter gen-l10n
flutter run
```

Requires Flutter, an Android device/emulator, and a Firebase project with Email/Password Auth and Firestore configured. `flutterfire configure` generates the platform Firebase configuration; do not commit private credentials or service-account keys.

### Google Maps key (Android)

1. Enable **Maps SDK for Android** and billing in Google Cloud.
2. Copy `android/secrets.properties.example` to `android/secrets.properties` and replace the placeholder with your key.
3. Configure the Android manifest/Gradle Secrets plugin to read `MAPS_API_KEY` and restrict the key by Android package name and signing SHA-1 (including the release SHA-1).
4. **Never commit `android/secrets.properties`.** For Web maps, use a separate browser-restricted key and Web setup.

```properties
MAPS_API_KEY=YOUR_GOOGLE_MAPS_API_KEY
```

## Quality & release

```bash
dart format .
flutter analyze
flutter test
flutter build apk --release
```

Release APK: `flutter_app/build/app/outputs/flutter-apk/app-release.apk`. Distribute via **Firebase App Distribution** to at least two testers and record release/tester evidence. Final QA results and Android screenshots should reflect actual executions, not concept mockups.

## Branding

![StreetBite Brand Guide](screenshots/img1.png)

| App Icon | Splash Screen Concept |
|---|---|
| ![StreetBite Icon](screenshots/streetbite_icon.png) | ![StreetBite Splash](screenshots/img2.png) |