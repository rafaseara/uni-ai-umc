import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';

/// Logo UniA.I. com contorno circular em degradê e interior transparente.
class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LogoBorderPainter(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.textMuted.withValues(alpha: 0.12),
        ),
        child: Padding(
          padding: EdgeInsets.all(size * 0.09),
          child: Image.asset(
            'assets/images/uniai_logo.webp',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Erro ao carregar a logo: $error');

              return const Center(
                child: Text(
                  'UniA.I.',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Desenha exclusivamente o contorno circular em degradê.
class _LogoBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 1.3;

    final rect = Offset.zero & size;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.pink, AppColors.logoRingMiddle, AppColors.blue],
      ).createShader(rect);

    final borderRect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    canvas.drawOval(borderRect, paint);
  }

  @override
  bool shouldRepaint(covariant _LogoBorderPainter oldDelegate) => false;
}
