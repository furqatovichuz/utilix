import 'package:flutter/material.dart';

import '../core/l10n.dart';
import '../core/widgets.dart';

class DateTool extends StatefulWidget {
  const DateTool({super.key});

  @override
  State<DateTool> createState() => _DateToolState();
}

class _DateToolState extends State<DateTool> {
  DateTime _from = DateTime(DateTime.now().year - 20, 1, 1);
  DateTime _to = _today();

  static DateTime _today() {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  static String _d(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';

  Future<void> _pick(bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? _from : _to,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    );
    if (picked == null) return;
    setState(() => isFrom ? _from = picked : _to = picked);
  }

  /// Yil, oy, kun farqi (kalendar bo'yicha).
  ({int y, int m, int d}) _diff(DateTime a, DateTime b) {
    var y = b.year - a.year;
    var m = b.month - a.month;
    var d = b.day - a.day;
    if (d < 0) {
      m -= 1;
      d += DateTime(b.year, b.month, 0).day;
    }
    if (m < 0) {
      y -= 1;
      m += 12;
    }
    return (y: y, m: m, d: d);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final swap = _from.isAfter(_to);
    final a = swap ? _to : _from;
    final b = swap ? _from : _to;
    final diff = _diff(a, b);
    final days = b.difference(a).inDays;

    var next = DateTime(_to.year, _from.month, _from.day);
    if (next.isBefore(_to)) next = DateTime(_to.year + 1, _from.month, _from.day);
    final untilNext = next.difference(_to).inDays;

    return ToolScaffold(
      title: l.toolDate,
      children: [
        _DateTile(label: l.dateStart, value: _d(_from), onTap: () => _pick(true)),
        const SizedBox(height: 8),
        _DateTile(label: l.dateEnd, value: _d(_to), onTap: () => _pick(false)),
        TextButton(
          onPressed: () => setState(() => _to = _today()),
          child: Text(l.dateEndToday),
        ),
        const SizedBox(height: 8),
        ResultCard(label: l.dateDifference, value: l.dateYmd(diff.y, diff.m, diff.d)),
        const SizedBox(height: 8),
        ResultCard(label: l.dateTotalDays, value: fmt(days, 0)),
        const SizedBox(height: 8),
        ResultCard(
          label: '≈',
          value: l.dateWeeksHours(fmt(days / 7, 1), fmt(days * 24, 0)),
        ),
        const SizedBox(height: 8),
        ResultCard(
          label: l.dateNextAnniversary(_d(next)),
          value: untilNext == 0 ? l.dateToday : l.dateDays(untilNext),
        ),
      ],
    );
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile({required this.label, required this.value, required this.onTap});
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: const Icon(Icons.calendar_month_rounded),
          ),
          child: Text(value, style: const TextStyle(fontSize: 16)),
        ),
      );
}
