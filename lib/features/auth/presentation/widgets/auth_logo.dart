import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';

/// Logo do UniA.I. dentro de um círculo com contorno em degradê.
class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(1.2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AuthColors.pink, AuthColors.logoRingMiddle, AuthColors.blue],
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AuthColors.background,
          shape: BoxShape.circle,
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
                    color: Colors.white,
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
