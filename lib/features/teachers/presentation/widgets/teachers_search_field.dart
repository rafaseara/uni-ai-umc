import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_colors.dart';

class TeachersSearchField extends StatelessWidget {
  const TeachersSearchField({super.key, this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AuthColors.blue,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Buscar por nome ou área',
        hintStyle: const TextStyle(color: AuthColors.hint, fontSize: 14),
        prefixIcon: const Icon(Icons.search, color: AuthColors.hint, size: 20),
        filled: true,
        fillColor: TeachersColors.card,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: TeachersColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AuthColors.blue),
        ),
      ),
    );
  }
}