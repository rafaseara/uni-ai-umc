import 'package:flutter/material.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_colors.dart';
import 'package:plataforma_educacional/features/auth/presentation/widgets/gradient_button.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_card.dart';
import 'package:plataforma_educacional/features/teachers/presentation/widgets/teachers_colors.dart';

class TeacherAvatar extends StatelessWidget {
  const TeacherAvatar({super.key, required this.initials, this.size = 44});

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white54),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.32,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class TeacherCard extends StatelessWidget {
  const TeacherCard({
    super.key,
    required this.initials,
    required this.name,
    required this.subject,
    required this.onViewProfile,
  });

  final String initials;
  final String name;
  final String subject;
  final VoidCallback onViewProfile;

  @override
  Widget build(BuildContext context) {
    return TeachersCard(
      child: Row(
        children: [
          TeacherAvatar(initials: initials),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subject,
                  style: const TextStyle(
                    color: AuthColors.textMuted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(Icons.circle, size: 6, color: TeachersColors.green),
                    SizedBox(width: 6),
                    Text(
                      'Aceita solicitações',
                      style: TextStyle(
                        color: TeachersColors.green,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GradientButton(
            label: 'Ver perfil',
            width: 96,
            height: 38,
            onPressed: onViewProfile,
          ),
        ],
      ),
    );
  }
}