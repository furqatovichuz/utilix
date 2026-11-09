import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class PercentTool extends StatelessWidget {
  const PercentTool({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return ToolScaffold(
      title: l.toolPercent,
      children: [
        _Block(
          title: l.pcOfTitle,
          labelA: l.pcPercentX,
          labelB: l.pcNumberY,
          suffixA: '%',
          compute: (l, a, b) => fmt(a / 100 * b, 4),
        ),
        const SizedBox(height: 16),
        _Block(
          title: l.pcWhatTitle,
          labelA: 'X',
          labelB: 'Y',
          compute: (l, a, b) => b == 0 ? '—' : '${fmt(a / b * 100, 4)} %',
        ),
        const SizedBox(height: 16),
        _Block(
          title: l.pcDiscountTitle,
          labelA: l.pcDiscount,
          labelB: l.pcOriginalPrice,
          suffixA: '%',
          compute: (l, a, b) => l.pcSaved(fmt(b * (1 - a / 100), 4), fmt(b * a / 100, 4)),
        ),
        const SizedBox(height: 16),
        _Block(
          title: l.pcChangeTitle,
          labelA: l.pcOld,
          labelB: l.pcNew,
          compute: (l, a, b) {
            if (a == 0) return '—';
            final c = (b - a) / a * 100;
            return '${c >= 0 ? '+' : ''}${fmt(c, 4)} %';
          },
        ),
      ],
    );
  }
}

class _Block extends StatefulWidget {
  const _Block({
    required this.title,
    required this.labelA,
    required this.labelB,
    required this.compute,
    this.suffixA,
  });

  final String title;
  final String labelA;
  final String labelB;
  final String? suffixA;
  final String Function(AppLocalizations l, double a, double b) compute;

  @override
  State<_Block> createState() => _BlockState();
}

class _BlockState extends State<_Block> {
  final _a = TextEditingController();
  final _b = TextEditingController();

  @override
  void dispose() {
    _a.dispose();
    _b.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final a = parseNum(_a.text);
    final b = parseNum(_b.text);
    final result = (a != null && b != null) ? widget.compute(l, a, b) : '—';
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: NumberField(
                    controller: _a,
                    label: widget.labelA,
                    suffix: widget.suffixA,
                    onChanged: () => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NumberField(
                    controller: _b,
                    label: widget.labelB,
                    onChanged: () => setState(() {}),
                  ),
                ),
              ],
            ),
            ResultCard(label: l.result, value: result),
          ],
        ),
      ),
    );
  }
}
