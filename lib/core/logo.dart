import 'package:flutter/material.dart';

/// Utilix logotipi: 2×2 "asboblar to'plami" katakchalari.
/// Kvadrat va doira shakllari shaxmat tartibida, bitta katak — amber rangli aksent.
class LogoPainter extends CustomPainter {
  const LogoPainter({
    this.background = true,
    this.rounded = true,
    this.glyphScale = .56,
  });

  /// Gradient fon chizilsinmi (adaptiv ikonka old qatlami uchun `false`).
  final bool background;

  /// Fon burchaklari yumaloqmi (iOS/Play ikonkalari uchun to'liq kvadrat kerak).
  final bool rounded;

  /// Katakchalar maydonining ikonka o'lchamiga nisbati.
  final double glyphScale;

  static const gradientStart = Color(0xFF8B7CF6);
  static const gradientEnd = Color(0xFF5B4BD6);
  static const accent = Color(0xFFFFC857);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.shortestSide;
    final rect = Offset.zero & Size.square(s);

    if (background) {
      final paint = Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gradientStart, gradientEnd],
        ).createShader(rect);
      if (rounded) {
        canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(s * .225)), paint);
      } else {
        canvas.drawRect(rect, paint);
      }
    }

    final g = s * glyphScale;
    final gap = g * .1;
    final t = (g - gap) / 2;
    final origin = Offset((s - g) / 2, (s - g) / 2);
    final white = Paint()..color = Colors.white;
    final gold = Paint()..color = accent;

    Rect cell(int col, int row) =>
        Rect.fromLTWH(origin.dx + col * (t + gap), origin.dy + row * (t + gap), t, t);

    RRect square(Rect r) => RRect.fromRectAndRadius(r, Radius.circular(t * .3));

    canvas.drawRRect(square(cell(0, 0)), white);
    canvas.drawCircle(cell(1, 0).center, t / 2, white);
    canvas.drawCircle(cell(0, 1).center, t / 2, white);
    canvas.drawRRect(square(cell(1, 1)), gold);
  }

  @override
  bool shouldRepaint(LogoPainter old) =>
      old.background != background || old.rounded != rounded || old.glyphScale != glyphScale;
}

class UtilixLogo extends StatelessWidget {
  const UtilixLogo({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: size,
        child: const CustomPaint(painter: LogoPainter()),
      );
}
