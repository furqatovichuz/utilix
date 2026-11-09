// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTagline => 'Все нужные инструменты в одном приложении';

  @override
  String get copied => 'Скопировано';

  @override
  String get copy => 'Копировать';

  @override
  String get clear => 'Очистить';

  @override
  String get paste => 'Вставить';

  @override
  String get result => 'Результат';

  @override
  String get apply => 'Применить';

  @override
  String get share => 'Поделиться';

  @override
  String homeSubtitle(int count) {
    return 'Инструментов в приложении: $count';
  }

  @override
  String get searchHint => 'Поиск инструментов...';

  @override
  String get filterAll => 'Все';

  @override
  String get sectionRecent => 'Недавние';

  @override
  String get sectionFavorites => 'Избранное';

  @override
  String get sectionAllTools => 'Все инструменты';

  @override
  String get sectionResults => 'Результаты';

  @override
  String get nothingFound => 'Ничего не найдено';

  @override
  String get themeTooltip => 'Тема';

  @override
  String get languageTooltip => 'Язык';

  @override
  String get catCalculators => 'Калькуляторы';

  @override
  String get catConverters => 'Конвертеры';

  @override
  String get catText => 'Текст и безопасность';

  @override
  String get catGenerators => 'Генераторы';

  @override
  String get catTime => 'Время';

  @override
  String get catDesign => 'Дизайн';

  @override
  String get catFiles => 'PDF и изображения';

  @override
  String get catLife => 'Повседневное';

  @override
  String get catDevice => 'Устройство';

  @override
  String get toolCalculator => 'Калькулятор';

  @override
  String get toolCalculatorDesc => 'Выражения, скобки и функции';

  @override
  String get toolUnits => 'Конвертер величин';

  @override
  String get toolUnitsDesc => 'Длина, вес, температура, объём...';

  @override
  String get toolQr => 'Генератор QR';

  @override
  String get toolQrDesc => 'QR-код из текста или ссылки';

  @override
  String get toolPassword => 'Генератор паролей';

  @override
  String get toolPasswordDesc => 'Надёжные и безопасные пароли';

  @override
  String get toolBmi => 'Калькулятор ИМТ';

  @override
  String get toolBmiDesc => 'Индекс массы тела';

  @override
  String get toolLoan => 'Кредитный калькулятор';

  @override
  String get toolLoanDesc => 'Ежемесячный платёж и переплата';

  @override
  String get toolTimer => 'Таймер и секундомер';

  @override
  String get toolTimerDesc => 'Обратный отсчёт и круги';

  @override
  String get toolText => 'Работа с текстом';

  @override
  String get toolTextDesc => 'Счётчик, регистр, Base64, SHA-256';

  @override
  String get toolColor => 'Выбор цвета';

  @override
  String get toolColorDesc => 'Перевод RGB, HEX и HSL';

  @override
  String get toolPercent => 'Калькулятор процентов';

  @override
  String get toolPercentDesc => 'Проценты, скидки и изменение';

  @override
  String get toolDate => 'Даты и возраст';

  @override
  String get toolDateDesc => 'Разница дат и дни до годовщины';

  @override
  String get toolRandom => 'Случайный выбор';

  @override
  String get toolRandomDesc => 'Число, монета, кубик, выбор из списка';

  @override
  String get toolFlashlight => 'Фонарик';

  @override
  String get toolFlashlightDesc => 'Включить подсветку телефона';

  @override
  String get toolLevel => 'Уровень';

  @override
  String get toolLevelDesc => 'Проверка ровности поверхности';

  @override
  String get toolNumberWords => 'Число прописью';

  @override
  String get toolNumberWordsDesc => 'Записать число словами';

  @override
  String get toolVat => 'Калькулятор НДС';

  @override
  String get toolVatDesc => 'Добавить или выделить НДС';

  @override
  String get toolCounter => 'Счётчик';

  @override
  String get toolCounterDesc => 'Быстрый подсчёт нажатием';

  @override
  String get toolJson => 'Форматтер JSON';

  @override
  String get toolJsonDesc => 'Проверка, форматирование, сжатие';

  @override
  String get toolRadix => 'Системы счисления';

  @override
  String get toolRadixDesc => 'Перевод BIN, OCT, DEC, HEX';

  @override
  String get toolFuel => 'Расход топлива';

  @override
  String get toolFuelDesc => 'На 100 км и стоимость поездки';

  @override
  String get toolImagesToPdf => 'Изображения в PDF';

  @override
  String get toolImagesToPdfDesc => 'Один PDF из нескольких изображений';

  @override
  String get toolTextToPdf => 'Текст в PDF';

  @override
  String get toolTextToPdfDesc => 'Создать PDF-файл из текста';

  @override
  String get toolPdfMerge => 'Объединение PDF';

  @override
  String get toolPdfMergeDesc => 'Склеить несколько PDF в один';

  @override
  String get toolPdfSplit => 'Разделение PDF';

  @override
  String get toolPdfSplitDesc => 'Извлечь или разделить страницы';

  @override
  String get toolImageCompress => 'Сжатие изображения';

  @override
  String get toolImageCompressDesc => 'Уменьшить размер файла';

  @override
  String get toolImageResize => 'Размер изображения';

  @override
  String get toolImageResizeDesc => 'Изменить размер в пикселях';

  @override
  String get toolImageConvert => 'Формат и поворот';

  @override
  String get toolImageConvertDesc => 'PNG ↔ JPG, поворот, зеркало';

  @override
  String get unitGroupLength => 'Длина';

  @override
  String get unitGroupMass => 'Вес';

  @override
  String get unitGroupVolume => 'Объём';

  @override
  String get unitGroupArea => 'Площадь';

  @override
  String get unitGroupSpeed => 'Скорость';

  @override
  String get unitGroupData => 'Данные';

  @override
  String get unitGroupTemp => 'Температура';

  @override
  String get valueLabel => 'Значение';

  @override
  String get fromUnit => 'Из';

  @override
  String get toUnit => 'В';

  @override
  String get qrInputLabel => 'Текст или ссылка';

  @override
  String get qrEnterText => 'Введите текст';

  @override
  String get qrCopyText => 'Копировать текст';

  @override
  String get pwLabel => 'Пароль (нажмите, чтобы скопировать)';

  @override
  String pwStrength(String level) {
    return 'Надёжность: $level';
  }

  @override
  String get pwWeak => 'Слабый';

  @override
  String get pwMedium => 'Средний';

  @override
  String get pwStrong => 'Надёжный';

  @override
  String get pwVeryStrong => 'Очень надёжный';

  @override
  String pwLength(int n) {
    return 'Длина: $n';
  }

  @override
  String get pwUpper => 'Заглавные буквы (A–Z)';

  @override
  String get pwDigits => 'Цифры (0–9)';

  @override
  String get pwSymbols => 'Символы (!@#...)';

  @override
  String get pwNew => 'Новый пароль';

  @override
  String get heightLabel => 'Рост';

  @override
  String get weightLabel => 'Вес';

  @override
  String get unitCm => 'см';

  @override
  String get unitKg => 'кг';

  @override
  String get bmiLabel => 'ИМТ';

  @override
  String get bmiSevereUnder => 'Выраженный дефицит массы';

  @override
  String get bmiUnder => 'Дефицит массы';

  @override
  String get bmiNormal => 'Норма';

  @override
  String get bmiOver => 'Избыточная масса';

  @override
  String get bmiObese => 'Ожирение';

  @override
  String bmiHealthyRange(String min, String max) {
    return 'Здоровый диапазон веса: $min–$max кг';
  }

  @override
  String get bmiDisclaimer =>
      'Это приблизительный показатель, а не медицинский диагноз.';

  @override
  String get loanAmount => 'Сумма кредита';

  @override
  String get loanRate => 'Годовая ставка';

  @override
  String get loanTerm => 'Срок';

  @override
  String get unitMonths => 'мес.';

  @override
  String get loanAnnuity => 'Аннуитетный';

  @override
  String get loanDifferential => 'Дифференцированный';

  @override
  String get loanMonthly => 'Ежемесячный платёж';

  @override
  String get loanTotal => 'Общая выплата';

  @override
  String get loanOverpay => 'Переплата';

  @override
  String get stopwatchTab => 'Секундомер';

  @override
  String get timerTab => 'Таймер';

  @override
  String get lap => 'Круг';

  @override
  String get resetAll => 'Сбросить';

  @override
  String get start => 'Старт';

  @override
  String get stop => 'Стоп';

  @override
  String get restart => 'Заново';

  @override
  String get timeIsUp => 'Время вышло!';

  @override
  String timerMinutes(int n) {
    return '$n мин';
  }

  @override
  String get timerCustom => 'Выбрать своё время';

  @override
  String get timerPickerHelp => 'Часы : минуты';

  @override
  String get textLabel => 'Текст';

  @override
  String get statChars => 'Символов';

  @override
  String get statWords => 'Слов';

  @override
  String get statLines => 'Строк';

  @override
  String get statBytes => 'Байт';

  @override
  String get sectionCase => 'Регистр';

  @override
  String get caseUpper => 'ВЕРХНИЙ';

  @override
  String get caseLower => 'нижний';

  @override
  String get caseTitle => 'Каждое Слово';

  @override
  String get trimSpaces => 'Убрать лишние пробелы';

  @override
  String get reverseText => 'Наоборот';

  @override
  String get sectionEncoding => 'Кодирование';

  @override
  String get b64Encode => 'Base64: кодировать';

  @override
  String get b64Decode => 'Base64: декодировать';

  @override
  String get urlEncode => 'URL: кодировать';

  @override
  String get urlDecode => 'URL: декодировать';

  @override
  String get sectionHash => 'Хеш';

  @override
  String get hashHint => 'Введите текст, чтобы увидеть хеши';

  @override
  String get textOpError => 'Не удалось применить (неверный формат)';

  @override
  String get pcOfTitle => 'Сколько составляет X% от Y?';

  @override
  String get pcPercentX => 'Процент (X)';

  @override
  String get pcNumberY => 'Число (Y)';

  @override
  String get pcWhatTitle => 'Сколько процентов составляет X от Y?';

  @override
  String get pcDiscountTitle => 'Цена со скидкой';

  @override
  String get pcDiscount => 'Скидка';

  @override
  String get pcOriginalPrice => 'Исходная цена';

  @override
  String pcSaved(String price, String saved) {
    return '$price  (экономия: $saved)';
  }

  @override
  String get pcChangeTitle => 'На сколько процентов изменилось значение?';

  @override
  String get pcOld => 'Старое значение';

  @override
  String get pcNew => 'Новое значение';

  @override
  String get dateStart => 'Начальная дата (день рождения)';

  @override
  String get dateEnd => 'Конечная дата';

  @override
  String get dateEndToday => 'Конечная дата — сегодня';

  @override
  String get dateDifference => 'Разница';

  @override
  String dateYmd(int y, int m, int d) {
    return '$y г. $m мес. $d дн.';
  }

  @override
  String get dateTotalDays => 'Всего дней';

  @override
  String dateWeeksHours(String weeks, String hours) {
    return '$weeks нед.  •  $hours ч';
  }

  @override
  String dateNextAnniversary(String date) {
    return 'До следующей годовщины ($date)';
  }

  @override
  String get dateToday => 'Сегодня!';

  @override
  String dateDays(int n) {
    return '$n дн.';
  }

  @override
  String get rndNumber => 'Число';

  @override
  String get rndCoin => 'Монета';

  @override
  String get rndDice => 'Кубик';

  @override
  String get rndPick => 'Выбор';

  @override
  String get rndFrom => 'От';

  @override
  String get rndTo => 'До';

  @override
  String get rndDiceCount => 'Количество кубиков:';

  @override
  String get rndListHint => 'Напишите по одному варианту в строке';

  @override
  String get rndRoll => 'Выбрать случайно';

  @override
  String get rndInvalidRange => 'Неверный диапазон';

  @override
  String get rndListEmpty => 'Список пуст';

  @override
  String get rndHeads => 'Орёл 🪙';

  @override
  String get rndTails => 'Решка 🪙';

  @override
  String get flashOn => 'Включён';

  @override
  String get flashOff => 'Выключен';

  @override
  String get flashError => 'Фонарик недоступен или камера занята';

  @override
  String get levelNoSensor => 'На устройстве нет акселерометра';

  @override
  String get levelFlat => 'Ровно ✓';

  @override
  String get levelHint => 'Положите телефон на ровную поверхность';

  @override
  String get nwInput => 'Число (например, 1250300)';

  @override
  String get nwResult => 'Прописью';

  @override
  String get nwTooBig => 'Число должно быть меньше 1 000 триллионов';

  @override
  String get vatAdd => 'Добавить НДС';

  @override
  String get vatExtract => 'Выделить НДС';

  @override
  String get vatNetInput => 'Сумма без НДС';

  @override
  String get vatGrossInput => 'Сумма с НДС';

  @override
  String get vatRate => 'Ставка НДС';

  @override
  String get vatNet => 'Сумма без НДС';

  @override
  String get vatAmount => 'Сумма НДС';

  @override
  String get vatGross => 'Сумма с НДС';

  @override
  String get counterReset => 'Обнулить';

  @override
  String get counterHint => 'Нажмите в любом месте экрана';

  @override
  String counterSubtract(int n) {
    return 'Вычесть ($n)';
  }

  @override
  String get jsonPretty => 'Форматировать';

  @override
  String get jsonMinify => 'Сжать';

  @override
  String get jsonValid => 'JSON корректен ✓';

  @override
  String jsonError(String message) {
    return 'Ошибка: $message';
  }

  @override
  String jsonErrorAt(String message, int pos) {
    return 'Ошибка: $message (символ $pos)';
  }

  @override
  String radixValueLabel(String name) {
    return 'Значение ($name)';
  }

  @override
  String get radixInvalid => 'Недопустимый символ для этой системы';

  @override
  String get fuelDistance => 'Пройденное расстояние';

  @override
  String get fuelUsed => 'Израсходовано топлива';

  @override
  String get fuelPrice => 'Цена за литр (необязательно)';

  @override
  String get unitKm => 'км';

  @override
  String get unitLiter => 'л';

  @override
  String get fuelPer100 => 'Расход на 100 км';

  @override
  String get fuelPerKm => 'Стоимость 1 км';

  @override
  String get fuelTotal => 'Общие затраты';

  @override
  String get fuelMpg => 'Мили на галлон (MPG, США)';

  @override
  String get pdfPickOne => 'Выберите одно или несколько изображений';

  @override
  String get pdfFitToImage => 'Страница по размеру изображения';

  @override
  String get pdfFitOff => 'Выкл. — страница A4';

  @override
  String get pdfMargin => 'Поля';

  @override
  String get addImage => 'Добавить изображение';

  @override
  String get createPdf => 'Создать PDF';

  @override
  String get pdfCreateFailed => 'Не удалось создать PDF';

  @override
  String get chooseImage => 'Выбрать изображение';

  @override
  String get chooseAnotherImage => 'Выбрать другое изображение';

  @override
  String get imageOpenFailed => 'Не удалось открыть изображение';

  @override
  String qualityLabel(int n) {
    return 'Качество: $n%';
  }

  @override
  String get qualityHint =>
      'Ниже качество — меньше файл. 60–75% обычно незаметно.';

  @override
  String get longestSide => 'Длинная сторона (пиксели)';

  @override
  String get customSize => 'Или введите своё значение';

  @override
  String get rotateLeft => 'Влево';

  @override
  String get rotateRight => 'Вправо';

  @override
  String get mirror => 'Зеркало';

  @override
  String rotationLabel(int deg) {
    return 'Поворот: $deg°';
  }

  @override
  String get saveShare => 'Сохранить / Поделиться';

  @override
  String get pdfPickAtLeast2 => 'Выберите не менее 2 PDF-файлов';

  @override
  String get addPdf => 'Добавить PDF';

  @override
  String get mergeAction => 'Объединить';

  @override
  String filesSummary(int count, String size) {
    return 'Файлов: $count • $size • перетащите, чтобы изменить порядок';
  }

  @override
  String get fileReadFailed => 'Не удалось прочитать файл';

  @override
  String get mergeFailed =>
      'Не удалось объединить. Файл повреждён или защищён паролем';

  @override
  String get choosePdf => 'Выбрать PDF';

  @override
  String get chooseAnotherPdf => 'Выбрать другой PDF';

  @override
  String pdfPagesSummary(int count, String size) {
    return 'Страниц: $count • $size';
  }

  @override
  String get splitModePages => 'Страницы';

  @override
  String get splitModeEach => 'Каждая';

  @override
  String get splitModeEvery => 'Каждые N';

  @override
  String get pageSelectLabel => 'Какие страницы оставить';

  @override
  String get pageSelectHint => 'Например: 1-3, 5, 8-10';

  @override
  String pageSelectHelper(int n) {
    return 'От 1 до $n';
  }

  @override
  String get pageSelectError => 'Неверный формат или номер страницы';

  @override
  String get pageSelectNote => 'Из выбранных страниц будет создан один PDF.';

  @override
  String get splitEachNote => 'Каждая страница станет отдельным PDF-файлом.';

  @override
  String get splitEveryLabel => 'Делить каждые N страниц';

  @override
  String get pagesSuffix => 'стр.';

  @override
  String summaryOne(int n) {
    return '1 файл, страниц: $n';
  }

  @override
  String summaryMany(int n) {
    return 'Будет создано файлов: $n';
  }

  @override
  String get splitAndShare => 'Разделить и поделиться';

  @override
  String get splitInvalid => 'Неверный выбор страниц';

  @override
  String splitTooMany(int max) {
    return 'Нельзя создать более $max файлов за раз. Выберите больший шаг';
  }

  @override
  String get splitFailed => 'Не удалось разделить файл';

  @override
  String get pdfOpenFailed =>
      'Не удалось открыть PDF. Он повреждён или защищён паролем';

  @override
  String get t2pTitleLabel => 'Заголовок (необязательно)';

  @override
  String fontSizeLabel(int n) {
    return 'Размер шрифта: $n';
  }
}
