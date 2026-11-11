import 'package:plataforma_educacional/core/navigation/app_routes.dart';

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_background.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_logo.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/gradient_button.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/page_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (!email.contains('@') || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informe um e-mail e uma senha para continuar.'),
        ),
      );
      return;
    }
    // Navegação DEMONSTRATIVA. Ainda NÃO existe autenticação.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Modo demonstração: login sem autenticação real.'),
      ),
    );
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
  }

  void _onResetPasswordPressed() {
    Navigator.pushNamed(context, AppRoutes.verifyCode);
  }

  void _onForgotPasswordPressed() {
    Navigator.pushNamed(context, AppRoutes.verifyCode);
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final logoSize = math.min(constraints.maxWidth * 0.40, 170.0);

          // ConstrainedBox + IntrinsicHeight: o conteúdo ocupa a tela toda
          // (o Spacer empurra o botão para baixo) e ainda rola com o teclado.
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Center(child: AuthLogo(size: logoSize)),
                    const SizedBox(height: 60),
                    AuthTextField(
                      label: 'E-mail',
                      hint: 'voce@email.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      label: 'Senha',
                      hint: 'Sua senha',
                      controller: _passwordController,
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _LinkText(
                          text: 'Redefinir senha',
                          onTap: _onResetPasswordPressed,
                        ),
                        _LinkText(
                          text: 'Esqueci a senha',
                          onTap: _onForgotPasswordPressed,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Center(
                      child: GradientButton(
                        label: 'ENTRAR',
                        onPressed: _onLoginPressed,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const PageIndicator(activeIndex: 1),
                    const SizedBox(height: 75),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Link pequeno em azul (só esta tela usa, por isso fica privado aqui)
class _LinkText extends StatelessWidget {
  const _LinkText({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: AuthColors.blue,
        minimumSize: const Size(44, 44),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}
