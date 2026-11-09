import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ky.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tk.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ky'),
    Locale('ru'),
    Locale('tk'),
    Locale('tr'),
    Locale('uz'),
  ];

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'All the tools you need in one app'**
  String get appTagline;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} handy tools in one place'**
  String homeSubtitle(int count);

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search tools...'**
  String get searchHint;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @sectionRecent.
  ///
  /// In en, this message translates to:
  /// **'Recently used'**
  String get sectionRecent;

  /// No description provided for @sectionFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get sectionFavorites;

  /// No description provided for @sectionAllTools.
  ///
  /// In en, this message translates to:
  /// **'All tools'**
  String get sectionAllTools;

  /// No description provided for @sectionResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get sectionResults;

  /// No description provided for @nothingFound.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get nothingFound;

  /// No description provided for @themeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTooltip;

  /// No description provided for @languageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTooltip;

  /// No description provided for @catCalculators.
  ///
  /// In en, this message translates to:
  /// **'Calculators'**
  String get catCalculators;

  /// No description provided for @catConverters.
  ///
  /// In en, this message translates to:
  /// **'Converters'**
  String get catConverters;

  /// No description provided for @catText.
  ///
  /// In en, this message translates to:
  /// **'Text & security'**
  String get catText;

  /// No description provided for @catGenerators.
  ///
  /// In en, this message translates to:
  /// **'Generators'**
  String get catGenerators;

  /// No description provided for @catTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get catTime;

  /// No description provided for @catDesign.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get catDesign;

  /// No description provided for @catFiles.
  ///
  /// In en, this message translates to:
  /// **'PDF & images'**
  String get catFiles;

  /// No description provided for @catLife.
  ///
  /// In en, this message translates to:
  /// **'Everyday'**
  String get catLife;

  /// No description provided for @catDevice.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get catDevice;

  /// No description provided for @toolCalculator.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get toolCalculator;

  /// No description provided for @toolCalculatorDesc.
  ///
  /// In en, this message translates to:
  /// **'Expressions, brackets and functions'**
  String get toolCalculatorDesc;

  /// No description provided for @toolUnits.
  ///
  /// In en, this message translates to:
  /// **'Unit converter'**
  String get toolUnits;

  /// No description provided for @toolUnitsDesc.
  ///
  /// In en, this message translates to:
  /// **'Length, weight, temperature, volume...'**
  String get toolUnitsDesc;

  /// No description provided for @toolQr.
  ///
  /// In en, this message translates to:
  /// **'QR generator'**
  String get toolQr;

  /// No description provided for @toolQrDesc.
  ///
  /// In en, this message translates to:
  /// **'QR code from text or a link'**
  String get toolQrDesc;

  /// No description provided for @toolPassword.
  ///
  /// In en, this message translates to:
  /// **'Password generator'**
  String get toolPassword;

  /// No description provided for @toolPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Strong and secure passwords'**
  String get toolPasswordDesc;

  /// No description provided for @toolBmi.
  ///
  /// In en, this message translates to:
  /// **'BMI calculator'**
  String get toolBmi;

  /// No description provided for @toolBmiDesc.
  ///
  /// In en, this message translates to:
  /// **'Body mass index'**
  String get toolBmiDesc;

  /// No description provided for @toolLoan.
  ///
  /// In en, this message translates to:
  /// **'Loan calculator'**
  String get toolLoan;

  /// No description provided for @toolLoanDesc.
  ///
  /// In en, this message translates to:
  /// **'Monthly payment and total interest'**
  String get toolLoanDesc;

  /// No description provided for @toolTimer.
  ///
  /// In en, this message translates to:
  /// **'Timer & stopwatch'**
  String get toolTimer;

  /// No description provided for @toolTimerDesc.
  ///
  /// In en, this message translates to:
  /// **'Countdown and lap times'**
  String get toolTimerDesc;

  /// No description provided for @toolText.
  ///
  /// In en, this message translates to:
  /// **'Text tools'**
  String get toolText;

  /// No description provided for @toolTextDesc.
  ///
  /// In en, this message translates to:
  /// **'Counter, case, Base64, SHA-256'**
  String get toolTextDesc;

  /// No description provided for @toolColor.
  ///
  /// In en, this message translates to:
  /// **'Color picker'**
  String get toolColor;

  /// No description provided for @toolColorDesc.
  ///
  /// In en, this message translates to:
  /// **'Convert RGB, HEX and HSL'**
  String get toolColorDesc;

  /// No description provided for @toolPercent.
  ///
  /// In en, this message translates to:
  /// **'Percentage calculator'**
  String get toolPercent;

  /// No description provided for @toolPercentDesc.
  ///
  /// In en, this message translates to:
  /// **'Percent, discount and change'**
  String get toolPercentDesc;

  /// No description provided for @toolDate.
  ///
  /// In en, this message translates to:
  /// **'Dates & age'**
  String get toolDate;

  /// No description provided for @toolDateDesc.
  ///
  /// In en, this message translates to:
  /// **'Date difference and days to anniversary'**
  String get toolDateDesc;

  /// No description provided for @toolRandom.
  ///
  /// In en, this message translates to:
  /// **'Random picker'**
  String get toolRandom;

  /// No description provided for @toolRandomDesc.
  ///
  /// In en, this message translates to:
  /// **'Number, coin, dice, pick from a list'**
  String get toolRandomDesc;

  /// No description provided for @toolFlashlight.
  ///
  /// In en, this message translates to:
  /// **'Flashlight'**
  String get toolFlashlight;

  /// No description provided for @toolFlashlightDesc.
  ///
  /// In en, this message translates to:
  /// **'Turn on the phone\'s light'**
  String get toolFlashlightDesc;

  /// No description provided for @toolLevel.
  ///
  /// In en, this message translates to:
  /// **'Spirit level'**
  String get toolLevel;

  /// No description provided for @toolLevelDesc.
  ///
  /// In en, this message translates to:
  /// **'Check if a surface is level'**
  String get toolLevelDesc;

  /// No description provided for @toolNumberWords.
  ///
  /// In en, this message translates to:
  /// **'Number to words'**
  String get toolNumberWords;

  /// No description provided for @toolNumberWordsDesc.
  ///
  /// In en, this message translates to:
  /// **'Write a number out in words'**
  String get toolNumberWordsDesc;

  /// No description provided for @toolVat.
  ///
  /// In en, this message translates to:
  /// **'VAT calculator'**
  String get toolVat;

  /// No description provided for @toolVatDesc.
  ///
  /// In en, this message translates to:
  /// **'Add or remove VAT'**
  String get toolVatDesc;

  /// No description provided for @toolCounter.
  ///
  /// In en, this message translates to:
  /// **'Tally counter'**
  String get toolCounter;

  /// No description provided for @toolCounterDesc.
  ///
  /// In en, this message translates to:
  /// **'Count fast: tap and add'**
  String get toolCounterDesc;

  /// No description provided for @toolJson.
  ///
  /// In en, this message translates to:
  /// **'JSON formatter'**
  String get toolJson;

  /// No description provided for @toolJsonDesc.
  ///
  /// In en, this message translates to:
  /// **'Validate, prettify and minify'**
  String get toolJsonDesc;

  /// No description provided for @toolRadix.
  ///
  /// In en, this message translates to:
  /// **'Number bases'**
  String get toolRadix;

  /// No description provided for @toolRadixDesc.
  ///
  /// In en, this message translates to:
  /// **'Convert BIN, OCT, DEC, HEX'**
  String get toolRadixDesc;

  /// No description provided for @toolFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel consumption'**
  String get toolFuel;

  /// No description provided for @toolFuelDesc.
  ///
  /// In en, this message translates to:
  /// **'Per 100 km and trip cost'**
  String get toolFuelDesc;

  /// No description provided for @toolImagesToPdf.
  ///
  /// In en, this message translates to:
  /// **'Image to PDF'**
  String get toolImagesToPdf;

  /// No description provided for @toolImagesToPdfDesc.
  ///
  /// In en, this message translates to:
  /// **'Make one PDF from several images'**
  String get toolImagesToPdfDesc;

  /// No description provided for @toolTextToPdf.
  ///
  /// In en, this message translates to:
  /// **'Text to PDF'**
  String get toolTextToPdf;

  /// No description provided for @toolTextToPdfDesc.
  ///
  /// In en, this message translates to:
  /// **'Create a PDF file from text'**
  String get toolTextToPdfDesc;

  /// No description provided for @toolPdfMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge PDF'**
  String get toolPdfMerge;

  /// No description provided for @toolPdfMergeDesc.
  ///
  /// In en, this message translates to:
  /// **'Combine several PDFs into one'**
  String get toolPdfMergeDesc;

  /// No description provided for @toolPdfSplit.
  ///
  /// In en, this message translates to:
  /// **'Split PDF'**
  String get toolPdfSplit;

  /// No description provided for @toolPdfSplitDesc.
  ///
  /// In en, this message translates to:
  /// **'Extract or split pages'**
  String get toolPdfSplitDesc;

  /// No description provided for @toolImageCompress.
  ///
  /// In en, this message translates to:
  /// **'Compress image'**
  String get toolImageCompress;

  /// No description provided for @toolImageCompressDesc.
  ///
  /// In en, this message translates to:
  /// **'Reduce the file size'**
  String get toolImageCompressDesc;

  /// No description provided for @toolImageResize.
  ///
  /// In en, this message translates to:
  /// **'Resize image'**
  String get toolImageResize;

  /// No description provided for @toolImageResizeDesc.
  ///
  /// In en, this message translates to:
  /// **'Change the pixel dimensions'**
  String get toolImageResizeDesc;

  /// No description provided for @toolImageConvert.
  ///
  /// In en, this message translates to:
  /// **'Format & rotate'**
  String get toolImageConvert;

  /// No description provided for @toolImageConvertDesc.
  ///
  /// In en, this message translates to:
  /// **'PNG ↔ JPG, rotate, mirror'**
  String get toolImageConvertDesc;

  /// No description provided for @unitGroupLength.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get unitGroupLength;

  /// No description provided for @unitGroupMass.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get unitGroupMass;

  /// No description provided for @unitGroupVolume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get unitGroupVolume;

  /// No description provided for @unitGroupArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get unitGroupArea;

  /// No description provided for @unitGroupSpeed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get unitGroupSpeed;

  /// No description provided for @unitGroupData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get unitGroupData;

  /// No description provided for @unitGroupTemp.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get unitGroupTemp;

  /// No description provided for @valueLabel.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get valueLabel;

  /// No description provided for @fromUnit.
  ///
  /// In en, this message translates to:
  /// **'From unit'**
  String get fromUnit;

  /// No description provided for @toUnit.
  ///
  /// In en, this message translates to:
  /// **'To unit'**
  String get toUnit;

  /// No description provided for @qrInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Text or link'**
  String get qrInputLabel;

  /// No description provided for @qrEnterText.
  ///
  /// In en, this message translates to:
  /// **'Enter some text'**
  String get qrEnterText;

  /// No description provided for @qrCopyText.
  ///
  /// In en, this message translates to:
  /// **'Copy text'**
  String get qrCopyText;

  /// No description provided for @pwLabel.
  ///
  /// In en, this message translates to:
  /// **'Password (tap to copy)'**
  String get pwLabel;

  /// No description provided for @pwStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength: {level}'**
  String pwStrength(String level);

  /// No description provided for @pwWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get pwWeak;

  /// No description provided for @pwMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get pwMedium;

  /// No description provided for @pwStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get pwStrong;

  /// No description provided for @pwVeryStrong.
  ///
  /// In en, this message translates to:
  /// **'Very strong'**
  String get pwVeryStrong;

  /// No description provided for @pwLength.
  ///
  /// In en, this message translates to:
  /// **'Length: {n}'**
  String pwLength(int n);

  /// No description provided for @pwUpper.
  ///
  /// In en, this message translates to:
  /// **'Uppercase letters (A–Z)'**
  String get pwUpper;

  /// No description provided for @pwDigits.
  ///
  /// In en, this message translates to:
  /// **'Digits (0–9)'**
  String get pwDigits;

  /// No description provided for @pwSymbols.
  ///
  /// In en, this message translates to:
  /// **'Symbols (!@#...)'**
  String get pwSymbols;

  /// No description provided for @pwNew.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get pwNew;

  /// No description provided for @heightLabel.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get heightLabel;

  /// No description provided for @weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weightLabel;

  /// No description provided for @unitCm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get unitCm;

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @bmiLabel.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get bmiLabel;

  /// No description provided for @bmiSevereUnder.
  ///
  /// In en, this message translates to:
  /// **'Severely underweight'**
  String get bmiSevereUnder;

  /// No description provided for @bmiUnder.
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get bmiUnder;

  /// No description provided for @bmiNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get bmiNormal;

  /// No description provided for @bmiOver.
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get bmiOver;

  /// No description provided for @bmiObese.
  ///
  /// In en, this message translates to:
  /// **'Obese'**
  String get bmiObese;

  /// No description provided for @bmiHealthyRange.
  ///
  /// In en, this message translates to:
  /// **'Healthy weight range: {min}–{max} kg'**
  String bmiHealthyRange(String min, String max);

  /// No description provided for @bmiDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This is an approximate indicator, not a medical diagnosis.'**
  String get bmiDisclaimer;

  /// No description provided for @loanAmount.
  ///
  /// In en, this message translates to:
  /// **'Loan amount'**
  String get loanAmount;

  /// No description provided for @loanRate.
  ///
  /// In en, this message translates to:
  /// **'Annual interest rate'**
  String get loanRate;

  /// No description provided for @loanTerm.
  ///
  /// In en, this message translates to:
  /// **'Term'**
  String get loanTerm;

  /// No description provided for @unitMonths.
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get unitMonths;

  /// No description provided for @loanAnnuity.
  ///
  /// In en, this message translates to:
  /// **'Annuity'**
  String get loanAnnuity;

  /// No description provided for @loanDifferential.
  ///
  /// In en, this message translates to:
  /// **'Declining'**
  String get loanDifferential;

  /// No description provided for @loanMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly payment'**
  String get loanMonthly;

  /// No description provided for @loanTotal.
  ///
  /// In en, this message translates to:
  /// **'Total payment'**
  String get loanTotal;

  /// No description provided for @loanOverpay.
  ///
  /// In en, this message translates to:
  /// **'Interest paid'**
  String get loanOverpay;

  /// No description provided for @stopwatchTab.
  ///
  /// In en, this message translates to:
  /// **'Stopwatch'**
  String get stopwatchTab;

  /// No description provided for @timerTab.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get timerTab;

  /// No description provided for @lap.
  ///
  /// In en, this message translates to:
  /// **'Lap'**
  String get lap;

  /// No description provided for @resetAll.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get resetAll;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get restart;

  /// No description provided for @timeIsUp.
  ///
  /// In en, this message translates to:
  /// **'Time is up!'**
  String get timeIsUp;

  /// No description provided for @timerMinutes.
  ///
  /// In en, this message translates to:
  /// **'{n} min'**
  String timerMinutes(int n);

  /// No description provided for @timerCustom.
  ///
  /// In en, this message translates to:
  /// **'Choose my own time'**
  String get timerCustom;

  /// No description provided for @timerPickerHelp.
  ///
  /// In en, this message translates to:
  /// **'Hours : minutes'**
  String get timerPickerHelp;

  /// No description provided for @textLabel.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get textLabel;

  /// No description provided for @statChars.
  ///
  /// In en, this message translates to:
  /// **'Characters'**
  String get statChars;

  /// No description provided for @statWords.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get statWords;

  /// No description provided for @statLines.
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get statLines;

  /// No description provided for @statBytes.
  ///
  /// In en, this message translates to:
  /// **'Bytes'**
  String get statBytes;

  /// No description provided for @sectionCase.
  ///
  /// In en, this message translates to:
  /// **'Case'**
  String get sectionCase;

  /// No description provided for @caseUpper.
  ///
  /// In en, this message translates to:
  /// **'UPPERCASE'**
  String get caseUpper;

  /// No description provided for @caseLower.
  ///
  /// In en, this message translates to:
  /// **'lowercase'**
  String get caseLower;

  /// No description provided for @caseTitle.
  ///
  /// In en, this message translates to:
  /// **'Title Case'**
  String get caseTitle;

  /// No description provided for @trimSpaces.
  ///
  /// In en, this message translates to:
  /// **'Trim spaces'**
  String get trimSpaces;

  /// No description provided for @reverseText.
  ///
  /// In en, this message translates to:
  /// **'Reverse'**
  String get reverseText;

  /// No description provided for @sectionEncoding.
  ///
  /// In en, this message translates to:
  /// **'Encoding'**
  String get sectionEncoding;

  /// No description provided for @b64Encode.
  ///
  /// In en, this message translates to:
  /// **'Base64 encode'**
  String get b64Encode;

  /// No description provided for @b64Decode.
  ///
  /// In en, this message translates to:
  /// **'Base64 decode'**
  String get b64Decode;

  /// No description provided for @urlEncode.
  ///
  /// In en, this message translates to:
  /// **'URL encode'**
  String get urlEncode;

  /// No description provided for @urlDecode.
  ///
  /// In en, this message translates to:
  /// **'URL decode'**
  String get urlDecode;

  /// No description provided for @sectionHash.
  ///
  /// In en, this message translates to:
  /// **'Hash'**
  String get sectionHash;

  /// No description provided for @hashHint.
  ///
  /// In en, this message translates to:
  /// **'Enter text to see its hashes'**
  String get hashHint;

  /// No description provided for @textOpError.
  ///
  /// In en, this message translates to:
  /// **'Could not apply (invalid format)'**
  String get textOpError;

  /// No description provided for @pcOfTitle.
  ///
  /// In en, this message translates to:
  /// **'What is X% of Y?'**
  String get pcOfTitle;

  /// No description provided for @pcPercentX.
  ///
  /// In en, this message translates to:
  /// **'Percent (X)'**
  String get pcPercentX;

  /// No description provided for @pcNumberY.
  ///
  /// In en, this message translates to:
  /// **'Number (Y)'**
  String get pcNumberY;

  /// No description provided for @pcWhatTitle.
  ///
  /// In en, this message translates to:
  /// **'X is what percent of Y?'**
  String get pcWhatTitle;

  /// No description provided for @pcDiscountTitle.
  ///
  /// In en, this message translates to:
  /// **'Price after discount'**
  String get pcDiscountTitle;

  /// No description provided for @pcDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get pcDiscount;

  /// No description provided for @pcOriginalPrice.
  ///
  /// In en, this message translates to:
  /// **'Original price'**
  String get pcOriginalPrice;

  /// No description provided for @pcSaved.
  ///
  /// In en, this message translates to:
  /// **'{price}  (you save: {saved})'**
  String pcSaved(String price, String saved);

  /// No description provided for @pcChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'By what percent did the value change?'**
  String get pcChangeTitle;

  /// No description provided for @pcOld.
  ///
  /// In en, this message translates to:
  /// **'Old value'**
  String get pcOld;

  /// No description provided for @pcNew.
  ///
  /// In en, this message translates to:
  /// **'New value'**
  String get pcNew;

  /// No description provided for @dateStart.
  ///
  /// In en, this message translates to:
  /// **'Start date (birthday)'**
  String get dateStart;

  /// No description provided for @dateEnd.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get dateEnd;

  /// No description provided for @dateEndToday.
  ///
  /// In en, this message translates to:
  /// **'End date — today'**
  String get dateEndToday;

  /// No description provided for @dateDifference.
  ///
  /// In en, this message translates to:
  /// **'Difference'**
  String get dateDifference;

  /// No description provided for @dateYmd.
  ///
  /// In en, this message translates to:
  /// **'{y} y {m} mo {d} d'**
  String dateYmd(int y, int m, int d);

  /// No description provided for @dateTotalDays.
  ///
  /// In en, this message translates to:
  /// **'Total days'**
  String get dateTotalDays;

  /// No description provided for @dateWeeksHours.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks  •  {hours} hours'**
  String dateWeeksHours(String weeks, String hours);

  /// No description provided for @dateNextAnniversary.
  ///
  /// In en, this message translates to:
  /// **'Until the next anniversary ({date})'**
  String dateNextAnniversary(String date);

  /// No description provided for @dateToday.
  ///
  /// In en, this message translates to:
  /// **'Today!'**
  String get dateToday;

  /// No description provided for @dateDays.
  ///
  /// In en, this message translates to:
  /// **'{n} days'**
  String dateDays(int n);

  /// No description provided for @rndNumber.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get rndNumber;

  /// No description provided for @rndCoin.
  ///
  /// In en, this message translates to:
  /// **'Coin'**
  String get rndCoin;

  /// No description provided for @rndDice.
  ///
  /// In en, this message translates to:
  /// **'Dice'**
  String get rndDice;

  /// No description provided for @rndPick.
  ///
  /// In en, this message translates to:
  /// **'Pick'**
  String get rndPick;

  /// No description provided for @rndFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get rndFrom;

  /// No description provided for @rndTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get rndTo;

  /// No description provided for @rndDiceCount.
  ///
  /// In en, this message translates to:
  /// **'Number of dice:'**
  String get rndDiceCount;

  /// No description provided for @rndListHint.
  ///
  /// In en, this message translates to:
  /// **'Write one option per line'**
  String get rndListHint;

  /// No description provided for @rndRoll.
  ///
  /// In en, this message translates to:
  /// **'Pick randomly'**
  String get rndRoll;

  /// No description provided for @rndInvalidRange.
  ///
  /// In en, this message translates to:
  /// **'Invalid range'**
  String get rndInvalidRange;

  /// No description provided for @rndListEmpty.
  ///
  /// In en, this message translates to:
  /// **'The list is empty'**
  String get rndListEmpty;

  /// No description provided for @rndHeads.
  ///
  /// In en, this message translates to:
  /// **'Heads 🪙'**
  String get rndHeads;

  /// No description provided for @rndTails.
  ///
  /// In en, this message translates to:
  /// **'Tails 🪙'**
  String get rndTails;

  /// No description provided for @flashOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get flashOn;

  /// No description provided for @flashOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get flashOff;

  /// No description provided for @flashError.
  ///
  /// In en, this message translates to:
  /// **'Flashlight is not available or the camera is in use'**
  String get flashError;

  /// No description provided for @levelNoSensor.
  ///
  /// In en, this message translates to:
  /// **'No accelerometer found on this device'**
  String get levelNoSensor;

  /// No description provided for @levelFlat.
  ///
  /// In en, this message translates to:
  /// **'Level ✓'**
  String get levelFlat;

  /// No description provided for @levelHint.
  ///
  /// In en, this message translates to:
  /// **'Place the phone on a flat surface'**
  String get levelHint;

  /// No description provided for @nwInput.
  ///
  /// In en, this message translates to:
  /// **'Number (e.g. 1250300)'**
  String get nwInput;

  /// No description provided for @nwResult.
  ///
  /// In en, this message translates to:
  /// **'In words'**
  String get nwResult;

  /// No description provided for @nwTooBig.
  ///
  /// In en, this message translates to:
  /// **'The number must be less than 1,000 trillion'**
  String get nwTooBig;

  /// No description provided for @vatAdd.
  ///
  /// In en, this message translates to:
  /// **'Add VAT'**
  String get vatAdd;

  /// No description provided for @vatExtract.
  ///
  /// In en, this message translates to:
  /// **'Remove VAT'**
  String get vatExtract;

  /// No description provided for @vatNetInput.
  ///
  /// In en, this message translates to:
  /// **'Amount without VAT'**
  String get vatNetInput;

  /// No description provided for @vatGrossInput.
  ///
  /// In en, this message translates to:
  /// **'Amount with VAT'**
  String get vatGrossInput;

  /// No description provided for @vatRate.
  ///
  /// In en, this message translates to:
  /// **'VAT rate'**
  String get vatRate;

  /// No description provided for @vatNet.
  ///
  /// In en, this message translates to:
  /// **'Amount without VAT'**
  String get vatNet;

  /// No description provided for @vatAmount.
  ///
  /// In en, this message translates to:
  /// **'VAT amount'**
  String get vatAmount;

  /// No description provided for @vatGross.
  ///
  /// In en, this message translates to:
  /// **'Amount with VAT'**
  String get vatGross;

  /// No description provided for @counterReset.
  ///
  /// In en, this message translates to:
  /// **'Reset to zero'**
  String get counterReset;

  /// No description provided for @counterHint.
  ///
  /// In en, this message translates to:
  /// **'Tap anywhere on the screen'**
  String get counterHint;

  /// No description provided for @counterSubtract.
  ///
  /// In en, this message translates to:
  /// **'Subtract ({n})'**
  String counterSubtract(int n);

  /// No description provided for @jsonPretty.
  ///
  /// In en, this message translates to:
  /// **'Prettify'**
  String get jsonPretty;

  /// No description provided for @jsonMinify.
  ///
  /// In en, this message translates to:
  /// **'Minify'**
  String get jsonMinify;

  /// No description provided for @jsonValid.
  ///
  /// In en, this message translates to:
  /// **'Valid JSON ✓'**
  String get jsonValid;

  /// No description provided for @jsonError.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String jsonError(String message);

  /// No description provided for @jsonErrorAt.
  ///
  /// In en, this message translates to:
  /// **'Error: {message} (char {pos})'**
  String jsonErrorAt(String message, int pos);

  /// No description provided for @radixValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Value ({name})'**
  String radixValueLabel(String name);

  /// No description provided for @radixInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid character for this base'**
  String get radixInvalid;

  /// No description provided for @fuelDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance driven'**
  String get fuelDistance;

  /// No description provided for @fuelUsed.
  ///
  /// In en, this message translates to:
  /// **'Fuel used'**
  String get fuelUsed;

  /// No description provided for @fuelPrice.
  ///
  /// In en, this message translates to:
  /// **'Price per litre (optional)'**
  String get fuelPrice;

  /// No description provided for @unitKm.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get unitKm;

  /// No description provided for @unitLiter.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get unitLiter;

  /// No description provided for @fuelPer100.
  ///
  /// In en, this message translates to:
  /// **'Consumption per 100 km'**
  String get fuelPer100;

  /// No description provided for @fuelPerKm.
  ///
  /// In en, this message translates to:
  /// **'Cost per km'**
  String get fuelPerKm;

  /// No description provided for @fuelTotal.
  ///
  /// In en, this message translates to:
  /// **'Total cost'**
  String get fuelTotal;

  /// No description provided for @fuelMpg.
  ///
  /// In en, this message translates to:
  /// **'Miles per gallon (MPG, US)'**
  String get fuelMpg;

  /// No description provided for @pdfPickOne.
  ///
  /// In en, this message translates to:
  /// **'Choose one or more images'**
  String get pdfPickOne;

  /// No description provided for @pdfFitToImage.
  ///
  /// In en, this message translates to:
  /// **'Page matches image size'**
  String get pdfFitToImage;

  /// No description provided for @pdfFitOff.
  ///
  /// In en, this message translates to:
  /// **'Off — A4 page'**
  String get pdfFitOff;

  /// No description provided for @pdfMargin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get pdfMargin;

  /// No description provided for @addImage.
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get addImage;

  /// No description provided for @createPdf.
  ///
  /// In en, this message translates to:
  /// **'Create PDF'**
  String get createPdf;

  /// No description provided for @pdfCreateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not create the PDF'**
  String get pdfCreateFailed;

  /// No description provided for @chooseImage.
  ///
  /// In en, this message translates to:
  /// **'Choose image'**
  String get chooseImage;

  /// No description provided for @chooseAnotherImage.
  ///
  /// In en, this message translates to:
  /// **'Choose another image'**
  String get chooseAnotherImage;

  /// No description provided for @imageOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the image'**
  String get imageOpenFailed;

  /// No description provided for @qualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quality: {n}%'**
  String qualityLabel(int n);

  /// No description provided for @qualityHint.
  ///
  /// In en, this message translates to:
  /// **'Lower quality means a smaller file. 60–75% is usually unnoticeable.'**
  String get qualityHint;

  /// No description provided for @longestSide.
  ///
  /// In en, this message translates to:
  /// **'Longest side (pixels)'**
  String get longestSide;

  /// No description provided for @customSize.
  ///
  /// In en, this message translates to:
  /// **'Or enter your own'**
  String get customSize;

  /// No description provided for @rotateLeft.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get rotateLeft;

  /// No description provided for @rotateRight.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get rotateRight;

  /// No description provided for @mirror.
  ///
  /// In en, this message translates to:
  /// **'Mirror'**
  String get mirror;

  /// No description provided for @rotationLabel.
  ///
  /// In en, this message translates to:
  /// **'Rotation: {deg}°'**
  String rotationLabel(int deg);

  /// No description provided for @saveShare.
  ///
  /// In en, this message translates to:
  /// **'Save / Share'**
  String get saveShare;

  /// No description provided for @pdfPickAtLeast2.
  ///
  /// In en, this message translates to:
  /// **'Choose at least 2 PDF files'**
  String get pdfPickAtLeast2;

  /// No description provided for @addPdf.
  ///
  /// In en, this message translates to:
  /// **'Add PDF'**
  String get addPdf;

  /// No description provided for @mergeAction.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get mergeAction;

  /// No description provided for @filesSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} files • {size} • drag to reorder'**
  String filesSummary(int count, String size);

  /// No description provided for @fileReadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read the file'**
  String get fileReadFailed;

  /// No description provided for @mergeFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not merge. A file may be damaged or password-protected'**
  String get mergeFailed;

  /// No description provided for @choosePdf.
  ///
  /// In en, this message translates to:
  /// **'Choose PDF'**
  String get choosePdf;

  /// No description provided for @chooseAnotherPdf.
  ///
  /// In en, this message translates to:
  /// **'Choose another PDF'**
  String get chooseAnotherPdf;

  /// No description provided for @pdfPagesSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} pages • {size}'**
  String pdfPagesSummary(int count, String size);

  /// No description provided for @splitModePages.
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get splitModePages;

  /// No description provided for @splitModeEach.
  ///
  /// In en, this message translates to:
  /// **'Each'**
  String get splitModeEach;

  /// No description provided for @splitModeEvery.
  ///
  /// In en, this message translates to:
  /// **'Every N'**
  String get splitModeEvery;

  /// No description provided for @pageSelectLabel.
  ///
  /// In en, this message translates to:
  /// **'Pages to keep'**
  String get pageSelectLabel;

  /// No description provided for @pageSelectHint.
  ///
  /// In en, this message translates to:
  /// **'For example: 1-3, 5, 8-10'**
  String get pageSelectHint;

  /// No description provided for @pageSelectHelper.
  ///
  /// In en, this message translates to:
  /// **'From 1 to {n}'**
  String pageSelectHelper(int n);

  /// No description provided for @pageSelectError.
  ///
  /// In en, this message translates to:
  /// **'Invalid format or page number'**
  String get pageSelectError;

  /// No description provided for @pageSelectNote.
  ///
  /// In en, this message translates to:
  /// **'One new PDF is made from the selected pages.'**
  String get pageSelectNote;

  /// No description provided for @splitEachNote.
  ///
  /// In en, this message translates to:
  /// **'Every page becomes a separate PDF file.'**
  String get splitEachNote;

  /// No description provided for @splitEveryLabel.
  ///
  /// In en, this message translates to:
  /// **'Split every N pages'**
  String get splitEveryLabel;

  /// No description provided for @pagesSuffix.
  ///
  /// In en, this message translates to:
  /// **'pages'**
  String get pagesSuffix;

  /// No description provided for @summaryOne.
  ///
  /// In en, this message translates to:
  /// **'1 file, {n} pages'**
  String summaryOne(int n);

  /// No description provided for @summaryMany.
  ///
  /// In en, this message translates to:
  /// **'{n} files will be created'**
  String summaryMany(int n);

  /// No description provided for @splitAndShare.
  ///
  /// In en, this message translates to:
  /// **'Split and share'**
  String get splitAndShare;

  /// No description provided for @splitInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid page selection'**
  String get splitInvalid;

  /// No description provided for @splitTooMany.
  ///
  /// In en, this message translates to:
  /// **'Cannot create more than {max} files at once. Choose a larger step'**
  String splitTooMany(int max);

  /// No description provided for @splitFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not split the file'**
  String get splitFailed;

  /// No description provided for @pdfOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the PDF. It may be damaged or password-protected'**
  String get pdfOpenFailed;

  /// No description provided for @t2pTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title (optional)'**
  String get t2pTitleLabel;

  /// No description provided for @fontSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Font size: {n}'**
  String fontSizeLabel(int n);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'kk',
    'ky',
    'ru',
    'tk',
    'tr',
    'uz',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'kk':
      return AppLocalizationsKk();
    case 'ky':
      return AppLocalizationsKy();
    case 'ru':
      return AppLocalizationsRu();
    case 'tk':
      return AppLocalizationsTk();
    case 'tr':
      return AppLocalizationsTr();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
