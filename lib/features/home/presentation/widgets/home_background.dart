import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key, required this.child});

  final Widget child;

  static const Color background = Color(0xFF171719);
  static const Color purple = Color(0xFF9415B5);
  static const Color blue = Color(0xFF007BA4);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: background,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Luz roxa difusa no canto superior esquerdo.
            const Positioned(
              top: -160,
              left: -190,
              child: _HomeGlow(color: purple, size: 500),
            ),

            // Luz azul difusa na lateral inferior direita.
            const Positioned(
              right: -210,
              bottom: 190,
              child: _HomeGlow(color: blue, size: 500),
            ),

            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}

class _HomeGlow extends StatelessWidget {
  const _HomeGlow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ImageFiltered(
        imageFilter: ui.ImageFilter.blur(
          sigmaX: 75,
          sigmaY: 75,
          tileMode: TileMode.decal,
        ),
        child: SizedBox(
          width: size,
          height: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                radius: 0.75,
                colors: [
                  color.withValues(alpha: 0.48),
                  color.withValues(alpha: 0.28),
                  color.withValues(alpha: 0.10),
                  color.withValues(alpha: 0.0),
                ],
                stops: const [0.0, 0.35, 0.70, 1.0],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
