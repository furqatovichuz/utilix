import 'package:flutter/material.dart';

import '../tools/bmi_tool.dart';
import '../tools/calculator_tool.dart';
import '../tools/color_tool.dart';
import '../tools/counter_tool.dart';
import '../tools/date_tool.dart';
import '../tools/flashlight_tool.dart';
import '../tools/fuel_tool.dart';
import '../tools/image_process_tool.dart';
import '../tools/images_to_pdf_tool.dart';
import '../tools/json_tool.dart';
import '../tools/level_tool.dart';
import '../tools/loan_tool.dart';
import '../tools/number_words_tool.dart';
import '../tools/password_tool.dart';
import '../tools/pdf_merge_tool.dart';
import '../tools/pdf_split_tool.dart';
import '../tools/percent_tool.dart';
import '../tools/qr_tool.dart';
import '../tools/radix_tool.dart';
import '../tools/random_tool.dart';
import '../tools/text_to_pdf_tool.dart';
import '../tools/text_tool.dart';
import '../tools/timer_tool.dart';
import '../tools/unit_tool.dart';
import '../tools/vat_tool.dart';
import 'tool.dart';

/// Barcha asboblar shu yerda ro'yxatdan o'tadi.
/// Yangi asbob qo'shish: ARB fayllarga nom/tavsif kiriting va shu ro'yxatga yozuv qo'shing.
final List<Tool> allTools = [
  Tool(
    id: 'calculator',
    name: (l) => l.toolCalculator,
    description: (l) => l.toolCalculatorDesc,
    icon: Icons.calculate_rounded,
    color: const Color(0xFF6C5CE7),
    category: ToolCategory.calculators,
    keywords: const ['calc', 'калькулятор', 'hisob', 'sin', 'cos'],
    builder: (_) => const CalculatorTool(),
  ),
  Tool(
    id: 'units',
    name: (l) => l.toolUnits,
    description: (l) => l.toolUnitsDesc,
    icon: Icons.straighten_rounded,
    color: const Color(0xFF00B894),
    category: ToolCategory.calculators,
    keywords: const ['convert', 'unit', 'конвертер', 'metr', 'kg', 'celsius'],
    builder: (_) => const UnitTool(),
  ),
  Tool(
    id: 'qr',
    name: (l) => l.toolQr,
    description: (l) => l.toolQrDesc,
    icon: Icons.qr_code_2_rounded,
    color: const Color(0xFF0984E3),
    category: ToolCategory.generators,
    keywords: const ['qr', 'code', 'link', 'url'],
    builder: (_) => const QrTool(),
  ),
  Tool(
    id: 'password',
    name: (l) => l.toolPassword,
    description: (l) => l.toolPasswordDesc,
    icon: Icons.password_rounded,
    color: const Color(0xFFD63031),
    category: ToolCategory.text,
    keywords: const ['password', 'пароль', 'parol', 'security'],
    builder: (_) => const PasswordTool(),
  ),
  Tool(
    id: 'bmi',
    name: (l) => l.toolBmi,
    description: (l) => l.toolBmiDesc,
    icon: Icons.monitor_weight_rounded,
    color: const Color(0xFFE17055),
    category: ToolCategory.calculators,
    keywords: const ['bmi', 'имт', 'weight', 'health', 'vazn'],
    builder: (_) => const BmiTool(),
  ),
  Tool(
    id: 'loan',
    name: (l) => l.toolLoan,
    description: (l) => l.toolLoanDesc,
    icon: Icons.account_balance_rounded,
    color: const Color(0xFF2D3436),
    category: ToolCategory.calculators,
    keywords: const ['loan', 'credit', 'кредит', 'kredit', 'bank', 'mortgage'],
    builder: (_) => const LoanTool(),
  ),
  Tool(
    id: 'timer',
    name: (l) => l.toolTimer,
    description: (l) => l.toolTimerDesc,
    icon: Icons.timer_rounded,
    color: const Color(0xFFFDCB6E),
    category: ToolCategory.life,
    keywords: const ['timer', 'stopwatch', 'таймер', 'секундомер'],
    builder: (_) => const TimerTool(),
  ),
  Tool(
    id: 'text',
    name: (l) => l.toolText,
    description: (l) => l.toolTextDesc,
    icon: Icons.text_snippet_rounded,
    color: const Color(0xFF00CEC9),
    category: ToolCategory.text,
    keywords: const ['text', 'base64', 'hash', 'sha', 'md5', 'текст'],
    builder: (_) => const TextTool(),
  ),
  Tool(
    id: 'color',
    name: (l) => l.toolColor,
    description: (l) => l.toolColorDesc,
    icon: Icons.palette_rounded,
    color: const Color(0xFFE84393),
    category: ToolCategory.generators,
    keywords: const ['color', 'colour', 'hex', 'rgb', 'цвет', 'rang'],
    builder: (_) => const ColorTool(),
  ),
  Tool(
    id: 'percent',
    name: (l) => l.toolPercent,
    description: (l) => l.toolPercentDesc,
    icon: Icons.percent_rounded,
    color: const Color(0xFFA29BFE),
    category: ToolCategory.calculators,
    keywords: const ['percent', 'discount', 'процент', 'скидка', 'chegirma'],
    builder: (_) => const PercentTool(),
  ),
  Tool(
    id: 'date',
    name: (l) => l.toolDate,
    description: (l) => l.toolDateDesc,
    icon: Icons.event_rounded,
    color: const Color(0xFF55EFC4),
    category: ToolCategory.life,
    keywords: const ['date', 'age', 'birthday', 'дата', 'возраст', 'yosh', 'sana'],
    builder: (_) => const DateTool(),
  ),
  Tool(
    id: 'random',
    name: (l) => l.toolRandom,
    description: (l) => l.toolRandomDesc,
    icon: Icons.casino_rounded,
    color: const Color(0xFFFF7675),
    category: ToolCategory.generators,
    keywords: const ['random', 'dice', 'coin', 'случайный', 'кубик', 'tanga', 'kubik'],
    builder: (_) => const RandomTool(),
  ),
  Tool(
    id: 'flashlight',
    name: (l) => l.toolFlashlight,
    description: (l) => l.toolFlashlightDesc,
    icon: Icons.flashlight_on_rounded,
    color: const Color(0xFFF9A825),
    category: ToolCategory.device,
    keywords: const ['flashlight', 'torch', 'фонарик', 'fonar', 'chiroq'],
    builder: (_) => const FlashlightTool(),
  ),
  Tool(
    id: 'level',
    name: (l) => l.toolLevel,
    description: (l) => l.toolLevelDesc,
    icon: Icons.architecture_rounded,
    color: const Color(0xFF00897B),
    category: ToolCategory.device,
    keywords: const ['level', 'spirit', 'уровень', 'vaterpas'],
    builder: (_) => const LevelTool(),
  ),
  Tool(
    id: 'number_words',
    name: (l) => l.toolNumberWords,
    description: (l) => l.toolNumberWordsDesc,
    icon: Icons.spellcheck_rounded,
    color: const Color(0xFF5F27CD),
    category: ToolCategory.text,
    keywords: const ['number', 'words', 'прописью', 'summa', 'propis'],
    builder: (_) => const NumberWordsTool(),
  ),
  Tool(
    id: 'vat',
    name: (l) => l.toolVat,
    description: (l) => l.toolVatDesc,
    icon: Icons.receipt_long_rounded,
    color: const Color(0xFF10AC84),
    category: ToolCategory.calculators,
    keywords: const ['vat', 'tax', 'ндс', 'кдв', 'qqs', 'kdv'],
    builder: (_) => const VatTool(),
  ),
  Tool(
    id: 'counter',
    name: (l) => l.toolCounter,
    description: (l) => l.toolCounterDesc,
    icon: Icons.touch_app_rounded,
    color: const Color(0xFF54A0FF),
    category: ToolCategory.life,
    keywords: const ['counter', 'tally', 'tasbeh', 'счётчик'],
    builder: (_) => const CounterTool(),
  ),
  Tool(
    id: 'json',
    name: (l) => l.toolJson,
    description: (l) => l.toolJsonDesc,
    icon: Icons.data_object_rounded,
    color: const Color(0xFF576574),
    category: ToolCategory.text,
    keywords: const ['json', 'format', 'api', 'developer'],
    builder: (_) => const JsonTool(),
  ),
  Tool(
    id: 'radix',
    name: (l) => l.toolRadix,
    description: (l) => l.toolRadixDesc,
    icon: Icons.memory_rounded,
    color: const Color(0xFF341F97),
    category: ToolCategory.calculators,
    keywords: const ['binary', 'hex', 'octal', 'bin', 'dec'],
    builder: (_) => const RadixTool(),
  ),
  Tool(
    id: 'fuel',
    name: (l) => l.toolFuel,
    description: (l) => l.toolFuelDesc,
    icon: Icons.local_gas_station_rounded,
    color: const Color(0xFFEE5A24),
    category: ToolCategory.life,
    keywords: const ['fuel', 'gas', 'car', 'топливо', 'бензин', 'benzin', 'metan'],
    builder: (_) => const FuelTool(),
  ),
  Tool(
    id: 'images_to_pdf',
    name: (l) => l.toolImagesToPdf,
    description: (l) => l.toolImagesToPdfDesc,
    icon: Icons.picture_as_pdf_rounded,
    color: const Color(0xFFE53935),
    category: ToolCategory.files,
    keywords: const ['pdf', 'image', 'jpg', 'png', 'scan', 'изображение'],
    builder: (_) => const ImagesToPdfTool(),
  ),
  Tool(
    id: 'pdf_merge',
    name: (l) => l.toolPdfMerge,
    description: (l) => l.toolPdfMergeDesc,
    icon: Icons.merge_type_rounded,
    color: const Color(0xFFD84315),
    category: ToolCategory.files,
    keywords: const ['pdf', 'merge', 'combine', 'объединить'],
    builder: (_) => const PdfMergeTool(),
  ),
  Tool(
    id: 'pdf_split',
    name: (l) => l.toolPdfSplit,
    description: (l) => l.toolPdfSplitDesc,
    icon: Icons.call_split_rounded,
    color: const Color(0xFFBF360C),
    category: ToolCategory.files,
    keywords: const ['pdf', 'split', 'extract', 'pages', 'разделить'],
    builder: (_) => const PdfSplitTool(),
  ),
  Tool(
    id: 'text_to_pdf',
    name: (l) => l.toolTextToPdf,
    description: (l) => l.toolTextToPdfDesc,
    icon: Icons.description_rounded,
    color: const Color(0xFFC62828),
    category: ToolCategory.files,
    keywords: const ['pdf', 'text', 'document'],
    builder: (_) => const TextToPdfTool(),
  ),
  Tool(
    id: 'image_compress',
    name: (l) => l.toolImageCompress,
    description: (l) => l.toolImageCompressDesc,
    icon: Icons.compress_rounded,
    color: const Color(0xFF1E88E5),
    category: ToolCategory.files,
    keywords: const ['compress', 'image', 'photo', 'jpg', 'сжать'],
    builder: (_) => const ImageProcessTool(mode: ImageMode.compress),
  ),
  Tool(
    id: 'image_resize',
    name: (l) => l.toolImageResize,
    description: (l) => l.toolImageResizeDesc,
    icon: Icons.photo_size_select_large_rounded,
    color: const Color(0xFF3949AB),
    category: ToolCategory.files,
    keywords: const ['resize', 'image', 'size', 'pixel', 'размер'],
    builder: (_) => const ImageProcessTool(mode: ImageMode.resize),
  ),
  Tool(
    id: 'image_convert',
    name: (l) => l.toolImageConvert,
    description: (l) => l.toolImageConvertDesc,
    icon: Icons.transform_rounded,
    color: const Color(0xFF8E24AA),
    category: ToolCategory.files,
    keywords: const ['png', 'jpg', 'convert', 'rotate', 'flip', 'format', 'повернуть'],
    builder: (_) => const ImageProcessTool(mode: ImageMode.convert),
  ),
];
