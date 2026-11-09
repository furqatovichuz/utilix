import 'dart:math';

import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class LoanTool extends StatefulWidget {
  const LoanTool({super.key});

  @override
  State<LoanTool> createState() => _LoanToolState();
}

class _LoanToolState extends State<LoanTool> {
  final _amount = TextEditingController();
  final _rate = TextEditingController(text: '20');
  final _months = TextEditingController(text: '12');
  bool _annuity = true;

  @override
  void dispose() {
    _amount.dispose();
    _rate.dispose();
    _months.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = parseNum(_amount.text);
    final r = parseNum(_rate.text);
    final n = int.tryParse(_months.text.trim());
    final valid = p != null && r != null && n != null && p > 0 && r >= 0 && n > 0 && n <= 600;

    String monthly = '—';
    String total = '—';
    String overpay = '—';
    if (valid) {
      final m = r / 100 / 12;
      double sum;
      if (_annuity) {
        final pay = m == 0 ? p / n : p * m * pow(1 + m, n) / (pow(1 + m, n) - 1);
        monthly = fmt(pay);
        sum = pay * n;
      } else {
        final first = p / n + p * m;
        final last = p / n + (p / n) * m;
        monthly = '${fmt(first)} → ${fmt(last)}';
        sum = p + p * m * (n + 1) / 2;
      }
      total = fmt(sum);
      overpay = fmt(sum - p);
    }

    return ToolScaffold(
      title: l.toolLoan,
      children: [
        NumberField(controller: _amount, label: l.loanAmount, onChanged: () => setState(() {})),
        NumberField(
          controller: _rate,
          label: l.loanRate,
          suffix: '%',
          onChanged: () => setState(() {}),
        ),
        NumberField(
          controller: _months,
          label: l.loanTerm,
          suffix: l.unitMonths,
          onChanged: () => setState(() {}),
        ),
        SegmentedButton<bool>(
          segments: [
            ButtonSegment(value: true, label: Text(l.loanAnnuity)),
            ButtonSegment(value: false, label: Text(l.loanDifferential)),
          ],
          selected: {_annuity},
          onSelectionChanged: (s) => setState(() => _annuity = s.first),
        ),
        const SizedBox(height: 16),
        ResultCard(label: l.loanMonthly, value: monthly),
        const SizedBox(height: 8),
        ResultCard(label: l.loanTotal, value: total),
        const SizedBox(height: 8),
        ResultCard(label: l.loanOverpay, value: overpay),
      ],
    );
  }
}
