import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/l10n.dart';

class CounterTool extends StatefulWidget {
  const CounterTool({super.key});

  @override
  State<CounterTool> createState() => _CounterToolState();
}

class _CounterToolState extends State<CounterTool> {
  int _count = 0;
  int _step = 1;

  void _add(int delta) {
    HapticFeedback.lightImpact();
    setState(() => _count += delta);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.toolCounter),
        actions: [
          IconButton(
            tooltip: l.counterReset,
            icon: const Icon(Icons.restart_alt_rounded),
            onPressed: _count == 0 ? null : () => setState(() => _count = 0),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _add(_step),
                child: Center(
                  child: Text(
                    '$_count',
                    style: TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.w200,
                      color: scheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            Text(l.counterHint),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                for (final s in [1, 5, 10, 100])
                  ChoiceChip(
                    label: Text('+$s'),
                    selected: _step == s,
                    onSelected: (_) => setState(() => _step = s),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton.tonalIcon(
                onPressed: () => _add(-_step),
                icon: const Icon(Icons.remove_rounded),
                label: Text(l.counterSubtract(_step)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
