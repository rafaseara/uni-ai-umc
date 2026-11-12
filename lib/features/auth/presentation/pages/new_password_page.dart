import 'package:flutter/material.dart';
import 'package:plataforma_educacional/shared/uni_validators.dart';

import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_form_layout.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_text_field.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    if (!_formKey.currentState!.validate()) return;
    // Apenas demonstração: nenhum cadastro ou senha foi salvo.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Esta tela é apenas um protótipo; a senha não foi alterada.',
        ),
      ),
    );
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormLayout(
      formKey: _formKey,
      showLogo: true,
      activeIndex: 1,
      indicatorCount: 2,
      onContinue: _onContinuePressed,
      children: [
        AuthTextField(
          label: 'Senha Nova',
          hint: 'Ex: uniA.I2026',
          controller: _passwordController,
          validator: UniValidators.password,
          isPassword: true,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 20),
        AuthTextField(
          label: 'Confirme Senha',
          hint: 'Ex: uniA.I2026',
          controller: _confirmController,
          validator: (value) =>
              UniValidators.confirmPassword(value, _passwordController.text),
          isPassword: true,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
