import 'package:flutter/material.dart';

import '../core/files.dart';
import '../core/image_ops.dart';
import '../core/l10n.dart';
import '../core/widgets.dart';

enum ImageMode {
  compress,
  resize,
  convert;

  String title(AppLocalizations l) => switch (this) {
        compress => l.toolImageCompress,
        resize => l.toolImageResize,
        convert => l.toolImageConvert,
      };
}

/// Siqish, o'lcham o'zgartirish va format/burish uchun umumiy ekran.
class ImageProcessTool extends StatefulWidget {
  const ImageProcessTool({super.key, required this.mode});

  final ImageMode mode;

  @override
  State<ImageProcessTool> createState() => _ImageProcessToolState();
}

class _ImageProcessToolState extends State<ImageProcessTool> {
  PickedImage? _src;
  ImageResult? _out;
  bool _busy = false;

  double _quality = 70;
  int _maxSide = 0;
  bool _png = false;
  int _rotate = 0;
  bool _flip = false;
  final _custom = TextEditingController();

  ImageMode get _mode => widget.mode;

  @override
  void initState() {
    super.initState();
    if (_mode == ImageMode.resize) {
      _maxSide = 1080;
      _quality = 88;
    }
    if (_mode == ImageMode.convert) _quality = 92;
  }

  @override
  void dispose() {
    _custom.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final picked = await pickImages();
    if (picked.isEmpty) return;
    setState(() {
      _src = picked.first;
      _out = null;
    });
    await _apply();
  }

  Future<void> _apply() async {
    final src = _src;
    if (src == null) return;
    setState(() => _busy = true);
    try {
      final out = await processImage(ImageJob(
        bytes: src.bytes,
        maxSide: _maxSide,
        quality: _quality.round(),
        png: _png,
        rotate: _rotate,
        flipH: _flip,
      ));
      if (mounted) setState(() => _out = out);
    } catch (e) {
      if (mounted) showMessage(context, context.l10n.imageOpenFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String get _baseName {
    final n = _src?.name ?? 'rasm';
    final dot = n.lastIndexOf('.');
    return dot > 0 ? n.substring(0, dot) : n;
  }

  Future<void> _share() async {
    final out = _out;
    if (out == null) return;
    final ext = _png ? 'png' : 'jpg';
    await shareBytes(
      context,
      out.bytes,
      '${_baseName}_toolbox.$ext',
      _png ? 'image/png' : 'image/jpeg',
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final src = _src;
    final out = _out;

    return ToolScaffold(
      title: _mode.title(l),
      children: [
        FilledButton.tonalIcon(
          onPressed: _busy ? null : _pick,
          icon: const Icon(Icons.add_photo_alternate_rounded),
          label: Text(src == null ? l.chooseImage : l.chooseAnotherImage),
        ),
        if (src != null) ...[
          const SizedBox(height: 16),
          ..._options(l),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _busy ? null : _apply,
            child: _busy
                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5))
                : Text(l.apply),
          ),
        ],
        if (out != null && src != null) ...[
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: scheme.surfaceContainerHighest,
              constraints: const BoxConstraints(maxHeight: 320),
              alignment: Alignment.center,
              child: Image.memory(out.bytes, fit: BoxFit.contain, gaplessPlayback: true),
            ),
          ),
          const SizedBox(height: 12),
          _SizeSummary(before: src.bytes.length, after: out.bytes.length, out: out),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _share,
            icon: const Icon(Icons.ios_share_rounded),
            label: Text(l.saveShare),
          ),
        ],
      ],
    );
  }

  List<Widget> _options(AppLocalizations l) {
    return [
      if (_mode == ImageMode.compress) ...[
        Text(l.qualityLabel(_quality.round())),
        Slider(
          value: _quality,
          min: 10,
          max: 100,
          divisions: 18,
          onChanged: (v) => setState(() => _quality = v),
        ),
        Text(l.qualityHint, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 12),
      ],
      if (_mode == ImageMode.resize) ...[
        Text(l.longestSide),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final s in [480, 720, 1080, 1920, 3000])
              ChoiceChip(
                label: Text('$s'),
                selected: _maxSide == s && _custom.text.isEmpty,
                onSelected: (_) => setState(() {
                  _maxSide = s;
                  _custom.clear();
                }),
              ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _custom,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: l.customSize, suffixText: 'px'),
          onChanged: (v) => setState(() {
            final n = int.tryParse(v);
            if (n != null && n >= 16 && n <= 10000) _maxSide = n;
          }),
        ),
        const SizedBox(height: 12),
      ],
      if (_mode == ImageMode.convert) ...[
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(value: false, label: Text('JPG')),
            ButtonSegment(value: true, label: Text('PNG')),
          ],
          selected: {_png},
          onSelectionChanged: (s) => setState(() => _png = s.first),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            ActionChip(
              avatar: const Icon(Icons.rotate_left_rounded, size: 18),
              label: Text(l.rotateLeft),
              onPressed: () => setState(() => _rotate = (_rotate + 270) % 360),
            ),
            ActionChip(
              avatar: const Icon(Icons.rotate_right_rounded, size: 18),
              label: Text(l.rotateRight),
              onPressed: () => setState(() => _rotate = (_rotate + 90) % 360),
            ),
            FilterChip(
              avatar: const Icon(Icons.flip_rounded, size: 18),
              label: Text(l.mirror),
              selected: _flip,
              onSelected: (v) => setState(() => _flip = v),
            ),
          ],
        ),
        Text(l.rotationLabel(_rotate), style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 12),
      ],
    ];
  }
}

class _SizeSummary extends StatelessWidget {
  const _SizeSummary({required this.before, required this.after, required this.out});

  final int before;
  final int after;
  final ImageResult out;

  @override
  Widget build(BuildContext context) {
    final diff = before == 0 ? 0 : ((1 - after / before) * 100).round();
    return ResultCard(
      label: '${out.width} × ${out.height} px',
      value: '${humanSize(before)} → ${humanSize(after)}'
          '${diff > 0 ? '  (−$diff%)' : diff < 0 ? '  (+${-diff}%)' : ''}',
      copyable: false,
    );
  }
}
