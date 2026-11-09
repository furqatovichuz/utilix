// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTagline => 'All the tools you need in one app';

  @override
  String get copied => 'Copied';

  @override
  String get copy => 'Copy';

  @override
  String get clear => 'Clear';

  @override
  String get paste => 'Paste';

  @override
  String get result => 'Result';

  @override
  String get apply => 'Apply';

  @override
  String get share => 'Share';

  @override
  String homeSubtitle(int count) {
    return '$count handy tools in one place';
  }

  @override
  String get searchHint => 'Search tools...';

  @override
  String get filterAll => 'All';

  @override
  String get sectionRecent => 'Recently used';

  @override
  String get sectionFavorites => 'Favorites';

  @override
  String get sectionAllTools => 'All tools';

  @override
  String get sectionResults => 'Results';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String get themeTooltip => 'Theme';

  @override
  String get languageTooltip => 'Language';

  @override
  String get catCalculators => 'Calculators';

  @override
  String get catConverters => 'Converters';

  @override
  String get catText => 'Text & security';

  @override
  String get catGenerators => 'Generators';

  @override
  String get catTime => 'Time';

  @override
  String get catDesign => 'Design';

  @override
  String get catFiles => 'PDF & images';

  @override
  String get catLife => 'Everyday';

  @override
  String get catDevice => 'Device';

  @override
  String get toolCalculator => 'Calculator';

  @override
  String get toolCalculatorDesc => 'Expressions, brackets and functions';

  @override
  String get toolUnits => 'Unit converter';

  @override
  String get toolUnitsDesc => 'Length, weight, temperature, volume...';

  @override
  String get toolQr => 'QR generator';

  @override
  String get toolQrDesc => 'QR code from text or a link';

  @override
  String get toolPassword => 'Password generator';

  @override
  String get toolPasswordDesc => 'Strong and secure passwords';

  @override
  String get toolBmi => 'BMI calculator';

  @override
  String get toolBmiDesc => 'Body mass index';

  @override
  String get toolLoan => 'Loan calculator';

  @override
  String get toolLoanDesc => 'Monthly payment and total interest';

  @override
  String get toolTimer => 'Timer & stopwatch';

  @override
  String get toolTimerDesc => 'Countdown and lap times';

  @override
  String get toolText => 'Text tools';

  @override
  String get toolTextDesc => 'Counter, case, Base64, SHA-256';

  @override
  String get toolColor => 'Color picker';

  @override
  String get toolColorDesc => 'Convert RGB, HEX and HSL';

  @override
  String get toolPercent => 'Percentage calculator';

  @override
  String get toolPercentDesc => 'Percent, discount and change';

  @override
  String get toolDate => 'Dates & age';

  @override
  String get toolDateDesc => 'Date difference and days to anniversary';

  @override
  String get toolRandom => 'Random picker';

  @override
  String get toolRandomDesc => 'Number, coin, dice, pick from a list';

  @override
  String get toolFlashlight => 'Flashlight';

  @override
  String get toolFlashlightDesc => 'Turn on the phone\'s light';

  @override
  String get toolLevel => 'Spirit level';

  @override
  String get toolLevelDesc => 'Check if a surface is level';

  @override
  String get toolNumberWords => 'Number to words';

  @override
  String get toolNumberWordsDesc => 'Write a number out in words';

  @override
  String get toolVat => 'VAT calculator';

  @override
  String get toolVatDesc => 'Add or remove VAT';

  @override
  String get toolCounter => 'Tally counter';

  @override
  String get toolCounterDesc => 'Count fast: tap and add';

  @override
  String get toolJson => 'JSON formatter';

  @override
  String get toolJsonDesc => 'Validate, prettify and minify';

  @override
  String get toolRadix => 'Number bases';

  @override
  String get toolRadixDesc => 'Convert BIN, OCT, DEC, HEX';

  @override
  String get toolFuel => 'Fuel consumption';

  @override
  String get toolFuelDesc => 'Per 100 km and trip cost';

  @override
  String get toolImagesToPdf => 'Image to PDF';

  @override
  String get toolImagesToPdfDesc => 'Make one PDF from several images';

  @override
  String get toolTextToPdf => 'Text to PDF';

  @override
  String get toolTextToPdfDesc => 'Create a PDF file from text';

  @override
  String get toolPdfMerge => 'Merge PDF';

  @override
  String get toolPdfMergeDesc => 'Combine several PDFs into one';

  @override
  String get toolPdfSplit => 'Split PDF';

  @override
  String get toolPdfSplitDesc => 'Extract or split pages';

  @override
  String get toolImageCompress => 'Compress image';

  @override
  String get toolImageCompressDesc => 'Reduce the file size';

  @override
  String get toolImageResize => 'Resize image';

  @override
  String get toolImageResizeDesc => 'Change the pixel dimensions';

  @override
  String get toolImageConvert => 'Format & rotate';

  @override
  String get toolImageConvertDesc => 'PNG ↔ JPG, rotate, mirror';

  @override
  String get unitGroupLength => 'Length';

  @override
  String get unitGroupMass => 'Weight';

  @override
  String get unitGroupVolume => 'Volume';

  @override
  String get unitGroupArea => 'Area';

  @override
  String get unitGroupSpeed => 'Speed';

  @override
  String get unitGroupData => 'Data';

  @override
  String get unitGroupTemp => 'Temperature';

  @override
  String get valueLabel => 'Value';

  @override
  String get fromUnit => 'From unit';

  @override
  String get toUnit => 'To unit';

  @override
  String get qrInputLabel => 'Text or link';

  @override
  String get qrEnterText => 'Enter some text';

  @override
  String get qrCopyText => 'Copy text';

  @override
  String get pwLabel => 'Password (tap to copy)';

  @override
  String pwStrength(String level) {
    return 'Strength: $level';
  }

  @override
  String get pwWeak => 'Weak';

  @override
  String get pwMedium => 'Medium';

  @override
  String get pwStrong => 'Strong';

  @override
  String get pwVeryStrong => 'Very strong';

  @override
  String pwLength(int n) {
    return 'Length: $n';
  }

  @override
  String get pwUpper => 'Uppercase letters (A–Z)';

  @override
  String get pwDigits => 'Digits (0–9)';

  @override
  String get pwSymbols => 'Symbols (!@#...)';

  @override
  String get pwNew => 'New password';

  @override
  String get heightLabel => 'Height';

  @override
  String get weightLabel => 'Weight';

  @override
  String get unitCm => 'cm';

  @override
  String get unitKg => 'kg';

  @override
  String get bmiLabel => 'BMI';

  @override
  String get bmiSevereUnder => 'Severely underweight';

  @override
  String get bmiUnder => 'Underweight';

  @override
  String get bmiNormal => 'Normal';

  @override
  String get bmiOver => 'Overweight';

  @override
  String get bmiObese => 'Obese';

  @override
  String bmiHealthyRange(String min, String max) {
    return 'Healthy weight range: $min–$max kg';
  }

  @override
  String get bmiDisclaimer =>
      'This is an approximate indicator, not a medical diagnosis.';

  @override
  String get loanAmount => 'Loan amount';

  @override
  String get loanRate => 'Annual interest rate';

  @override
  String get loanTerm => 'Term';

  @override
  String get unitMonths => 'months';

  @override
  String get loanAnnuity => 'Annuity';

  @override
  String get loanDifferential => 'Declining';

  @override
  String get loanMonthly => 'Monthly payment';

  @override
  String get loanTotal => 'Total payment';

  @override
  String get loanOverpay => 'Interest paid';

  @override
  String get stopwatchTab => 'Stopwatch';

  @override
  String get timerTab => 'Timer';

  @override
  String get lap => 'Lap';

  @override
  String get resetAll => 'Clear';

  @override
  String get start => 'Start';

  @override
  String get stop => 'Stop';

  @override
  String get restart => 'Reset';

  @override
  String get timeIsUp => 'Time is up!';

  @override
  String timerMinutes(int n) {
    return '$n min';
  }

  @override
  String get timerCustom => 'Choose my own time';

  @override
  String get timerPickerHelp => 'Hours : minutes';

  @override
  String get textLabel => 'Text';

  @override
  String get statChars => 'Characters';

  @override
  String get statWords => 'Words';

  @override
  String get statLines => 'Lines';

  @override
  String get statBytes => 'Bytes';

  @override
  String get sectionCase => 'Case';

  @override
  String get caseUpper => 'UPPERCASE';

  @override
  String get caseLower => 'lowercase';

  @override
  String get caseTitle => 'Title Case';

  @override
  String get trimSpaces => 'Trim spaces';

  @override
  String get reverseText => 'Reverse';

  @override
  String get sectionEncoding => 'Encoding';

  @override
  String get b64Encode => 'Base64 encode';

  @override
  String get b64Decode => 'Base64 decode';

  @override
  String get urlEncode => 'URL encode';

  @override
  String get urlDecode => 'URL decode';

  @override
  String get sectionHash => 'Hash';

  @override
  String get hashHint => 'Enter text to see its hashes';

  @override
  String get textOpError => 'Could not apply (invalid format)';

  @override
  String get pcOfTitle => 'What is X% of Y?';

  @override
  String get pcPercentX => 'Percent (X)';

  @override
  String get pcNumberY => 'Number (Y)';

  @override
  String get pcWhatTitle => 'X is what percent of Y?';

  @override
  String get pcDiscountTitle => 'Price after discount';

  @override
  String get pcDiscount => 'Discount';

  @override
  String get pcOriginalPrice => 'Original price';

  @override
  String pcSaved(String price, String saved) {
    return '$price  (you save: $saved)';
  }

  @override
  String get pcChangeTitle => 'By what percent did the value change?';

  @override
  String get pcOld => 'Old value';

  @override
  String get pcNew => 'New value';

  @override
  String get dateStart => 'Start date (birthday)';

  @override
  String get dateEnd => 'End date';

  @override
  String get dateEndToday => 'End date — today';

  @override
  String get dateDifference => 'Difference';

  @override
  String dateYmd(int y, int m, int d) {
    return '$y y $m mo $d d';
  }

  @override
  String get dateTotalDays => 'Total days';

  @override
  String dateWeeksHours(String weeks, String hours) {
    return '$weeks weeks  •  $hours hours';
  }

  @override
  String dateNextAnniversary(String date) {
    return 'Until the next anniversary ($date)';
  }

  @override
  String get dateToday => 'Today!';

  @override
  String dateDays(int n) {
    return '$n days';
  }

  @override
  String get rndNumber => 'Number';

  @override
  String get rndCoin => 'Coin';

  @override
  String get rndDice => 'Dice';

  @override
  String get rndPick => 'Pick';

  @override
  String get rndFrom => 'From';

  @override
  String get rndTo => 'To';

  @override
  String get rndDiceCount => 'Number of dice:';

  @override
  String get rndListHint => 'Write one option per line';

  @override
  String get rndRoll => 'Pick randomly';

  @override
  String get rndInvalidRange => 'Invalid range';

  @override
  String get rndListEmpty => 'The list is empty';

  @override
  String get rndHeads => 'Heads 🪙';

  @override
  String get rndTails => 'Tails 🪙';

  @override
  String get flashOn => 'On';

  @override
  String get flashOff => 'Off';

  @override
  String get flashError =>
      'Flashlight is not available or the camera is in use';

  @override
  String get levelNoSensor => 'No accelerometer found on this device';

  @override
  String get levelFlat => 'Level ✓';

  @override
  String get levelHint => 'Place the phone on a flat surface';

  @override
  String get nwInput => 'Number (e.g. 1250300)';

  @override
  String get nwResult => 'In words';

  @override
  String get nwTooBig => 'The number must be less than 1,000 trillion';

  @override
  String get vatAdd => 'Add VAT';

  @override
  String get vatExtract => 'Remove VAT';

  @override
  String get vatNetInput => 'Amount without VAT';

  @override
  String get vatGrossInput => 'Amount with VAT';

  @override
  String get vatRate => 'VAT rate';

  @override
  String get vatNet => 'Amount without VAT';

  @override
  String get vatAmount => 'VAT amount';

  @override
  String get vatGross => 'Amount with VAT';

  @override
  String get counterReset => 'Reset to zero';

  @override
  String get counterHint => 'Tap anywhere on the screen';

  @override
  String counterSubtract(int n) {
    return 'Subtract ($n)';
  }

  @override
  String get jsonPretty => 'Prettify';

  @override
  String get jsonMinify => 'Minify';

  @override
  String get jsonValid => 'Valid JSON ✓';

  @override
  String jsonError(String message) {
    return 'Error: $message';
  }

  @override
  String jsonErrorAt(String message, int pos) {
    return 'Error: $message (char $pos)';
  }

  @override
  String radixValueLabel(String name) {
    return 'Value ($name)';
  }

  @override
  String get radixInvalid => 'Invalid character for this base';

  @override
  String get fuelDistance => 'Distance driven';

  @override
  String get fuelUsed => 'Fuel used';

  @override
  String get fuelPrice => 'Price per litre (optional)';

  @override
  String get unitKm => 'km';

  @override
  String get unitLiter => 'L';

  @override
  String get fuelPer100 => 'Consumption per 100 km';

  @override
  String get fuelPerKm => 'Cost per km';

  @override
  String get fuelTotal => 'Total cost';

  @override
  String get fuelMpg => 'Miles per gallon (MPG, US)';

  @override
  String get pdfPickOne => 'Choose one or more images';

  @override
  String get pdfFitToImage => 'Page matches image size';

  @override
  String get pdfFitOff => 'Off — A4 page';

  @override
  String get pdfMargin => 'Margin';

  @override
  String get addImage => 'Add image';

  @override
  String get createPdf => 'Create PDF';

  @override
  String get pdfCreateFailed => 'Could not create the PDF';

  @override
  String get chooseImage => 'Choose image';

  @override
  String get chooseAnotherImage => 'Choose another image';

  @override
  String get imageOpenFailed => 'Could not open the image';

  @override
  String qualityLabel(int n) {
    return 'Quality: $n%';
  }

  @override
  String get qualityHint =>
      'Lower quality means a smaller file. 60–75% is usually unnoticeable.';

  @override
  String get longestSide => 'Longest side (pixels)';

  @override
  String get customSize => 'Or enter your own';

  @override
  String get rotateLeft => 'Left';

  @override
  String get rotateRight => 'Right';

  @override
  String get mirror => 'Mirror';

  @override
  String rotationLabel(int deg) {
    return 'Rotation: $deg°';
  }

  @override
  String get saveShare => 'Save / Share';

  @override
  String get pdfPickAtLeast2 => 'Choose at least 2 PDF files';

  @override
  String get addPdf => 'Add PDF';

  @override
  String get mergeAction => 'Merge';

  @override
  String filesSummary(int count, String size) {
    return '$count files • $size • drag to reorder';
  }

  @override
  String get fileReadFailed => 'Could not read the file';

  @override
  String get mergeFailed =>
      'Could not merge. A file may be damaged or password-protected';

  @override
  String get choosePdf => 'Choose PDF';

  @override
  String get chooseAnotherPdf => 'Choose another PDF';

  @override
  String pdfPagesSummary(int count, String size) {
    return '$count pages • $size';
  }

  @override
  String get splitModePages => 'Pages';

  @override
  String get splitModeEach => 'Each';

  @override
  String get splitModeEvery => 'Every N';

  @override
  String get pageSelectLabel => 'Pages to keep';

  @override
  String get pageSelectHint => 'For example: 1-3, 5, 8-10';

  @override
  String pageSelectHelper(int n) {
    return 'From 1 to $n';
  }

  @override
  String get pageSelectError => 'Invalid format or page number';

  @override
  String get pageSelectNote => 'One new PDF is made from the selected pages.';

  @override
  String get splitEachNote => 'Every page becomes a separate PDF file.';

  @override
  String get splitEveryLabel => 'Split every N pages';

  @override
  String get pagesSuffix => 'pages';

  @override
  String summaryOne(int n) {
    return '1 file, $n pages';
  }

  @override
  String summaryMany(int n) {
    return '$n files will be created';
  }

  @override
  String get splitAndShare => 'Split and share';

  @override
  String get splitInvalid => 'Invalid page selection';

  @override
  String splitTooMany(int max) {
    return 'Cannot create more than $max files at once. Choose a larger step';
  }

  @override
  String get splitFailed => 'Could not split the file';

  @override
  String get pdfOpenFailed =>
      'Could not open the PDF. It may be damaged or password-protected';

  @override
  String get t2pTitleLabel => 'Title (optional)';

  @override
  String fontSizeLabel(int n) {
    return 'Font size: $n';
  }
}
