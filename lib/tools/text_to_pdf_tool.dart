import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../core/files.dart';
import '../core/l10n.dart';
import '../core/widgets.dart';

class TextToPdfTool extends StatefulWidget {
  const TextToPdfTool({super.key});

  @override
  State<TextToPdfTool> createState() => _TextToPdfToolState();
}

class _TextToPdfToolState extends State<TextToPdfTool> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  double _fontSize = 12;
  bool _busy = false;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    setState(() => _busy = true);
    try {
      // Roboto lotin va kirill harflarini qo'llab-quvvatlaydi.
      final regular = pw.Font.ttf(await rootBundle.load('assets/fonts/roboto-regular.ttf'));
      final bold = pw.Font.ttf(await rootBundle.load('assets/fonts/roboto-bold.ttf'));

      final doc = pw.Document(creator: 'Toolbox', title: _title.text.trim());
      final lines = _body.text.split('\n');
      doc.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        theme: pw.ThemeData.withFont(base: regular, bold: bold),
        build: (_) => [
          if (_title.text.trim().isNotEmpty)
            pw.Header(
              level: 0,
              child: pw.Text(
                _title.text.trim(),
                style: pw.TextStyle(fontSize: _fontSize + 8, fontWeight: pw.FontWeight.bold),
              ),
            ),
          for (final line in lines)
            line.trim().isEmpty
                ? pw.SizedBox(height: _fontSize)
                : pw.Paragraph(text: line, style: pw.TextStyle(fontSize: _fontSize)),
        ],
      ));
      final bytes = await doc.save();
      if (!mounted) return;
      await shareBytes(context, bytes, 'matn_${DateTime.now().millisecondsSinceEpoch}.pdf', 'application/pdf');
    } catch (_) {
      if (mounted) showMessage(context, context.l10n.pdfCreateFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return ToolScaffold(
        title: l.toolTextToPdf,
        children: [
          TextField(
            controller: _title,
            decoration: InputDecoration(labelText: l.t2pTitleLabel),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _body,
            minLines: 10,
            maxLines: 20,
            decoration: InputDecoration(labelText: l.textLabel),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(l.fontSizeLabel(_fontSize.round())),
              Expanded(
                child: Slider(
                  value: _fontSize,
                  min: 9,
                  max: 24,
                  divisions: 15,
                  onChanged: (v) => setState(() => _fontSize = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _body.text.trim().isEmpty || _busy ? null : _create,
            icon: _busy
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.5))
                : const Icon(Icons.picture_as_pdf_rounded),
            label: Text(l.createPdf),
          ),
        ],
      );
  }
}
