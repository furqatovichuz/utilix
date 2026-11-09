import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class JsonTool extends StatefulWidget {
  const JsonTool({super.key});

  @override
  State<JsonTool> createState() => _JsonToolState();
}

class _JsonToolState extends State<JsonTool> {
  final _input = TextEditingController();
  /// Holatni ko'rsatish uchun ekran tilida matn yasovchi funksiya.
  String Function(AppLocalizations l)? _status;
  bool _ok = true;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _run(String Function(Object?) render) {
    try {
      final decoded = jsonDecode(_input.text);
      _input.text = render(decoded);
      setState(() {
        _status = (l) => l.jsonValid;
        _ok = true;
      });
    } on FormatException catch (e) {
      setState(() {
        final pos = e.offset;
        _status = (l) => pos == null ? l.jsonError(e.message) : l.jsonErrorAt(e.message, pos);
        _ok = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l = context.l10n;
    return ToolScaffold(
      title: l.toolJson,
      children: [
        TextField(
          controller: _input,
          minLines: 10,
          maxLines: 16,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
          decoration: const InputDecoration(labelText: 'JSON'),
          onChanged: (_) => setState(() => _status = null),
        ),
        if (_status != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(_status!(l), style: TextStyle(color: _ok ? Colors.green : scheme.error)),
          ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () => _run((d) => const JsonEncoder.withIndent('  ').convert(d)),
                child: Text(l.jsonPretty),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.tonal(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                onPressed: () => _run(jsonEncode),
                child: Text(l.jsonMinify),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _input.text.isEmpty ? null : () => copyText(context, _input.text),
                icon: const Icon(Icons.copy_rounded),
                label: Text(l.copy),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  final data = await Clipboard.getData(Clipboard.kTextPlain);
                  if (data?.text != null) setState(() => _input.text = data!.text!);
                },
                icon: const Icon(Icons.paste_rounded),
                label: Text(l.paste),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
