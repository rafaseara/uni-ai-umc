import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/theme/app_colors.dart';
import 'package:plataforma_educacional/features/home/presentation/widgets/home_info_chip.dart';

class HomeGreeting extends StatelessWidget {
  const HomeGreeting({super.key, required this.name, required this.date});
  final String name;
  final String date;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Olá, $name!', style: const TextStyle(
        color: AppColors.textPrimary, fontSize: 26, fontWeight: FontWeight.w800)),
      const SizedBox(height: 6),
      const Text('Um passo de cada vez. Vamos estudar?',
        style: TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.4)),
      const SizedBox(height: 14),
      Wrap(spacing: 8, runSpacing: 8, children: [
        HomeInfoChip(label: date),
        const HomeInfoChip(label: 'Seu espaço de estudos', color: AppColors.blue),
      ]),
    ]),
  );
}
