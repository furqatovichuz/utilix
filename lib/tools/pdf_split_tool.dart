import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf_manipulator/pdf_manipulator.dart';

import '../core/files.dart';
import '../core/l10n.dart';
import '../core/page_ranges.dart';
import '../core/widgets.dart';

enum _SplitMode { pages, each, every }

class PdfSplitTool extends StatefulWidget {
  const PdfSplitTool({super.key});

  @override
  State<PdfSplitTool> createState() => _PdfSplitToolState();
}

class _PdfSplitToolState extends State<PdfSplitTool> {
  static const _maxFiles = 100;

  final _pdf = Pdf();
  final _ranges = TextEditingController();
  final _every = TextEditingController(text: '2');

  PickedImage? _file;
  int _pageCount = 0;
  _SplitMode _mode = _SplitMode.pages;
  bool _busy = false;

  @override
  void dispose() {
    _ranges.dispose();
    _every.dispose();
    _pdf.dispose();
    super.dispose();
  }

  String get _baseName {
    final n = _file?.name ?? 'document';
    final dot = n.lastIndexOf('.');
    return dot > 0 ? n.substring(0, dot) : n;
  }

  Future<void> _pick() async {
    setState(() => _busy = true);
    try {
      final picked = await pickPdfs(multiple: false);
      if (picked.isEmpty) return;
      final doc = await _pdf.open(MemorySource(picked.first.bytes));
      final count = doc.pageCount;
      await doc.dispose();
      setState(() {
        _file = picked.first;
        _pageCount = count;
        _ranges.clear();
      });
    } catch (_) {
      if (mounted) showMessage(context, context.l10n.pdfOpenFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Tanlangan sahifalar to'plamlari ro'yxati (har biri alohida fayl bo'ladi).
  List<List<int>>? _plan() {
    switch (_mode) {
      case _SplitMode.pages:
        final pages = parsePageRanges(_ranges.text, _pageCount);
        return pages == null ? null : [pages];
      case _SplitMode.each:
        return [for (var i = 0; i < _pageCount; i++) [i]];
      case _SplitMode.every:
        final n = int.tryParse(_every.text.trim());
        if (n == null || n < 1) return null;
        return [
          for (var s = 0; s < _pageCount; s += n)
            [for (var i = s; i < s + n && i < _pageCount; i++) i],
        ];
    }
  }

  Future<void> _run() async {
    final l = context.l10n;
    final file = _file;
    final plan = _plan();
    if (file == null || plan == null) {
      showMessage(context, l.splitInvalid);
      return;
    }
    if (plan.length > _maxFiles) {
      showMessage(context, l.splitTooMany(_maxFiles));
      return;
    }

    setState(() => _busy = true);
    try {
      final outputs = <String, Uint8List>{};
      for (var i = 0; i < plan.length; i++) {
        final sink = MemorySink();
        await _pdf.extractPages(MemorySource(file.bytes), sink, pages: plan[i]);
        final suffix = plan.length == 1 ? 'pages' : 'part_${(i + 1).toString().padLeft(2, '0')}';
        outputs['${_baseName}_$suffix.pdf'] = sink.takeBytes();
      }
      if (!mounted) return;
      await shareMany(outputs, 'application/pdf');
    } catch (_) {
      if (mounted) showMessage(context, l.splitFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _summary(AppLocalizations l, List<List<int>> plan) =>
      plan.length == 1 ? l.summaryOne(plan.first.length) : l.summaryMany(plan.length);

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final file = _file;
    final plan = file == null ? null : _plan();

    return ToolScaffold(
      title: l.toolPdfSplit,
      children: [
        FilledButton.tonalIcon(
          onPressed: _busy ? null : _pick,
          icon: const Icon(Icons.upload_file_rounded),
          label: Text(file == null ? l.choosePdf : l.chooseAnotherPdf),
        ),
        if (file != null) ...[
          const SizedBox(height: 12),
          Card(
            color: scheme.surfaceContainerLow,
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf_rounded, color: Colors.red),
              title: Text(file.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(l.pdfPagesSummary(_pageCount, humanSize(file.bytes.length))),
            ),
          ),
          const SizedBox(height: 16),
          SegmentedButton<_SplitMode>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: _SplitMode.pages, label: Text(l.splitModePages)),
              ButtonSegment(value: _SplitMode.each, label: Text(l.splitModeEach)),
              ButtonSegment(value: _SplitMode.every, label: Text(l.splitModeEvery)),
            ],
            selected: {_mode},
            onSelectionChanged: (s) => setState(() => _mode = s.first),
          ),
          const SizedBox(height: 16),
          if (_mode == _SplitMode.pages) ...[
            TextField(
              controller: _ranges,
              keyboardType: TextInputType.text,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,\- ]'))],
              decoration: InputDecoration(
                labelText: l.pageSelectLabel,
                hintText: l.pageSelectHint,
                helperText: l.pageSelectHelper(_pageCount),
                errorText: _ranges.text.isNotEmpty && plan == null ? l.pageSelectError : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 4),
            Text(l.pageSelectNote, style: const TextStyle(fontSize: 12)),
          ],
          if (_mode == _SplitMode.each) Text(l.splitEachNote),
          if (_mode == _SplitMode.every)
            TextField(
              controller: _every,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: l.splitEveryLabel, suffixText: l.pagesSuffix),
              onChanged: (_) => setState(() {}),
            ),
          const SizedBox(height: 16),
          if (plan != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(_summary(l, plan),
                  style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w600)),
            ),
          FilledButton.icon(
            onPressed: _busy || plan == null ? null : _run,
            icon: _busy
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.5))
                : const Icon(Icons.call_split_rounded),
            label: Text(l.splitAndShare),
          ),
        ],
      ],
    );
  }
}
