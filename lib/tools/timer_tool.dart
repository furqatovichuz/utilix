import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/l10n.dart';

String _clock(Duration d, {bool centis = false}) {
  String two(int n) => n.toString().padLeft(2, '0');
  final h = d.inHours;
  final base = '${h > 0 ? '${two(h)}:' : ''}${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}';
  return centis ? '$base.${two((d.inMilliseconds % 1000) ~/ 10)}' : base;
}

class TimerTool extends StatelessWidget {
  const TimerTool({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.toolTimer),
          bottom: TabBar(
            tabs: [Tab(text: l.stopwatchTab), Tab(text: l.timerTab)],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(children: [_Stopwatch(), _Countdown()]),
        ),
      ),
    );
  }
}

class _Stopwatch extends StatefulWidget {
  const _Stopwatch();

  @override
  State<_Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<_Stopwatch> {
  final _sw = Stopwatch();
  final _laps = <Duration>[];
  Timer? _ticker;

  void _toggle() {
    if (_sw.isRunning) {
      _sw.stop();
      _ticker?.cancel();
    } else {
      _sw.start();
      _ticker = Timer.periodic(const Duration(milliseconds: 40), (_) => setState(() {}));
    }
    setState(() {});
  }

  void _lapOrReset() {
    if (_sw.isRunning) {
      _laps.insert(0, _sw.elapsed);
    } else {
      _sw.reset();
      _laps.clear();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(
        children: [
          const SizedBox(height: 32),
          Text(
            _clock(_sw.elapsed, centis: true),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontFeatures: const [FontFeature.tabularFigures()],
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: (_sw.isRunning || _sw.elapsed > Duration.zero) ? _lapOrReset : null,
                child: Text(_sw.isRunning ? l.lap : l.resetAll),
              ),
              const SizedBox(width: 16),
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size(140, 52)),
                onPressed: _toggle,
                child: Text(_sw.isRunning ? l.stop : l.start),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _laps.length,
              itemBuilder: (_, i) => ListTile(
                leading: Text('#${_laps.length - i}'),
                title: Text(_clock(_laps[i], centis: true)),
              ),
            ),
          ),
        ],
      );
  }
}

class _Countdown extends StatefulWidget {
  const _Countdown();

  @override
  State<_Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<_Countdown> {
  Duration _total = const Duration(minutes: 5);
  Duration _left = const Duration(minutes: 5);
  Timer? _ticker;
  bool get _running => _ticker?.isActive ?? false;

  void _set(Duration d) {
    if (_running) return;
    setState(() {
      _total = d;
      _left = d;
    });
  }

  void _start() {
    if (_left <= Duration.zero) _left = _total;
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_left.inSeconds <= 1) {
        t.cancel();
        HapticFeedback.heavyImpact();
        SystemSound.play(SystemSoundType.alert);
        setState(() => _left = Duration.zero);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(context.l10n.timeIsUp),
            behavior: SnackBarBehavior.floating,
          ));
        }
      } else {
        setState(() => _left -= const Duration(seconds: 1));
      }
    });
    setState(() {});
  }

  void _pause() {
    _ticker?.cancel();
    setState(() {});
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final progress = _total.inSeconds == 0 ? 0.0 : _left.inSeconds / _total.inSeconds;
    return Column(
      children: [
        const SizedBox(height: 24),
        SizedBox(
          width: 240,
          height: 240,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(value: progress, strokeWidth: 10),
              ),
              Text(
                _clock(_left),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          children: [
            for (final m in [1, 3, 5, 10, 15, 30])
              ActionChip(
                  label: Text(l.timerMinutes(m)), onPressed: () => _set(Duration(minutes: m))),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                _ticker?.cancel();
                setState(() => _left = _total);
              },
              child: Text(l.restart),
            ),
            const SizedBox(width: 16),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(140, 52)),
              onPressed: _running ? _pause : _start,
              child: Text(_running ? l.stop : l.start),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (!_running)
          TextButton.icon(
            icon: const Icon(Icons.edit_rounded),
            label: Text(l.timerCustom),
            onPressed: () async {
              final t = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: _total.inHours, minute: _total.inMinutes % 60),
                helpText: l.timerPickerHelp,
                initialEntryMode: TimePickerEntryMode.input,
              );
              if (t != null) _set(Duration(hours: t.hour, minutes: t.minute));
            },
          ),
      ],
    );
  }
}
