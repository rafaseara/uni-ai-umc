import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';

/// Campo do login reaproveitado por todos os formulários de autenticação.
/// O erro de validação aparece junto ao campo, nunca apenas em um SnackBar.
class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    this.label,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.validator,
  });

  final String? label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final FormFieldValidator<String>? validator;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              widget.label!.toUpperCase(),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        CustomPaint(
          painter: _GradientBorderPainter(),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 52),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              obscureText: _obscure,
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: AppColors.blue,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                filled: false,
                hintText: widget.hint,
                hintStyle: const TextStyle(color: AppColors.hint, fontSize: 14),
                errorStyle: const TextStyle(
                  color: AppColors.warning,
                  fontSize: 12,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        tooltip: _obscure ? 'Mostrar senha' : 'Ocultar senha',
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.hint,
                          size: 20,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 1.3;
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = AppColors.gradient.createShader(rect);
    final borderRect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(borderRect, const Radius.circular(30)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
