import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

enum _Mode { number, coin, dice, pick }

class RandomTool extends StatefulWidget {
  const RandomTool({super.key});

  @override
  State<RandomTool> createState() => _RandomToolState();
}

class _RandomToolState extends State<RandomTool> {
  static final _rng = Random.secure();
  _Mode _mode = _Mode.number;
  final _min = TextEditingController(text: '1');
  final _max = TextEditingController(text: '100');
  final _list = TextEditingController();
  int _diceCount = 1;
  String? _result;

  @override
  void dispose() {
    _min.dispose();
    _max.dispose();
    _list.dispose();
    super.dispose();
  }

  void _roll() {
    HapticFeedback.selectionClick();
    final l = context.l10n;
    String r;
    switch (_mode) {
      case _Mode.number:
        final a = int.tryParse(_min.text.trim());
        final b = int.tryParse(_max.text.trim());
        if (a == null || b == null || a > b || b - a > 0x3fffffff) {
          r = l.rndInvalidRange;
        } else {
          r = '${a + _rng.nextInt(b - a + 1)}';
        }
      case _Mode.coin:
        r = _rng.nextBool() ? l.rndHeads : l.rndTails;
      case _Mode.dice:
        final rolls = List.generate(_diceCount, (_) => 1 + _rng.nextInt(6));
        r = '${rolls.join(' + ')}${_diceCount > 1 ? ' = ${rolls.reduce((x, y) => x + y)}' : ''}';
      case _Mode.pick:
        final items = _list.text.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
        r = items.isEmpty ? l.rndListEmpty : items[_rng.nextInt(items.length)];
    }
    setState(() => _result = r);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return ToolScaffold(
      title: l.toolRandom,
      children: [
        SegmentedButton<_Mode>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(value: _Mode.number, label: Text(l.rndNumber)),
            ButtonSegment(value: _Mode.coin, label: Text(l.rndCoin)),
            ButtonSegment(value: _Mode.dice, label: Text(l.rndDice)),
            ButtonSegment(value: _Mode.pick, label: Text(l.rndPick)),
          ],
          selected: {_mode},
          onSelectionChanged: (s) => setState(() {
            _mode = s.first;
            _result = null;
          }),
        ),
        const SizedBox(height: 16),
        if (_mode == _Mode.number)
          Row(
            children: [
              Expanded(child: _intField(_min, l.rndFrom)),
              const SizedBox(width: 12),
              Expanded(child: _intField(_max, l.rndTo)),
            ],
          ),
        if (_mode == _Mode.dice)
          Row(
            children: [
              Text(l.rndDiceCount),
              Expanded(
                child: Slider(
                  value: _diceCount.toDouble(),
                  min: 1,
                  max: 6,
                  divisions: 5,
                  label: '$_diceCount',
                  onChanged: (v) => setState(() => _diceCount = v.round()),
                ),
              ),
              Text('$_diceCount'),
            ],
          ),
        if (_mode == _Mode.pick)
          TextField(
            controller: _list,
            minLines: 4,
            maxLines: 8,
            decoration: InputDecoration(labelText: l.rndListHint),
          ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _roll,
          icon: const Icon(Icons.casino_rounded),
          label: Text(l.rndRoll),
        ),
        const SizedBox(height: 16),
        ResultCard(label: l.result, value: _result ?? '—'),
      ],
    );
  }

  Widget _intField(TextEditingController c, String label) => TextField(
        controller: c,
        keyboardType: const TextInputType.numberWithOptions(signed: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'-?[0-9]*'))],
        decoration: InputDecoration(labelText: label),
      );
}
