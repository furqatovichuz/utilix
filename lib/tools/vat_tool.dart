import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class VatTool extends StatefulWidget {
  const VatTool({super.key});

  @override
  State<VatTool> createState() => _VatToolState();
}

class _VatToolState extends State<VatTool> {
  final _amount = TextEditingController();
  final _rate = TextEditingController(text: '12');
  bool _addVat = true;

  @override
  void dispose() {
    _amount.dispose();
    _rate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final a = parseNum(_amount.text);
    final r = parseNum(_rate.text);
    String net = '—', vat = '—', gross = '—';
    if (a != null && r != null && r >= 0) {
      if (_addVat) {
        net = fmt(a);
        vat = fmt(a * r / 100);
        gross = fmt(a * (1 + r / 100));
      } else {
        final n = a / (1 + r / 100);
        net = fmt(n);
        vat = fmt(a - n);
        gross = fmt(a);
      }
    }
    return ToolScaffold(
      title: l.toolVat,
      children: [
        SegmentedButton<bool>(
          segments: [
            ButtonSegment(value: true, label: Text(l.vatAdd)),
            ButtonSegment(value: false, label: Text(l.vatExtract)),
          ],
          selected: {_addVat},
          onSelectionChanged: (s) => setState(() => _addVat = s.first),
        ),
        const SizedBox(height: 16),
        NumberField(
          controller: _amount,
          label: _addVat ? l.vatNetInput : l.vatGrossInput,
          onChanged: () => setState(() {}),
        ),
        NumberField(
          controller: _rate,
          label: l.vatRate,
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        const SizedBox(height: 8),
        ResultCard(label: l.vatNet, value: net),
        const SizedBox(height: 8),
        ResultCard(label: l.vatAmount, value: vat),
        const SizedBox(height: 8),
        ResultCard(label: l.vatGross, value: gross),
      ],
    );
  }
}
