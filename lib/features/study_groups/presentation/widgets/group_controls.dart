import 'package:flutter/material.dart';

import 'package:plataforma_educacional/shared/widgets/gradient_button.dart';

class GroupButton extends StatelessWidget {
  const GroupButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => GradientButton(
    label: text,
    onPressed: onPressed,
    icon: icon,
    width: double.infinity,
  );
}
