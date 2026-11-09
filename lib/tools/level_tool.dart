import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../core/l10n.dart';

class LevelTool extends StatefulWidget {
  const LevelTool({super.key});

  @override
  State<LevelTool> createState() => _LevelToolState();
}

class _LevelToolState extends State<LevelTool> {
  StreamSubscription<AccelerometerEvent>? _sub;
  double _x = 0, _y = 0;
  bool _unavailable = false;

  @override
  void initState() {
    super.initState();
    try {
      _sub = accelerometerEventStream().listen(
        (e) {
          // Past o'tkazish filtri: titrashni kamaytiradi.
          setState(() {
            _x = _x * .8 + e.x * .2;
            _y = _y * .8 + e.y * .2;
          });
        },
        onError: (_) => setState(() => _unavailable = true),
      );
    } catch (_) {
      _unavailable = true;
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l = context.l10n;
    // Yer tortishi 9.8 m/s². Burchak = asin(a / g).
    double angle(double a) => asin((a / 9.81).clamp(-1.0, 1.0)) * 180 / pi;
    final ax = angle(_x), ay = angle(_y);
    final level = ax.abs() < 1 && ay.abs() < 1;

    return Scaffold(
      appBar: AppBar(title: Text(l.toolLevel)),
      body: Center(
        child: _unavailable
            ? Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l.levelNoSensor),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 260,
                    height: 260,
                    child: CustomPaint(
                      painter: _BubblePainter(
                        dx: (-_x / 9.81).clamp(-1.0, 1.0),
                        dy: (_y / 9.81).clamp(-1.0, 1.0),
                        color: level ? Colors.green : scheme.primary,
                        ring: scheme.outline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '${ax.abs().toStringAsFixed(1)}°  /  ${ay.abs().toStringAsFixed(1)}°',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    level ? l.levelFlat : l.levelHint,
                    style: TextStyle(color: level ? Colors.green : scheme.onSurfaceVariant),
                  ),
                ],
              ),
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  _BubblePainter({required this.dx, required this.dy, required this.color, required this.ring});

  final double dx, dy;
  final Color color, ring;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = ring;
    canvas.drawCircle(c, r - 2, stroke);
    canvas.drawCircle(c, r * .5, stroke);
    canvas.drawLine(Offset(c.dx - r, c.dy), Offset(c.dx + r, c.dy), stroke..strokeWidth = 1);
    canvas.drawLine(Offset(c.dx, c.dy - r), Offset(c.dx, c.dy + r), stroke);

    final bubble = c + Offset(dx, dy) * (r - 24);
    canvas.drawCircle(bubble, 22, Paint()..color = color.withValues(alpha: .85));
  }

  @override
  bool shouldRepaint(_BubblePainter o) => o.dx != dx || o.dy != dy || o.color != color;
}
