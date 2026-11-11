import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_form_layout.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_text_field.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    final password = _passwordController.text;
    if (password.length < 6 || password != _confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'As senhas devem coincidir e ter ao menos 6 caracteres.',
          ),
        ),
      );
      return;
    }
    // Apenas demonstração: nenhum cadastro ou senha foi salvo.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fluxo demonstrativo: a senha não foi salva.'),
      ),
    );
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormLayout(
      showLogo: true,
      activeIndex: 1,
      indicatorCount: 2,
      onContinue: _onContinuePressed,
      children: [
        AuthTextField(
          label: 'Senha Nova',
          hint: 'Ex: uniA.I2026',
          controller: _passwordController,
          isPassword: true,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 20),
        AuthTextField(
          label: 'Confirme Senha',
          hint: 'Ex: uniA.I2026',
          controller: _confirmController,
          isPassword: true,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
