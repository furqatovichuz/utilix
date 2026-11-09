# Utilix

All-in-one toolbox app for Android and iOS, built with Flutter. 27 offline tools in 6 sections,
available in 7 languages: English, Русский, O'zbekcha, Қазақша, Кыргызча, Türkmençe, Türkçe.

No account, no ads, no tracking. Everything runs on the device; the app does not use the internet.

## Sections

| Section | Tools |
| --- | --- |
| Calculators | Calculator, unit converter, number bases, BMI, loan, percent, VAT |
| PDF & images | Images to PDF, merge PDF, split PDF, text to PDF, compress / resize / convert images |
| Text & security | Text tools, number to words, JSON formatter, password generator |
| Generators | QR code (save as PNG), random picker, color picker |
| Everyday | Timer, date calculator, counter, fuel cost |
| Device | Flashlight, spirit level |

## Run

```bash
flutter pub get
flutter gen-l10n
flutter run
```

## Test

```bash
flutter analyze
flutter test
```

## Build for Google Play

Create `android/key.properties` (it is git-ignored) pointing to your upload keystore:

```
storePassword=...
keyPassword=...
keyAlias=upload
storeFile=C:/path/to/upload-keystore.jks
```

Then:

```bash
flutter build appbundle --release
```

Without `key.properties` the release build falls back to the debug key, which is fine for local testing only.

## Localization

ARB files live in `lib/l10n/`. `app_en.arb` is the template. Turkmen has no Flutter Material
translations, so system widgets fall back to Turkish. Kazakh, Kyrgyz and Turkmen texts should be
reviewed by native speakers.

## Privacy

See [PRIVACY.md](PRIVACY.md).
