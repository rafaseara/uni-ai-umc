import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_logo.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/page_indicator.dart';
import 'package:plataforma_educacional/shared/uni_validators.dart';
import 'package:plataforma_educacional/shared/widgets/gradient_button.dart';
import 'package:plataforma_educacional/shared/widgets/uni_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _busy = false;
  String? _loginError;

  Future<void> _onLoginPressed() async {
    if (_busy) return;
    setState(() => _loginError = null);
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    final controller = context.read<AuthController>();
    final success = await controller.login(
      _emailController.text,
      _passwordController.text,
    );
    if (!mounted) return;
    setState(() {
      _busy = false;
      _loginError = controller.lastError;
    });
    if (success) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
    } else {
      _formKey.currentState?.validate();
    }
  }

  void _onForgotPasswordPressed() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recuperação de senha indisponível no modo local.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UniBackground(
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        tooltip: 'Voltar',
                        icon: const Icon(
                          Icons.chevron_left,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () {
                          final navigator = Navigator.of(context);
                          if (navigator.canPop()) {
                            navigator.pop();
                          } else {
                            navigator.pushReplacementNamed(AppRoutes.welcome);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(child: AuthLogo(size: logoSize)),
                    const SizedBox(height: 60),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AuthTextField(
                            label: 'E-mail',
                            hint: 'voce@email.com',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: UniValidators.email,
                          ),
                          const SizedBox(height: 20),
                          AuthTextField(
                            label: 'Senha',
                            hint: 'Sua senha',
                            controller: _passwordController,
                            isPassword: true,
                            textInputAction: TextInputAction.done,
                            validator: (value) =>
                                _loginError ??
                                UniValidators.nonEmpty(value, 'sua senha'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _LinkText(
                        text: 'Esqueci a senha',
                        onTap: _onForgotPasswordPressed,
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: GradientButton(
                        label: 'ENTRAR',
                        onPressed: _busy ? null : _onLoginPressed,
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
        foregroundColor: AppColors.blue,
        minimumSize: const Size(44, 44),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}
