import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

/// Birlik belgilari xalqaro, shuning uchun tarjima qilinmaydi.
class _Unit {
  const _Unit(this.symbol, this.factor);
  final String symbol;

  /// Asosiy birlikka ko'paytirish koeffitsiyenti (harorat uchun ishlatilmaydi).
  final double factor;
}

enum _Group { length, mass, volume, area, speed, data, temp }

const Map<_Group, List<_Unit>> _groups = {
  _Group.length: [
    _Unit('mm', 0.001),
    _Unit('cm', 0.01),
    _Unit('m', 1),
    _Unit('km', 1000),
    _Unit('in', 0.0254),
    _Unit('ft', 0.3048),
    _Unit('yd', 0.9144),
    _Unit('mi', 1609.344),
  ],
  _Group.mass: [
    _Unit('g', 0.001),
    _Unit('kg', 1),
    _Unit('t', 1000),
    _Unit('oz', 0.0283495),
    _Unit('lb', 0.45359237),
  ],
  _Group.volume: [
    _Unit('ml', 0.001),
    _Unit('L', 1),
    _Unit('m³', 1000),
    _Unit('gal (US)', 3.78541),
  ],
  _Group.area: [
    _Unit('m²', 1),
    _Unit('km²', 1e6),
    _Unit('ha', 10000),
    _Unit('ft²', 0.092903),
    _Unit('ac', 4046.856),
  ],
  _Group.speed: [
    _Unit('m/s', 1),
    _Unit('km/h', 0.277778),
    _Unit('mph', 0.44704),
    _Unit('kn', 0.514444),
  ],
  _Group.data: [
    _Unit('B', 1),
    _Unit('KB', 1024),
    _Unit('MB', 1048576),
    _Unit('GB', 1073741824),
    _Unit('TB', 1099511627776),
  ],
  _Group.temp: [
    _Unit('°C', 0),
    _Unit('°F', 0),
    _Unit('K', 0),
  ],
};

String _groupName(AppLocalizations l, _Group g) => switch (g) {
      _Group.length => l.unitGroupLength,
      _Group.mass => l.unitGroupMass,
      _Group.volume => l.unitGroupVolume,
      _Group.area => l.unitGroupArea,
      _Group.speed => l.unitGroupSpeed,
      _Group.data => l.unitGroupData,
      _Group.temp => l.unitGroupTemp,
    };

class UnitTool extends StatefulWidget {
  const UnitTool({super.key});

  @override
  State<UnitTool> createState() => _UnitToolState();
}

class _UnitToolState extends State<UnitTool> {
  _Group _group = _Group.length;
  int _from = 2;
  int _to = 3;
  final _input = TextEditingController(text: '1');

  List<_Unit> get _units => _groups[_group]!;

  double? _convert() {
    final v = parseNum(_input.text);
    if (v == null) return null;
    if (_group == _Group.temp) {
      final c = switch (_from) {
        0 => v,
        1 => (v - 32) * 5 / 9,
        _ => v - 273.15,
      };
      return switch (_to) {
        0 => c,
        1 => c * 9 / 5 + 32,
        _ => c + 273.15,
      };
    }
    return v * _units[_from].factor / _units[_to].factor;
  }

  void _setGroup(_Group g) {
    setState(() {
      _group = g;
      _from = 0;
      _to = (_groups[g]!.length > 1) ? 1 : 0;
    });
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final r = _convert();
    return ToolScaffold(
      title: l.toolUnits,
      children: [
        Wrap(
          spacing: 8,
          children: [
            for (final g in _Group.values)
              ChoiceChip(
                label: Text(_groupName(l, g)),
                selected: g == _group,
                onSelected: (_) => _setGroup(g),
              ),
          ],
        ),
        const SizedBox(height: 16),
        NumberField(controller: _input, label: l.valueLabel, onChanged: () => setState(() {})),
        _UnitPicker(
          label: l.fromUnit,
          units: _units,
          value: _from,
          onChanged: (v) => setState(() => _from = v),
        ),
        Center(
          child: IconButton.filledTonal(
            icon: const Icon(Icons.swap_vert_rounded),
            onPressed: () => setState(() {
              final t = _from;
              _from = _to;
              _to = t;
            }),
          ),
        ),
        _UnitPicker(
          label: l.toUnit,
          units: _units,
          value: _to,
          onChanged: (v) => setState(() => _to = v),
        ),
        const SizedBox(height: 8),
        ResultCard(
          label: '${_units[_from].symbol} → ${_units[_to].symbol}',
          value: r == null ? '—' : fmt(r, 6),
        ),
      ],
    );
  }
}

class _UnitPicker extends StatelessWidget {
  const _UnitPicker({
    required this.label,
    required this.units,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final List<_Unit> units;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: DropdownButtonFormField<int>(
          initialValue: value,
          key: ValueKey('$label-$value-${units.length}'),
          decoration: InputDecoration(labelText: label),
          items: [
            for (var i = 0; i < units.length; i++)
              DropdownMenuItem(value: i, child: Text(units[i].symbol)),
          ],
          onChanged: (v) => v == null ? null : onChanged(v),
        ),
      );
}
