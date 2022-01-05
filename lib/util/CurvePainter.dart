import 'package:flutter/material.dart';

class CurvePainter extends CustomClipper  {
  // @override
  // void paint(Canvas canvas, Size size) {
  //   var paint = Paint();
  //   paint.color = Colors.green[800];
  //   paint.style = PaintingStyle.fill; // Change this to fill
  //
  //   var path = Path();
  //
  //   path.moveTo(0, size.height * 0.25);
  //   path.quadraticBezierTo(
  //       size.width / 2, size.height / 2, size.width, size.height * 0.25);
  //   path.lineTo(size.width, 0);
  //   path.lineTo(0, 0);
  //
  //   canvas.drawPath(path, paint);
  //
  //
  // }
  //
  // @override
  // bool shouldRepaint(CustomPainter oldDelegate) {
  //   return true;
  // }

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    path.lineTo(0, 300);
    path.lineTo(325, 0);
    path.lineTo(size.width - 300, size.height - 500);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}