import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class FuelTool extends StatefulWidget {
  const FuelTool({super.key});

  @override
  State<FuelTool> createState() => _FuelToolState();
}

class _FuelToolState extends State<FuelTool> {
  final _distance = TextEditingController();
  final _fuel = TextEditingController();
  final _price = TextEditingController();

  @override
  void dispose() {
    _distance.dispose();
    _fuel.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final d = parseNum(_distance.text);
    final f = parseNum(_fuel.text);
    final p = parseNum(_price.text);
    final ok = d != null && f != null && d > 0 && f > 0;
    final per100 = ok ? f / d * 100 : null;
    final costKm = ok && p != null ? f * p / d : null;
    final total = ok && p != null ? f * p : null;

    return ToolScaffold(
      title: l.toolFuel,
      children: [
        NumberField(
          controller: _distance,
          label: l.fuelDistance,
          suffix: l.unitKm,
          onChanged: () => setState(() {}),
        ),
        NumberField(
          controller: _fuel,
          label: l.fuelUsed,
          suffix: l.unitLiter,
          onChanged: () => setState(() {}),
        ),
        NumberField(
          controller: _price,
          label: l.fuelPrice,
          onChanged: () => setState(() {}),
        ),
        const SizedBox(height: 8),
        ResultCard(
          label: l.fuelPer100,
          value: per100 == null ? '—' : '${fmt(per100, 2)} ${l.unitLiter}',
        ),
        const SizedBox(height: 8),
        ResultCard(label: l.fuelPerKm, value: costKm == null ? '—' : fmt(costKm, 0)),
        const SizedBox(height: 8),
        ResultCard(label: l.fuelTotal, value: total == null ? '—' : fmt(total, 0)),
        const SizedBox(height: 8),
        ResultCard(
          label: l.fuelMpg,
          value: per100 == null ? '—' : fmt(235.215 / per100, 1),
        ),
      ],
    );
  }
}
