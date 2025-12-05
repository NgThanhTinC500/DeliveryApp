import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class OfferDialog extends StatefulWidget {
  const OfferDialog({super.key});

  @override
  State<OfferDialog> createState() => _OfferDialogState();
}

class _OfferDialogState extends State<OfferDialog> with SingleTickerProviderStateMixin {
  late Timer _timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _timer = Timer(const Duration(seconds: 7), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 24),
          margin: const EdgeInsets.only(top: 10, right: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFF8BC34A),
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Confetti animation
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: ConfettiPainter(_animationController.value),
                    );
                  },
                ),
              ),
              // Content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Hurry Offers!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '#E02323',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        side: const BorderSide(color: Colors.white, width: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        'GOT IT',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.close,
                color: Colors.red,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ConfettiPainter extends CustomPainter {
  final double animationValue;
  final Random random = Random(42); // Fixed seed for consistent confetti positions

  ConfettiPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Generate confetti pieces
    for (int i = 0; i < 40; i++) {
      final randomSeed = i * 7;
      random.setSeed(randomSeed);

      final x = random.nextDouble() * size.width;
      final y = (random.nextDouble() * size.height + animationValue * size.height * 0.5) % size.height;
      final color = _getRandomColor(i);
      final shape = i % 4; // 4 different shapes

      paint.color = color;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(animationValue * 2 * pi + i);

      switch (shape) {
        case 0: // Triangle
          final path = Path()
            ..moveTo(0, -6)
            ..lineTo(-5, 4)
            ..lineTo(5, 4)
            ..close();
          canvas.drawPath(path, paint);
          break;
        case 1: // Rectangle
          canvas.drawRect(const Rect.fromLTWH(-4, -6, 8, 12), paint);
          break;
        case 2: // Diamond
          final path = Path()
            ..moveTo(0, -6)
            ..lineTo(4, 0)
            ..lineTo(0, 6)
            ..lineTo(-4, 0)
            ..close();
          canvas.drawPath(path, paint);
          break;
        case 3: // Parallelogram
          final path = Path()
            ..moveTo(-2, -5)
            ..lineTo(4, -5)
            ..lineTo(2, 5)
            ..lineTo(-4, 5)
            ..close();
          canvas.drawPath(path, paint);
          break;
      }

      canvas.restore();
    }
  }

  Color _getRandomColor(int index) {
    final colors = [
      const Color(0xFFE91E63), // Pink
      const Color(0xFF2196F3), // Blue
      const Color(0xFFFF9800), // Orange
      const Color(0xFF4CAF50), // Green
      const Color(0xFFF44336), // Red
      const Color(0xFF9C27B0), // Purple
      const Color(0xFFFFEB3B), // Yellow
      const Color(0xFF00BCD4), // Cyan
    ];
    return colors[index % colors.length];
  }

  @override
  bool shouldRepaint(ConfettiPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}

extension on Random {
  void setSeed(int seed) {
    // Tạo Random mới với seed cụ thể
    final newRandom = Random(seed);
    for (int i = 0; i < 3; i++) {
      newRandom.nextDouble();
    }
  }
}