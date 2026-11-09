import 'package:flutter/material.dart';

import 'l10n.dart';

enum ToolCategory {
  calculators(Icons.calculate_rounded, Color(0xFF5B4BD6)),
  files(Icons.picture_as_pdf_rounded, Color(0xFFE5484D)),
  text(Icons.text_fields_rounded, Color(0xFF0E9F8E)),
  generators(Icons.auto_awesome_rounded, Color(0xFFF08A24)),
  life(Icons.home_rounded, Color(0xFF2E7CF6)),
  device(Icons.smartphone_rounded, Color(0xFF8E5BD9));

  const ToolCategory(this.icon, this.color);
  final IconData icon;
  final Color color;

  String label(AppLocalizations l) => switch (this) {
        calculators => l.catCalculators,
        files => l.catFiles,
        text => l.catText,
        generators => l.catGenerators,
        life => l.catLife,
        device => l.catDevice,
      };
}

class Tool {
  const Tool({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.category,
    required this.builder,
    this.keywords = const [],
  });

  final String id;
  final String Function(AppLocalizations l) name;
  final String Function(AppLocalizations l) description;
  final IconData icon;
  final Color color;
  final ToolCategory category;
  final WidgetBuilder builder;

  /// Tilga bog'liq bo'lmagan qo'shimcha qidiruv so'zlari (ingliz, rus, o'zbek).
  final List<String> keywords;

  bool matches(AppLocalizations l, String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return name(l).toLowerCase().contains(q) ||
        description(l).toLowerCase().contains(q) ||
        keywords.any((k) => k.toLowerCase().contains(q));
  }
}
