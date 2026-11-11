
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plataforma_educacional/features/profile/presentation/widgets/profile_colors.dart';

/// Fundo das telas de Profile do UniA.I.
class ProfileBackground extends StatelessWidget {
  const ProfileBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ProfileColors.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: ProfileColors.background,
        body: Stack(
          children: [
            // Iluminação roxa superior esquerda
            const Positioned(
              top: -160,
              left: -190,
              child: _Glow(
                color: ProfileColors.glowPurple,
                size: 500,
              ),
            ),

            // Iluminação azul na lateral direita
            const Positioned(
              bottom: 190,
              right: -210,
              child: _Glow(
                color: ProfileColors.glowBlue,
                size: 500,
              ),
            ),

            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}

/// Iluminação difusa usada apenas no Profile.
class _Glow extends StatelessWidget {
  const _Glow({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ui.ImageFilter.blur(
        sigmaX: 75,
        sigmaY: 75,
      ),
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
