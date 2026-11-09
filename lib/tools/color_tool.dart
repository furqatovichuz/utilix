import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class ColorTool extends StatefulWidget {
  const ColorTool({super.key});

  @override
  State<ColorTool> createState() => _ColorToolState();
}

class _ColorToolState extends State<ColorTool> {
  double _r = 108, _g = 92, _b = 231;
  final _hexController = TextEditingController();

  Color get _color => Color.fromARGB(255, _r.round(), _g.round(), _b.round());

  String get _hex =>
      '#${_r.round().toRadixString(16).padLeft(2, '0')}'
      '${_g.round().toRadixString(16).padLeft(2, '0')}'
      '${_b.round().toRadixString(16).padLeft(2, '0')}'.toUpperCase();

  @override
  void initState() {
    super.initState();
    _hexController.text = _hex;
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  void _fromHex(String v) {
    final clean = v.replaceAll('#', '').trim();
    if (clean.length != 6) return;
    final n = int.tryParse(clean, radix: 16);
    if (n == null) return;
    setState(() {
      _r = ((n >> 16) & 0xFF).toDouble();
      _g = ((n >> 8) & 0xFF).toDouble();
      _b = (n & 0xFF).toDouble();
    });
  }

  void _slide() => _hexController.text = _hex;

  @override
  Widget build(BuildContext context) {
    final hsl = HSLColor.fromColor(_color);
    final light = _color.computeLuminance() > .5;
    return ToolScaffold(
      title: context.l10n.toolColor,
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(color: _color, borderRadius: BorderRadius.circular(24)),
          alignment: Alignment.center,
          child: Text(
            _hex,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: light ? Colors.black : Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _channel('R', _r, Colors.red, (v) => _r = v),
        _channel('G', _g, Colors.green, (v) => _g = v),
        _channel('B', _b, Colors.blue, (v) => _b = v),
        const SizedBox(height: 8),
        TextField(
          controller: _hexController,
          decoration: const InputDecoration(labelText: 'HEX', prefixText: '#'),
          onChanged: _fromHex,
        ),
        const SizedBox(height: 16),
        ResultCard(label: 'HEX', value: _hex),
        const SizedBox(height: 8),
        ResultCard(
          label: 'RGB',
          value: 'rgb(${_r.round()}, ${_g.round()}, ${_b.round()})',
        ),
        const SizedBox(height: 8),
        ResultCard(
          label: 'HSL',
          value: 'hsl(${hsl.hue.round()}, ${(hsl.saturation * 100).round()}%, '
              '${(hsl.lightness * 100).round()}%)',
        ),
      ],
    );
  }

  Widget _channel(String label, double value, Color color, void Function(double) set) =>
      Row(
        children: [
          SizedBox(width: 20, child: Text(label)),
          Expanded(
            child: Slider(
              value: value,
              max: 255,
              activeColor: color,
              onChanged: (v) {
                setState(() => set(v));
                _slide();
              },
            ),
          ),
          SizedBox(width: 34, child: Text('${value.round()}', textAlign: TextAlign.right)),
        ],
      );
}
