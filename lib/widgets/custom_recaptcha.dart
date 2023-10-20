import 'dart:math';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRecaptcha extends StatelessWidget {
  final String? recaptcha;

  const CustomRecaptcha({Key? key, this.recaptcha}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      // // Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.4),
      child: CustomPaint(
        painter: RecaptchaPaint(
          recaptcha: recaptcha,
        ),
      ),
    );
  }
}

class RecaptchaPaint extends CustomPainter {
  final String? recaptcha;

  RecaptchaPaint({this.recaptcha});

  // random color
  Color randomColor() {
    // min-50, max-160
    int r = 50 + Random().nextInt(160 - 50);
    int g = 50 + Random().nextInt(160 - 50);
    int b = 50 + Random().nextInt(160 - 50);
    return Color.fromRGBO(r, g, b, 1);
  }

  // random number
  int randomNumber({required int max, required int min}) {
    return min + Random().nextInt(max - min);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // info >>>
    List<String>? txt = recaptcha?.split('');
    int? txtLength = recaptcha?.length ?? 6; // set default if null - 6
    double contentWidth = size.width;
    double contentHeight = size.height;
    double minFontSize = 18.sp;
    double maxFontSize = 26.sp;

    // 绘制
    RRect rect = RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topRight: const Radius.circular(5),
        bottomRight: const Radius.circular(5)
    );
    canvas.drawRRect(rect, Paint()
      ..color = randomColor().withOpacity(0.4)
      ..style = PaintingStyle.fill);


    // 绘制文字
    for (int i = 0; i < txtLength; i++) {
      Color clr = randomColor();
      double fontSize =
      randomNumber(max: maxFontSize.floor(), min: minFontSize.floor())
          .toDouble();

      final textStyle = TextStyle(
        color: clr,
        fontSize: fontSize,
      );
      final textSpan = TextSpan(
        text: txt?[i] ?? '',
        style: textStyle,
      );
      // Offset dx,dy
      double dx = (i + 0.2.w) * (contentWidth / txtLength - 0.2.w); // +0.2, -0.2 <-- for padding left & right a little
      double dy =
      randomNumber(max: maxFontSize.floor(), min: 3.h.floor()).toDouble();
      const offset = Offset.zero;

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      // 角度
      int deg = randomNumber(max: 30, min: -30);
      double angle = deg * math.pi / 270;

      // 修改坐标原点和旋转角度
      canvas.translate(dx, dy);
      canvas.rotate(angle);
      textPainter.paint(canvas, offset);
      // 恢复坐标原点和旋转角度
      canvas.rotate(-angle);
      canvas.translate(-dx, -dy);
    }

    // 绘制干扰点 - 50
    for (int i = 0; i < 50; i++) {
      // offset dx,dy
      double dx = randomNumber(max: contentWidth.floor(), min: 5).toDouble();
      double dy = randomNumber(max: contentHeight.floor(), min: 5).toDouble();

      final paint = Paint()
        ..color = randomColor()
        ..strokeWidth = randomNumber(max: 4, min: 1).toDouble()
        ..strokeCap = StrokeCap.round;

      canvas.drawPoints(ui.PointMode.points, [Offset(dx, dy)], paint);
    }

    // 绘制干扰线 - 6
    for (int i = 0; i < 6; i++) {
      // Offset dx,dy
      double p1dx = randomNumber(max: contentWidth.floor(), min: 5).toDouble();
      double p1dy = randomNumber(max: contentHeight.floor(), min: 5).toDouble();
      double p2dx = randomNumber(max: contentWidth.floor(), min: 5).toDouble();
      double p2dy = randomNumber(max: contentHeight.floor(), min: 5).toDouble();
      // line points
      Offset p1 = Offset(p1dx, p1dy);
      Offset p2 = Offset(p2dx, p2dy);

      final paint = Paint()
        ..color = randomColor()
        ..strokeWidth = Random().nextDouble(); // nextDouble -> 0.0 to 1.0

      canvas.drawLine(p1, p2, paint);
    }

  }

  @override
  bool shouldRepaint(covariant RecaptchaPaint  oldDelegate) {
    return recaptcha != oldDelegate.recaptcha;
  }

}
