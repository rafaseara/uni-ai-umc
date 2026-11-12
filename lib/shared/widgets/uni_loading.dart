import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';

class UniLoading extends StatelessWidget {
  const UniLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 176,
      child: Center(child: CircularProgressIndicator(color: AppColors.blue)),
    );
  }
}
