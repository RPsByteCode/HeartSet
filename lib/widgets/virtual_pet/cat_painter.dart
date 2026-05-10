import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'pet_state.dart';

/// Draws the cat body, head, ears, eyes, tail, and expression
/// based on the current [PetState] and animation progress values.
class CatPainter extends CustomPainter {
  final PetState state;

  /// 0.0 → 1.0  — drives breathing / idle bob
  final double breathValue;

  /// 0.0 → 1.0  — drives blink
  final double blinkValue;

  /// 0.0 → 1.0  — drives tail wag
  final double tailValue;

  /// 0.0 → 1.0  — drives ear twitch
  final double earValue;

  /// 0.0 → 1.0  — drives bounce (happy / gift)
  final double bounceValue;

  CatPainter({
    required this.state,
    required this.breathValue,
    required this.blinkValue,
    required this.tailValue,
    required this.earValue,
    required this.bounceValue,
  });

  // ─── Colour palette ───────────────────────────────────────────────────────
  Color get _bodyColor {
    switch (state) {
      case PetState.happy:
        return const Color(0xFFFFD580); // warm golden
      case PetState.sad:
        return const Color(0xFF90A4AE); // cool grey-blue
      case PetState.anxious:
        return const Color(0xFFEF9A9A); // soft red
      case PetState.calm:
        return const Color(0xFFA5D6A7); // mint green
      case PetState.listen:
        return const Color(0xFFCE93D8); // lavender
      case PetState.gift:
        return const Color(0xFFFFCC80); // orange-peach
      case PetState.pet:
        return const Color(0xFFF48FB1); // pink
      default:
        return const Color(0xFFB0BEC5); // default grey-blue
    }
  }

  Color get _accentColor => _bodyColor.withValues(alpha: 0.6);

  // ─── Paint helpers ────────────────────────────────────────────────────────
  Paint get _bodyPaint => Paint()..color = _bodyColor..style = PaintingStyle.fill;
  Paint get _darkPaint => Paint()..color = const Color(0xFF37474F)..style = PaintingStyle.fill;
  Paint get _whitePaint => Paint()..color = Colors.white..style = PaintingStyle.fill;
  Paint get _nosePaint => Paint()..color = const Color(0xFFE91E63)..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Vertical bob from breathing
    final bob = math.sin(breathValue * 2 * math.pi) * 4;

    // Bounce offset (happy / gift)
    final bounce = state == PetState.happy || state == PetState.gift
        ? -math.sin(bounceValue * math.pi) * 12
        : 0.0;

    // Lean forward when listening
    final leanX = state == PetState.listen ? -8.0 : 0.0;
    final leanAngle = state == PetState.listen ? -0.12 : 0.0;

    canvas.save();
    canvas.translate(cx + leanX, cy + bob + bounce);
    canvas.rotate(leanAngle);

    _drawTail(canvas, size);
    _drawBody(canvas, size);
    _drawHead(canvas, size);
    _drawEars(canvas, size);
    _drawFace(canvas, size);
    _drawStateOverlay(canvas, size);

