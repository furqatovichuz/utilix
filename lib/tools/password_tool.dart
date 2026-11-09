import 'dart:math';

import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class PasswordTool extends StatefulWidget {
  const PasswordTool({super.key});

  @override
  State<PasswordTool> createState() => _PasswordToolState();
}

class _PasswordToolState extends State<PasswordTool> {
  static final _rng = Random.secure();
  static const _lower = 'abcdefghijkmnopqrstuvwxyz';
  static const _upper = 'ABCDEFGHJKLMNPQRSTUVWXYZ';
  static const _digits = '23456789';
  static const _symbols = '!@#\$%^&*()-_=+?';

  double _length = 16;
  bool _useUpper = true;
  bool _useDigits = true;
  bool _useSymbols = true;
  String _password = '';

  @override
  void initState() {
    super.initState();
    _generate();
  }

  void _generate() {
    final pools = <String>[
      _lower,
      if (_useUpper) _upper,
      if (_useDigits) _digits,
      if (_useSymbols) _symbols,
    ];
    final all = pools.join();
    final len = _length.round();
    // Har bir tanlangan guruhdan kamida bittadan belgi kafolatlanadi.
    final chars = [for (final p in pools) p[_rng.nextInt(p.length)]];
    while (chars.length < len) {
      chars.add(all[_rng.nextInt(all.length)]);
    }
    chars.shuffle(_rng);
    setState(() => _password = chars.take(len).join());
  }

  /// Entropiya bo'yicha daraja: 0 — zaif ... 3 — juda kuchli.
  ({int level, double value}) get _strength {
    var poolSize = _lower.length;
    if (_useUpper) poolSize += _upper.length;
    if (_useDigits) poolSize += _digits.length;
    if (_useSymbols) poolSize += _symbols.length;
    final bits = _length.round() * (log(poolSize) / ln2);
    if (bits < 40) return (level: 0, value: .25);
    if (bits < 60) return (level: 1, value: .5);
    if (bits < 90) return (level: 2, value: .75);
    return (level: 3, value: 1);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final s = _strength;
    final label = [l.pwWeak, l.pwMedium, l.pwStrong, l.pwVeryStrong][s.level];
    final color = [Colors.red, Colors.orange, Colors.lightGreen, Colors.green][s.level];
    return ToolScaffold(
      title: l.toolPassword,
      children: [
        ResultCard(label: l.pwLabel, value: _password),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(value: s.value, minHeight: 8, color: color),
        ),
        const SizedBox(height: 6),
        Text(l.pwStrength(label), style: TextStyle(color: color)),
        const SizedBox(height: 16),
        Text(l.pwLength(_length.round())),
        Slider(
          value: _length,
          min: 6,
          max: 48,
          divisions: 42,
          onChanged: (v) {
            _length = v;
            _generate();
          },
        ),
        SwitchListTile(
          title: Text(l.pwUpper),
          value: _useUpper,
          onChanged: (v) {
            _useUpper = v;
            _generate();
          },
        ),
        SwitchListTile(
          title: Text(l.pwDigits),
          value: _useDigits,
          onChanged: (v) {
            _useDigits = v;
            _generate();
          },
        ),
        SwitchListTile(
          title: Text(l.pwSymbols),
          value: _useSymbols,
          onChanged: (v) {
            _useSymbols = v;
            _generate();
          },
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _generate,
          icon: const Icon(Icons.refresh_rounded),
          label: Text(l.pwNew),
        ),
      ],
    );
  }
}
