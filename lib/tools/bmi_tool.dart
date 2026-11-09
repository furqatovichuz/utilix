import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class BmiTool extends StatefulWidget {
  const BmiTool({super.key});

  @override
  State<BmiTool> createState() => _BmiToolState();
}

class _BmiToolState extends State<BmiTool> {
  final _height = TextEditingController();
  final _weight = TextEditingController();

  @override
  void dispose() {
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  ({String label, Color color}) _category(AppLocalizations l, double bmi) {
    if (bmi < 16) return (label: l.bmiSevereUnder, color: Colors.red);
    if (bmi < 18.5) return (label: l.bmiUnder, color: Colors.orange);
    if (bmi < 25) return (label: l.bmiNormal, color: Colors.green);
    if (bmi < 30) return (label: l.bmiOver, color: Colors.orange);
    return (label: l.bmiObese, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final h = parseNum(_height.text);
    final w = parseNum(_weight.text);
    final valid = h != null && w != null && h > 50 && h < 280 && w > 5 && w < 500;
    final bmi = valid ? w / ((h / 100) * (h / 100)) : null;
    final cat = bmi == null ? null : _category(l, bmi);

    return ToolScaffold(
      title: l.toolBmi,
      children: [
        NumberField(
          controller: _height,
          label: l.heightLabel,
          suffix: l.unitCm,
          onChanged: () => setState(() {}),
        ),
        NumberField(
          controller: _weight,
          label: l.weightLabel,
          suffix: l.unitKg,
          onChanged: () => setState(() {}),
        ),
        const SizedBox(height: 8),
        ResultCard(label: l.bmiLabel, value: bmi == null ? '—' : fmt(bmi, 1)),
        if (cat != null) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.circle, size: 14, color: cat.color),
              const SizedBox(width: 8),
              Text(cat.label,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 4),
          Text(l.bmiHealthyRange(
            fmt(18.5 * (h! / 100) * (h / 100), 1),
            fmt(24.9 * (h / 100) * (h / 100), 1),
          )),
        ],
        const SizedBox(height: 16),
        Text(
          l.bmiDisclaimer,
          style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 12),
        ),
      ],
    );
  }
}
