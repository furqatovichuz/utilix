import 'package:flutter/material.dart';
import 'package:pdf_manipulator/pdf_manipulator.dart';

import '../core/files.dart';
import '../core/l10n.dart';
import '../core/pdf_ops.dart';

class PdfMergeTool extends StatefulWidget {
  const PdfMergeTool({super.key});

  @override
  State<PdfMergeTool> createState() => _PdfMergeToolState();
}

class _PdfMergeToolState extends State<PdfMergeTool> {
  final _pdf = Pdf();
  final List<PickedImage> _files = [];
  bool _busy = false;

  @override
  void dispose() {
    _pdf.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    try {
      final picked = await pickPdfs();
      if (picked.isEmpty) return;
      setState(() => _files.addAll(picked));
    } catch (_) {
      if (mounted) showMessage(context, context.l10n.fileReadFailed);
    }
  }

  Future<void> _merge() async {
    setState(() => _busy = true);
    try {
      final merged = await mergePdfs(_pdf, [for (final f in _files) f.bytes]);
      if (!mounted) return;
      await shareBytes(
        context,
        merged,
        'birlashtirilgan_${DateTime.now().millisecondsSinceEpoch}.pdf',
        'application/pdf',
      );
    } catch (_) {
      if (mounted) {
        showMessage(context, context.l10n.mergeFailed);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l = context.l10n;
    final total = _files.fold<int>(0, (s, f) => s + f.bytes.length);
    return Scaffold(
      appBar: AppBar(title: Text(l.toolPdfMerge)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _files.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.merge_type_rounded, size: 64, color: scheme.outline),
                          const SizedBox(height: 12),
                          Text(l.pdfPickAtLeast2),
                        ],
                      ),
                    )
                  : ReorderableListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: _files.length,
                      onReorderItem: (a, b) => setState(() {
                        _files.insert(b, _files.removeAt(a));
                      }),
                      itemBuilder: (_, i) {
                        final f = _files[i];
                        return Card(
                          key: ObjectKey(f),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: scheme.errorContainer,
                              child: Text('${i + 1}', style: TextStyle(color: scheme.onErrorContainer)),
                            ),
                            title: Text(f.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                            subtitle: Text(humanSize(f.bytes.length)),
                            trailing: IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () => setState(() => _files.removeAt(i)),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Column(
                children: [
                  if (_files.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        l.filesSummary(_files.length, humanSize(total)),
                        style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _busy ? null : _add,
                          icon: const Icon(Icons.add_rounded),
                          label: Text(l.addPdf),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                          onPressed: _files.length < 2 || _busy ? null : _merge,
                          child: _busy
                              ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5))
                              : Text(l.mergeAction),
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
