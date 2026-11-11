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
    // TODO: validar as senhas e salvar
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