import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Identidade visual
const _background = Color(0xFF171719);
const _blue = Color(0xFF00BFFF);
const _pink = Color(0xFFE500C5);

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _onLoginPressed() {
    // TODO: Navegar para login
  }

  void _onSignUpPressed() {
    // TODO: Navegar para cadastro
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: _background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
        body: Stack(
          children: [
            // Fundo
            const Positioned.fill(child: ColoredBox(color: _background)),

            // Iluminação roxa superior esquerda
            Positioned(
              top: -160,
              left: -190,
              child: _Glow(color: const Color(0xFF9415B5), size: 500),
            ),

            // Iluminação azul inferior direita
            Positioned(
              bottom: 190,
              right: -210,
              child: _Glow(color: const Color(0xFF007BA4), size: 500),
            ),

            // Conteúdo
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final logoSize = math.min(
                    constraints.maxWidth * 0.82,
                    constraints.maxHeight * 0.42,
                  );

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 48),

                        // Logo
                        _LoginLogo(size: logoSize),

                        const Spacer(),

                        // Grupo de ações
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Botão entrar
                            _GradientButton(onPressed: _onLoginPressed),

                            const SizedBox(height: 32),

                            // Indicadores de página
                            const _PageIndicator(),

                            const SizedBox(height: 20),

                            // Criar conta
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Não possui uma conta? ',
                                  style: TextStyle(
                                    color: Color(0xFFCCCCCC),
                                    fontSize: 13,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _onSignUpPressed,
                                  child: const Text(
                                    'Criar uma conta',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 75),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Iluminação difusa do fundo
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
              color.withValues(alpha: 0.0),
            ],
            stops: const [0.0, 0.35, 0.70, 1.0],
          ),
        ),
      ),
    );
  }
}

// Logo com contorno em degradê
class _LoginLogo extends StatelessWidget {
  final double size;

  const _LoginLogo({required this.size});

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
          colors: [_pink, Color(0xFF64118F), _blue],
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: _background,
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

// Indicadores de página
class _PageIndicator extends StatelessWidget {
  const _PageIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _dot(active: true),
        const SizedBox(width: 8),
        _dot(active: false),
        const SizedBox(width: 8),
        _dot(active: false),
      ],
    );
  }

  Widget _dot({required bool active}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: active ? _blue : const Color(0xFF333333),
        shape: BoxShape.circle,
      ),
    );
  }
}

// Botão com borda em degradê
class _GradientButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _GradientButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 46,
      padding: const EdgeInsets.all(1.2),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(colors: [_pink, _blue]),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _background,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: const StadiumBorder(),
        ),
        child: const Text(
          'ENTRAR',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
