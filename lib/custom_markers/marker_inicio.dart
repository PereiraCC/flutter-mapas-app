

import 'package:flutter/material.dart';

class MarkerInicioPainter extends CustomPainter {

  final double circuloNegroR = 20;
  final double circuloBlancoR = 7;

  @override
  void paint(Canvas canvas, Size size) {
    
    Paint paint = new Paint()
      ..color = Colors.black;

    //Dibujar circulo negro
    canvas.drawCircle(
      Offset(circuloNegroR, size.height - circuloNegroR),
      20,
      paint
    );

    //Circulo blanco
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(circuloNegroR, size.height - circuloNegroR),
      circuloBlancoR,
      paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;



}