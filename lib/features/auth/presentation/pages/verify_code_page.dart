import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_form_layout.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_text_field.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    if (_codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o código para continuar.')),
      );
      return;
    }
    // Código não validado em servidor: navegação de protótipo.
    Navigator.pushNamed(context, AppRoutes.newPassword);
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormLayout(
      showLogo: true,
      activeIndex: 0,
      indicatorCount: 2,
      onContinue: _onContinuePressed,
      children: [
        const Text(
          'INSIRA O CÓDIGO',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Enviado para: **********@gmail.com',
          textAlign: TextAlign.center,
          style: TextStyle(color: AuthColors.blue, fontSize: 11),
        ),
        const SizedBox(height: 16),
        AuthTextField(
          hint: 'Ex: m@1242ma',
          controller: _codeController,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
