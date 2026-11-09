import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../core/files.dart';
import '../core/l10n.dart';
import '../core/widgets.dart';

class QrTool extends StatefulWidget {
  const QrTool({super.key});

  @override
  State<QrTool> createState() => _QrToolState();
}

class _QrToolState extends State<QrTool> {
  final _text = TextEditingController(text: 'https://');
  Color _color = Colors.black;

  static const _colors = [
    Colors.black,
    Color(0xFF6C5CE7),
    Color(0xFF0984E3),
    Color(0xFF00B894),
    Color(0xFFD63031),
  ];

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  /// QR kodni oq fonli 1024x1024 PNG qilib chizadi va ulashish oynasini ochadi.
  Future<void> _saveImage(BuildContext context, String data) async {
    const side = 1024.0;
    const margin = 96.0;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawRect(const Rect.fromLTWH(0, 0, side, side), Paint()..color = Colors.white);
    canvas.translate(margin, margin);
    QrPainter(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle, color: _color),
      dataModuleStyle:
          QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle, color: _color),
    ).paint(canvas, const Size(side - 2 * margin, side - 2 * margin));
    final image = await recorder.endRecording().toImage(side.toInt(), side.toInt());
    final png = await image.toByteData(format: ui.ImageByteFormat.png);
    if (png == null || !context.mounted) return;
    await shareBytes(context, png.buffer.asUint8List(), 'qr-code.png', 'image/png');
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final data = _text.text.trim();
    return ToolScaffold(
      title: l.toolQr,
      children: [
        TextField(
          controller: _text,
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(labelText: l.qrInputLabel),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: data.isEmpty
                ? SizedBox(
                    width: 240,
                    height: 240,
                    child: Center(
                      child: Text(l.qrEnterText, style: const TextStyle(color: Colors.black54)),
                    ),
                  )
                : QrImageView(
                    data: data,
                    size: 240,
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                    eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle, color: _color),
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.circle,
                      color: _color,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final c in _colors)
              GestureDetector(
                onTap: () => setState(() => _color = c),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 3,
                      color: _color == c
                          ? Theme.of(context).colorScheme.outline
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: data.isEmpty ? null : () => _saveImage(context, data),
          icon: const Icon(Icons.download_rounded),
          label: Text(l.saveShare),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: data.isEmpty ? null : () => copyText(context, data),
          icon: const Icon(Icons.copy_rounded),
          label: Text(l.qrCopyText),
        ),
      ],
    );
  }
}
