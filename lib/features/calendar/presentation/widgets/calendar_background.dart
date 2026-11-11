import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'calendar_colors.dart';

class CalendarBackground extends StatelessWidget {
  final Widget child;

  const CalendarBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: CalendarColors.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: CalendarColors.background,
        body: Stack(
          children: [
            const Positioned(
              top: -160,
              left: -190,
              child: _Glow(color: CalendarColors.glowPurple, size: 500),
            ),
            const Positioned(
              top: 120,
              right: -250,
              child: _Glow(color: CalendarColors.glowBlue, size: 430),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  final Color color;
  final double size;

  const _Glow({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ui.ImageFilter.blur(sigmaX: 75, sigmaY: 75),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            radius: 0.75,
            colors: [
              color.withValues(alpha: 0.48),
              color.withValues(alpha: 0.28),
              color.withValues(alpha: 0.10),
              Colors.transparent,
            ],
            stops: const [0, 0.35, 0.70, 1],
          ),
        ),
      ),
    );
  }
}
