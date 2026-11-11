import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_form_layout.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:plataforma_educacional/shared/uni_validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
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
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthController>().signIn(name: _usernameController.text);
    Navigator.pushNamed(context, AppRoutes.verifyCode);
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormLayout(
      formKey: _formKey,
      activeIndex: 2,
      indicatorCount: 3,
      onContinue: _onContinuePressed,
      children: [
        AuthTextField(
          label: 'Nome de Usuário',
          hint: '@usuario',
          controller: _usernameController,
          validator: (value) => UniValidators.nonEmpty(value, 'seu nome de usuário'),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 28),
        AuthTextField(
          label: 'E-mail',
          hint: 'voce@email.com',
          controller: _emailController,
          validator: UniValidators.email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 28),
        AuthTextField(
          label: 'Data de Nascimento',
          hint: 'DD/MM/AAAA',
          controller: _birthDateController,
          validator: UniValidators.birthDate,
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
