import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_form_layout.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    // TODO: validar os campos e avançar
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormLayout(
      activeIndex: 2,
      indicatorCount: 3,
      onContinue: _onContinuePressed,
      children: [
        AuthTextField(
          label: 'Nome de Usuário',
          hint: '@usuario',
          controller: _usernameController,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 28),
        AuthTextField(
          label: 'E-mail',
          hint: 'voce@email.com',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 28),
        AuthTextField(
          label: 'Data de Nascimento',
          hint: 'DD/MM/AAAA',
          controller: _birthDateController,
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}