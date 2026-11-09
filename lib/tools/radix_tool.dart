import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class RadixTool extends StatefulWidget {
  const RadixTool({super.key});

  @override
  State<RadixTool> createState() => _RadixToolState();
}

class _RadixToolState extends State<RadixTool> {
  final _input = TextEditingController(text: '255');
  int _base = 10;

  static const _names = {2: 'BIN (2)', 8: 'OCT (8)', 10: 'DEC (10)', 16: 'HEX (16)'};

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final text = _input.text.trim();
    final value = text.isEmpty ? null : BigInt.tryParse(text, radix: _base);
    return ToolScaffold(
      title: l.toolRadix,
      children: [
        SegmentedButton<int>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: 2, label: Text('BIN')),
            ButtonSegment(value: 8, label: Text('OCT')),
            ButtonSegment(value: 10, label: Text('DEC')),
            ButtonSegment(value: 16, label: Text('HEX')),
          ],
          selected: {_base},
          onSelectionChanged: (s) => setState(() {
            // Qiymatni yangi tizimga o'tkazib ko'rsatamiz.
            if (value != null) _input.text = value.toRadixString(s.first).toUpperCase();
            _base = s.first;
          }),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _input,
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            labelText: l.radixValueLabel(_names[_base]!),
            errorText: text.isNotEmpty && value == null ? l.radixInvalid : null,
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        for (final entry in _names.entries) ...[
          ResultCard(
            label: entry.value,
            value: value == null ? '—' : value.toRadixString(entry.key).toUpperCase(),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
