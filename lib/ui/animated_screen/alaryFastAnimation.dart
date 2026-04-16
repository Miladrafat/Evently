import 'package:flutter/material.dart';

class AnimatedSquareBorder extends StatefulWidget {
  static const routeName="AnimatedSquareBorder";
  const AnimatedSquareBorder({super.key});

  @override
  State<AnimatedSquareBorder> createState() => _AnimatedSquareBorderState();
}

class _AnimatedSquareBorderState extends State<AnimatedSquareBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> leftAnim;
  late Animation<double> topAnim;
  late Animation<double> bottomAnim;
  late Animation<double> rightAnim;
  late Animation<double> glowAnim;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    leftAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.0, .2)),
    );

    topAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(.2, .4)),
    );

    bottomAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(.4, .6)),
    );

    rightAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(.6, .8)),
    );

    glowAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(.8, 1.0)),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return CustomPaint(
              size: const Size(125, 125),
              painter: SquarePainter(
                leftAnim.value,
                topAnim.value,
                bottomAnim.value,
                rightAnim.value,
                glowAnim.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

class SquarePainter extends CustomPainter {
  final double leftProgress;
  final double topProgress;
  final double bottomProgress;
  final double rightProgress;
  final double glowProgress;

  SquarePainter(
    this.leftProgress,
    this.topProgress,
    this.bottomProgress,
    this.rightProgress,
    this.glowProgress,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    const stroke = 5.0;
    final leftX = w * .35;
    final rightX = w * .65;
    final topY = h * .35;
    final bottomY = h * .65;

    final leftPaint = Paint()
      ..color =Colors.red
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    final topPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    final bottomPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    final rightPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    /// LEFT - يبدأ من خارج الشاشة بشكل كامل
    canvas.drawLine(
      Offset(leftX - (w * 2 * (1 - leftProgress)), topY),
      Offset(leftX - (w * 2 * (1 - leftProgress)), bottomY),
      leftPaint,
    );

    /// TOP - يبدأ من خارج الشاشة بشكل كامل
    canvas.drawLine(
      Offset(leftX, topY - (h * 3 * (1 - topProgress))),
      Offset(rightX, topY - (h * 3 * (1 - topProgress))),
      topPaint,
    );

    /// BOTTOM - يبدأ من خارج الشاشة بشكل كامل
    canvas.drawLine(
      Offset(leftX, bottomY + (h * 3 * (1 - bottomProgress))),
      Offset(rightX, bottomY + (h * 3 * (1 - bottomProgress))),
      bottomPaint,
    );

    /// RIGHT - يبدأ من خارج الشاشة بشكل كامل
    canvas.drawLine(
      Offset(rightX + (w * 2* (1 - rightProgress)), topY),
      Offset(rightX + (w * 2 * (1 - rightProgress)), bottomY),
      rightPaint,
    );

    /// GLOW كما في الكود الأصلي
    final glowPaint = Paint()
      ..color =Colors.white
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(rightX, topY);
    path.lineTo(rightX, bottomY);
    path.lineTo(leftX, bottomY);
    path.lineTo(leftX, topY);
    final metric = path.computeMetrics().first;
    final glowPath = metric.extractPath(0, metric.length * glowProgress);
    canvas.drawPath(glowPath, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
