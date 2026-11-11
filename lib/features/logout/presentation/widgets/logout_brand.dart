import 'package:flutter/material.dart';

import 'logout_colors.dart';

class LogoutBrand extends StatelessWidget {
  const LogoutBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: LogoutColors.background.withValues(alpha: 0.55),
            border: Border.all(color: LogoutColors.purple, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [
                      LogoutColors.cyan,
                      LogoutColors.purple,
                      LogoutColors.pink,
                    ],
                  ).createShader(bounds);
                },
                child: const Icon(
                  Icons.school_outlined,
                  color: Colors.white,
                  size: 39,
                ),
              ),
              const SizedBox(height: 2),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Uni',
                      style: TextStyle(color: LogoutColors.white),
                    ),
                    TextSpan(
                      text: 'A.I.',
                      style: TextStyle(color: LogoutColors.purple),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Seu universo de estudos,\nconectado.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: LogoutColors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class LogoutGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LogoutGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF8319A7), Color(0xFF2357BA)],
        ),
        border: Border.all(color: LogoutColors.purple.withValues(alpha: 0.35)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: LogoutColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
