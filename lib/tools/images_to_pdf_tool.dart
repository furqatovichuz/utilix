import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../core/files.dart';
import '../core/l10n.dart';

class _PdfJob {
  const _PdfJob(this.images, this.fitToImage, this.margin);
  final List<Uint8List> images;
  final bool fitToImage;
  final double margin;
}

Future<Uint8List> _buildPdf(_PdfJob job) => Isolate.run(() async {
      final doc = pw.Document(creator: 'Toolbox');
      for (final raw in job.images) {
        var im = img.decodeImage(raw);
        if (im == null) continue;
        im = img.bakeOrientation(im);
        if (im.hasAlpha) {
          final bg = img.Image(width: im.width, height: im.height, numChannels: 3);
          img.fill(bg, color: img.ColorRgb8(255, 255, 255));
          img.compositeImage(bg, im);
          im = bg;
        }
        final jpg = Uint8List.fromList(img.encodeJpg(im, quality: 88));
        final image = pw.MemoryImage(jpg);

        if (job.fitToImage) {
          // Sahifa rasm nisbatiga teng, eng uzun tomoni ~842 pt (A4 balandligi).
          final scale = 842 / (im.width > im.height ? im.width : im.height);
          final format = PdfPageFormat(im.width * scale, im.height * scale);
          doc.addPage(pw.Page(
            pageFormat: format,
            margin: pw.EdgeInsets.zero,
            build: (_) => pw.Image(image, fit: pw.BoxFit.fill),
          ));
        } else {
          final landscape = im.width > im.height;
          doc.addPage(pw.Page(
            pageFormat: landscape ? PdfPageFormat.a4.landscape : PdfPageFormat.a4,
            margin: pw.EdgeInsets.all(job.margin),
            build: (_) => pw.Center(child: pw.Image(image, fit: pw.BoxFit.contain)),
          ));
        }
      }
      return doc.save();
    });

class ImagesToPdfTool extends StatefulWidget {
  const ImagesToPdfTool({super.key});

  @override
  State<ImagesToPdfTool> createState() => _ImagesToPdfToolState();
}

class _ImagesToPdfToolState extends State<ImagesToPdfTool> {
  final List<PickedImage> _images = [];
  bool _fit = false;
  double _margin = 24;
  bool _busy = false;

  Future<void> _add() async {
    final picked = await pickImages(multiple: true);
    if (picked.isEmpty) return;
    setState(() => _images.addAll(picked));
  }

  Future<void> _create() async {
    setState(() => _busy = true);
    try {
      final bytes = await _buildPdf(
        _PdfJob([for (final i in _images) i.bytes], _fit, _margin),
      );
      if (!mounted) return;
      await shareBytes(context, bytes, 'toolbox_${DateTime.now().millisecondsSinceEpoch}.pdf', 'application/pdf');
    } catch (_) {
      if (mounted) showMessage(context, context.l10n.pdfCreateFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l.toolImagesToPdf)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _images.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.picture_as_pdf_rounded,
                              size: 64, color: Theme.of(context).colorScheme.outline),
                          const SizedBox(height: 12),
                          Text(l.pdfPickOne),
                        ],
                      ),
                    )
                  : ReorderableListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: _images.length,
                      onReorderItem: (a, b) => setState(() {
                        _images.insert(b, _images.removeAt(a));
                      }),
                      itemBuilder: (_, i) {
                        final item = _images[i];
                        return Card(
                          key: ObjectKey(item),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(item.bytes, width: 52, height: 52, fit: BoxFit.cover, cacheWidth: 120),
                            ),
                            title: Text('${i + 1}. ${item.name}', maxLines: 1, overflow: TextOverflow.ellipsis),
                            subtitle: Text(humanSize(item.bytes.length)),
                            trailing: IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () => setState(() => _images.removeAt(i)),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l.pdfFitToImage),
                    subtitle: Text(l.pdfFitOff),
                    value: _fit,
                    onChanged: (v) => setState(() => _fit = v),
                  ),
                  if (!_fit)
                    Row(
                      children: [
                        Text(l.pdfMargin),
                        Expanded(
                          child: Slider(
                            value: _margin,
                            max: 60,
                            divisions: 6,
                            label: '${_margin.round()}',
                            onChanged: (v) => setState(() => _margin = v),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _busy ? null : _add,
                          icon: const Icon(Icons.add_photo_alternate_rounded),
                          label: Text(l.addImage),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                          onPressed: _images.isEmpty || _busy ? null : _create,
                          child: _busy
                              ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5))
                              : Text(l.createPdf),
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
