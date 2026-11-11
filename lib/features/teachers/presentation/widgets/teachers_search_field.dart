import 'package:flutter/material.dart';

import 'package:plataforma_educacional/core/theme/app_colors.dart';

class TeachersSearchField extends StatelessWidget {
  const TeachersSearchField({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: AppColors.blue,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Buscar por nome ou área',
        hintStyle: const TextStyle(color: AppColors.hint, fontSize: 14),
        prefixIcon: const Icon(Icons.search, color: AppColors.hint, size: 20),
        filled: true,
        fillColor: AppColors.card,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.blue),
        ),
      ),
    );
  }
}
