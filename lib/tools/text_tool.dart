import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class TextTool extends StatefulWidget {
  const TextTool({super.key});

  @override
  State<TextTool> createState() => _TextToolState();
}

class _TextToolState extends State<TextTool> {
  final _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _apply(String Function(String) fn) {
    try {
      final out = fn(_input.text);
      setState(() => _input.text = out);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(context.l10n.textOpError),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  String _title(String s) => s
      .split(' ')
      .map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1).toLowerCase())
      .join(' ');

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final text = _input.text;
    final words = text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
    final lines = text.isEmpty ? 0 : text.split('\n').length;
    final bytes = utf8.encode(text);

    return ToolScaffold(
      title: l.toolText,
      children: [
        TextField(
          controller: _input,
          minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(labelText: l.textLabel),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _Stat(l.statChars, '${text.characters.length}'),
            _Stat(l.statWords, '$words'),
            _Stat(l.statLines, '$lines'),
            _Stat(l.statBytes, '${bytes.length}'),
          ],
        ),
        const SizedBox(height: 16),
        Text(l.sectionCase, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ActionChip(label: Text(l.caseUpper), onPressed: () => _apply((s) => s.toUpperCase())),
            ActionChip(label: Text(l.caseLower), onPressed: () => _apply((s) => s.toLowerCase())),
            ActionChip(label: Text(l.caseTitle), onPressed: () => _apply(_title)),
            ActionChip(
              label: Text(l.trimSpaces),
              onPressed: () => _apply((s) => s.replaceAll(RegExp(r'[ \t]+'), ' ').trim()),
            ),
            ActionChip(
              label: Text(l.reverseText),
              onPressed: () => _apply((s) => s.characters.toList().reversed.join()),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(l.sectionEncoding, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ActionChip(
              label: Text(l.b64Encode),
              onPressed: () => _apply((s) => base64.encode(utf8.encode(s))),
            ),
            ActionChip(
              label: Text(l.b64Decode),
              onPressed: () => _apply((s) => utf8.decode(base64.decode(s.trim()))),
            ),
            ActionChip(label: Text(l.urlEncode), onPressed: () => _apply(Uri.encodeComponent)),
            ActionChip(label: Text(l.urlDecode), onPressed: () => _apply(Uri.decodeComponent)),
          ],
        ),
        const SizedBox(height: 16),
        Text(l.sectionHash, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        if (text.isEmpty)
          Text(l.hashHint)
        else ...[
          _HashRow('MD5', md5.convert(bytes).toString()),
          _HashRow('SHA-1', sha1.convert(bytes).toString()),
          _HashRow('SHA-256', sha256.convert(bytes).toString()),
        ],
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: text.isEmpty ? null : () => copyText(context, text),
                icon: const Icon(Icons.copy_rounded),
                label: Text(l.copy),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: text.isEmpty ? null : () => setState(_input.clear),
                icon: const Icon(Icons.delete_outline_rounded),
                label: Text(l.clear),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Chip(
        label: Text('$label: $value'),
        visualDensity: VisualDensity.compact,
      );
}

class _HashRow extends StatelessWidget {
  const _HashRow(this.name, this.value);
  final String name;
  final String value;

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        title: Text(name),
        subtitle: Text(value, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
        trailing: const Icon(Icons.copy_rounded, size: 18),
        onTap: () => copyText(context, value),
      );
}
