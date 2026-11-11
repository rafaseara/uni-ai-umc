import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';

class UniBackground extends StatelessWidget {
  const UniBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            const Positioned(
              top: -160,
              left: -190,
              child: _Glow(color: AppColors.glowPurple, size: 500),
            ),
            const Positioned(
              bottom: 190,
              right: -210,
              child: _Glow(color: AppColors.glowBlue, size: 500),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});

  final Color color;
  final double size;

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
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.35, 0.70, 1.0],
          ),
        ),
      ),
    );
  }
}
