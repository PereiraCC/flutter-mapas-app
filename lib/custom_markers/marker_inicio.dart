

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

    // Sombra
    final path = new Path();

    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);

    //Caja Blanca
    final cajaBlanca = Rect.fromLTWH(40, 20, size.width - 55, 80);
    canvas.drawRect(cajaBlanca, paint);

    //Caja Blanca
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;



}