    canvas.restore();
  }

  // ─── Body ─────────────────────────────────────────────────────────────────
  void _drawBody(Canvas canvas, Size size) {
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(0, 30), width: 90, height: 80),
      const Radius.circular(40),
    );
    canvas.drawRRect(bodyRect, _bodyPaint);

    // Belly patch
    final bellyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(0, 38), width: 50, height: 45),
      const Radius.circular(25),
    );
    canvas.drawRRect(bellyRect, _whitePaint);
  }

  // ─── Head ─────────────────────────────────────────────────────────────────
  void _drawHead(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(0, -28), 42, _bodyPaint);
    // Inner face circle (lighter)
    canvas.drawCircle(const Offset(0, -28), 34, Paint()..color = _bodyColor.withValues(alpha: 0.7)..style = PaintingStyle.fill);
  }

  // ─── Ears ─────────────────────────────────────────────────────────────────
  void _drawEars(Canvas canvas, Size size) {
    final twitch = math.sin(earValue * 2 * math.pi) * 0.15;

    // Left ear
    canvas.save();
    canvas.translate(-28, -62);
    canvas.rotate(-0.3 + twitch);
    _drawEar(canvas);
    canvas.restore();

    // Right ear
    canvas.save();
    canvas.translate(28, -62);
    canvas.rotate(0.3 - twitch);
    _drawEar(canvas);
    canvas.restore();
  }

  void _drawEar(Canvas canvas) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(-14, -22)
      ..lineTo(14, -22)
      ..close();
    canvas.drawPath(path, _bodyPaint);

    // Inner ear
    final inner = Path()
      ..moveTo(0, -4)
      ..lineTo(-8, -18)
      ..lineTo(8, -18)
      ..close();
    canvas.drawPath(inner, _nosePaint..color = _nosePaint.color.withValues(alpha: 0.4));
  }

  // ─── Face ─────────────────────────────────────────────────────────────────
  void _drawFace(Canvas canvas, Size size) {
    _drawEyes(canvas);
    _drawNose(canvas);
    _drawMouth(canvas);
    _drawWhiskers(canvas);
  }

  void _drawEyes(Canvas canvas) {
    final eyeY = -32.0;
    final eyeOpenness = _eyeOpenness();

    for (final xSign in [-1.0, 1.0]) {
      final ex = xSign * 14;

      // Eye white
      canvas.drawOval(
        Rect.fromCenter(center: Offset(ex, eyeY), width: 16, height: 16 * eyeOpenness),
        _whitePaint,
      );

      if (eyeOpenness > 0.1) {
        // Pupil
        canvas.drawOval(
          Rect.fromCenter(center: Offset(ex, eyeY), width: 8, height: 10 * eyeOpenness),
          _darkPaint,
        );
        // Shine
        canvas.drawCircle(Offset(ex + 3, eyeY - 3), 2, _whitePaint);
      }

      // Closed eye line when blinking
      if (eyeOpenness < 0.3) {
        final p = Paint()
          ..color = _bodyColor.withValues(alpha: 0.8)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
        canvas.drawArc(
          Rect.fromCenter(center: Offset(ex, eyeY), width: 16, height: 8),
          0, math.pi, false, p,
        );
      }
    }
  }

  double _eyeOpenness() {
    // Blink: eyes close briefly
    if (blinkValue > 0.4 && blinkValue < 0.6) {
      return math.max(0.05, 1.0 - (blinkValue - 0.4) / 0.1);
    }
    // Sad: half-closed
    if (state == PetState.sad) return 0.5;
    // Anxious: wide open
    if (state == PetState.anxious) return 1.3;
    return 1.0;
  }

  void _drawNose(Canvas canvas) {
    final path = Path()
      ..moveTo(0, -18)
      ..lineTo(-5, -13)
      ..lineTo(5, -13)
      ..close();
    canvas.drawPath(path, _nosePaint);
  }

  void _drawMouth(Canvas canvas) {
    final paint = Paint()
      ..color = const Color(0xFF37474F)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    switch (state) {
      case PetState.happy:
      case PetState.gift:
      case PetState.pet:
        // Big smile
        canvas.drawArc(Rect.fromCenter(center: const Offset(0, -10), width: 24, height: 14), 0, math.pi, false, paint);
        break;
      case PetState.sad:
        // Frown
        canvas.drawArc(Rect.fromCenter(center: const Offset(0, -4), width: 20, height: 12), math.pi, math.pi, false, paint);
        break;
      case PetState.anxious:
        // Wavy / open mouth
        final path = Path()
          ..moveTo(-10, -10)
          ..quadraticBezierTo(-5, -4, 0, -10)
          ..quadraticBezierTo(5, -16, 10, -10);
        canvas.drawPath(path, paint);
        break;
      case PetState.listen:
        // Small "O" mouth
        canvas.drawCircle(const Offset(0, -10), 5, paint);
        break;
      default:
        // Neutral small smile
        canvas.drawArc(Rect.fromCenter(center: const Offset(0, -10), width: 16, height: 8), 0, math.pi, false, paint);
    }
  }

  void _drawWhiskers(Canvas canvas) {
    final paint = Paint()
      ..color = const Color(0xFF90A4AE)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Left whiskers
    for (final angle in [-0.2, 0.0, 0.2]) {
      canvas.save();
      canvas.translate(-8, -15);
      canvas.rotate(angle + math.pi);
      canvas.drawLine(Offset.zero, const Offset(28, 0), paint);
      canvas.restore();
    }
    // Right whiskers
    for (final angle in [-0.2, 0.0, 0.2]) {
      canvas.save();
      canvas.translate(8, -15);
      canvas.rotate(angle);
      canvas.drawLine(Offset.zero, const Offset(28, 0), paint);
      canvas.restore();
    }
  }

  // ─── Tail ─────────────────────────────────────────────────────────────────
  void _drawTail(Canvas canvas, Size size) {
    final wagAngle = math.sin(tailValue * 2 * math.pi) *
        (state == PetState.happy || state == PetState.gift ? 0.6 : 0.25);

    final paint = Paint()
      ..color = _bodyColor
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(38, 40);
    path.quadraticBezierTo(
      60 + math.cos(wagAngle) * 20,
      20 + math.sin(wagAngle) * 30,
      55 + math.cos(wagAngle) * 35,
      -10 + math.sin(wagAngle) * 20,
    );
    canvas.drawPath(path, paint);

    // Tail tip
    canvas.drawCircle(
      Offset(55 + math.cos(wagAngle) * 35, -10 + math.sin(wagAngle) * 20),
      9,
      Paint()..color = _accentColor..style = PaintingStyle.fill,
    );
  }

  // ─── State-specific overlays ──────────────────────────────────────────────
  void _drawStateOverlay(Canvas canvas, Size size) {
    switch (state) {
      case PetState.listen:
        _drawSoundWaves(canvas);
        break;
      case PetState.gift:
        _drawSparkles(canvas);
        break;
      case PetState.anxious:
        _drawSweatDrop(canvas);
        break;
      case PetState.happy:
        _drawHearts(canvas);
        break;
      default:
        break;
    }
  }

  void _drawSoundWaves(Canvas canvas) {
    final paint = Paint()
      ..color = const Color(0xFFCE93D8).withValues(alpha: 0.7)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (int i = 1; i <= 3; i++) {
      canvas.drawArc(
        Rect.fromCenter(center: const Offset(-55, -28), width: i * 16.0, height: i * 16.0),
        -math.pi / 3, math.pi * 0.8, false, paint,
      );
    }
  }

  void _drawSparkles(Canvas canvas) {
    final paint = Paint()..color = Colors.amber..style = PaintingStyle.fill;
    for (final pos in [const Offset(-50, -50), const Offset(50, -45), const Offset(-45, 10)]) {
      _drawStar(canvas, pos, 6, paint);
    }
  }

  void _drawStar(Canvas canvas, Offset center, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = (i * 4 * math.pi / 5) - math.pi / 2;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawSweatDrop(Canvas canvas) {
    final paint = Paint()..color = Colors.lightBlue.withValues(alpha: 0.8)..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(48, -55)
      ..quadraticBezierTo(54, -45, 48, -38)
      ..quadraticBezierTo(42, -45, 48, -55);
    canvas.drawPath(path, paint);
  }

  void _drawHearts(Canvas canvas) {
    final paint = Paint()..color = Colors.pink.withValues(alpha: 0.8)..style = PaintingStyle.fill;
    for (final pos in [const Offset(-48, -58), const Offset(48, -52)]) {
      _drawHeart(canvas, pos, 8, paint);
    }
  }

  void _drawHeart(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    path.moveTo(center.dx, center.dy + size * 0.3);
    path.cubicTo(center.dx, center.dy - size * 0.3, center.dx - size, center.dy - size * 0.3, center.dx - size, center.dy + size * 0.1);
    path.cubicTo(center.dx - size, center.dy + size * 0.6, center.dx, center.dy + size, center.dx, center.dy + size * 1.2);
    path.cubicTo(center.dx, center.dy + size, center.dx + size, center.dy + size * 0.6, center.dx + size, center.dy + size * 0.1);
    path.cubicTo(center.dx + size, center.dy - size * 0.3, center.dx, center.dy - size * 0.3, center.dx, center.dy + size * 0.3);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CatPainter old) =>
      old.state != state ||
      old.breathValue != breathValue ||
      old.blinkValue != blinkValue ||
      old.tailValue != tailValue ||
      old.earValue != earValue ||
      old.bounceValue != bounceValue;
}
