import 'package:flutter/material.dart';
import 'package:plataforma_educacional/shared/uni_validators.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_form_layout.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_text_field.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Verificação de código indisponível na autenticação local.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormLayout(
      formKey: _formKey,
      showLogo: true,
      activeIndex: 0,
      indicatorCount: 2,
      onContinue: _onContinuePressed,
      children: [
        const Text(
          'INSIRA O CÓDIGO',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Recuperação de senha indisponível no modo local',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.blue, fontSize: 11),
        ),
        const SizedBox(height: 16),
        AuthTextField(
          hint: 'Ex: m@1242ma',
          controller: _codeController,
          validator: (value) => UniValidators.nonEmpty(value, 'o código'),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
