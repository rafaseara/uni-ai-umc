import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'friends_colors.dart';

class FriendsBackground extends StatelessWidget {
  final Widget child;

  const FriendsBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: FriendsColors.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: FriendsColors.background,
        body: Stack(
          children: [
            const Positioned(
              top: -160,
              left: -190,
              child: _FriendsGlow(color: FriendsColors.glowPurple, size: 500),
            ),
            const Positioned(
              top: 100,
              right: -250,
              child: _FriendsGlow(color: FriendsColors.glowBlue, size: 430),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}

class _FriendsGlow extends StatelessWidget {
  final Color color;
  final double size;

  const _FriendsGlow({required this.color, required this.size});

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

class FriendsHeader extends StatelessWidget {
  const FriendsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: IconButton(
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(
                Icons.chevron_left,
                size: 23,
                color: FriendsColors.white,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Uni',
                      style: TextStyle(color: FriendsColors.white),
                    ),
                    TextSpan(
                      text: 'A.I.',
                      style: TextStyle(color: FriendsColors.purple),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 44,
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/notificacoes'),
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: FriendsColors.white,
                size: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
