import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/l10n.dart';
import '../core/number_words.dart';
import '../core/widgets.dart';

class NumberWordsTool extends StatefulWidget {
  const NumberWordsTool({super.key});

  @override
  State<NumberWordsTool> createState() => _NumberWordsToolState();
}

class _NumberWordsToolState extends State<NumberWordsTool> {
  final _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final lang = Localizations.localeOf(context).languageCode;
    final n = int.tryParse(_input.text.replaceAll(' ', ''));
    final tooBig = n != null && n.abs() > maxNumberWords;
    final words = n == null || tooBig ? '—' : numberToWords(n, lang);
    return ToolScaffold(
      title: l.toolNumberWords,
      children: [
        TextField(
          controller: _input,
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[-0-9 ]'))],
          decoration: InputDecoration(labelText: l.nwInput),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        ResultCard(label: l.nwResult, value: words),
        if (tooBig)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(l.nwTooBig),
          ),
      ],
    );
  }
}
