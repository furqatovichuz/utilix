import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class CalculatorTool extends StatefulWidget {
  const CalculatorTool({super.key});

  @override
  State<CalculatorTool> createState() => _CalculatorToolState();
}

class _CalculatorToolState extends State<CalculatorTool> {
  String _expr = '';
  String _result = '';

  static const _keys = [
    ['C', '(', ')', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '−'],
    ['1', '2', '3', '+'],
    ['⌫', '0', '.', '='],
  ];

  String? _evaluate(String expr) {
    if (expr.isEmpty) return null;
    try {
      final normalized = expr
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-');
      final exp = GrammarParser().parse(normalized);
      final num value = RealEvaluator().evaluate(exp);
      if (value.isNaN || value.isInfinite) return null;
      return fmt(value, 8);
    } catch (_) {
      return null;
    }
  }

  void _press(String k) {
    setState(() {
      switch (k) {
        case 'C':
          _expr = '';
          _result = '';
        case '⌫':
          if (_expr.isNotEmpty) _expr = _expr.substring(0, _expr.length - 1);
          _result = _evaluate(_expr) ?? '';
        case '=':
          final r = _evaluate(_expr);
          if (r != null) {
            _expr = r.replaceAll(' ', '');
            _result = '';
          }
        default:
          _expr += k;
          _result = _evaluate(_expr) ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.toolCalculator)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onLongPress: _expr.isEmpty ? null : () => copyText(context, _expr),
                      child: Text(
                        _expr.isEmpty ? '0' : _expr,
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _result.isEmpty ? ' ' : '= $_result',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: scheme.primary),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  for (final row in _keys)
                    Row(
                      children: [
                        for (final k in row)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: _Key(label: k, onTap: () => _press(k)),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Key extends StatelessWidget {
  const _Key({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isOp = '÷×−+'.contains(label);
    final isEq = label == '=';
    final isUtil = label == 'C' || label == '⌫' || label == '(' || label == ')';
    final bg = isEq
        ? scheme.primary
        : isOp
            ? scheme.primaryContainer
            : isUtil
                ? scheme.secondaryContainer
                : scheme.surfaceContainerHighest;
    final fg = isEq ? scheme.onPrimary : scheme.onSurface;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Center(
            child: Text(label,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: fg)),
          ),
        ),
      ),
    );
  }
}
