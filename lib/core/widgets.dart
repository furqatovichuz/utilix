import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'l10n.dart';

/// Nusxa olish va snackbar ko'rsatish.
void copyText(BuildContext context, String text, {String? message}) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(message ?? context.l10n.copied),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
    ));
}

/// Asbob ekrani uchun umumiy ramka.
class ToolScaffold extends StatelessWidget {
  const ToolScaffold({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: children,
          ),
        ),
      );
}

/// Natija ko'rsatuvchi katta karta.
class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required this.label,
    required this.value,
    this.copyable = true,
  });

  final String label;
  final String value;
  final bool copyable;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.primaryContainer,
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: copyable ? () => copyText(context, value) : null,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      color: scheme.onPrimaryContainer.withValues(alpha: .7))),
              const SizedBox(height: 4),
              SelectableText(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: scheme.onPrimaryContainer,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Raqam kiritish maydoni.
class NumberField extends StatelessWidget {
  const NumberField({
    super.key,
    required this.controller,
    required this.label,
    this.suffix,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String? suffix;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
          ],
          decoration: InputDecoration(labelText: label, suffixText: suffix),
          onChanged: (_) => onChanged?.call(),
        ),
      );
}

double? parseNum(String s) => double.tryParse(s.replaceAll(',', '.').trim());

String fmt(num v, [int digits = 2]) {
  if (v.isNaN || v.isInfinite) return '—';
  final s = v.toStringAsFixed(digits);
  final trimmed = s.contains('.')
      ? s.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '')
      : s;
  final parts = trimmed.split('.');
  final intPart = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ' ');
  return parts.length > 1 ? '$intPart.${parts[1]}' : intPart;
}
