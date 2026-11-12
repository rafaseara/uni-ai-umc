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
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _busy = false;
  String? _registerError;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _onContinuePressed() async {
    if (_busy) return;
    setState(() => _registerError = null);
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    final controller = context.read<AuthController>();
    final success = await controller.register(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    );
    if (!mounted) return;
    setState(() {
      _busy = false;
      _registerError = controller.lastError;
    });
    if (success) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
    } else {
      _formKey.currentState?.validate();
    }
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
          validator: (value) =>
              UniValidators.nonEmpty(value, 'seu nome de usuário'),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 22),
        AuthTextField(
          label: 'E-mail',
          hint: 'voce@email.com',
          controller: _emailController,
          validator: (value) => _registerError ?? UniValidators.email(value),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 22),
        AuthTextField(
          label: 'Data de Nascimento',
          hint: 'DD/MM/AAAA',
          controller: _birthDateController,
          validator: UniValidators.birthDate,
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 22),
        AuthTextField(
          label: 'Senha',
          hint: 'Crie uma senha',
          controller: _passwordController,
          validator: UniValidators.password,
          isPassword: true,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 22),
        AuthTextField(
          label: 'Confirme sua senha',
          hint: 'Repita a senha',
          controller: _confirmController,
          isPassword: true,
          validator: (value) =>
              UniValidators.confirmPassword(value, _passwordController.text),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
