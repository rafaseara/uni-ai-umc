import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'logout_colors.dart';

class LogoutBackground extends StatelessWidget {
  final Widget child;

  const LogoutBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: LogoutColors.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: LogoutColors.background,
        body: Stack(
          children: [
            const Positioned(
              top: -160,
              left: -190,
              child: _LogoutGlow(color: LogoutColors.glowPurple, size: 500),
            ),
            const Positioned(
              top: 130,
              right: -250,
              child: _LogoutGlow(color: LogoutColors.glowBlue, size: 430),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}

class _LogoutGlow extends StatelessWidget {
  final Color color;
  final double size;

  const _LogoutGlow({required this.color, required this.size});

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
