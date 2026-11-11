import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/core/navigation/app_routes.dart';
import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';
import 'package:plataforma_educacional/features/home/presentation/widgets/home_activity_section.dart';
import 'package:plataforma_educacional/features/home/presentation/widgets/home_greeting.dart';
import 'package:plataforma_educacional/features/home/presentation/widgets/home_support_section.dart';
import 'package:plataforma_educacional/shared/widgets/uni_background.dart';
import 'package:plataforma_educacional/shared/widgets/uni_loading.dart';
import 'package:plataforma_educacional/shared/widgets/uni_error_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_page_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _formatDate(DateTime date) {
    const weekdays = ['Segunda-feira','Terça-feira','Quarta-feira',
      'Quinta-feira','Sexta-feira','Sábado','Domingo'];
    const months = ['jan','fev','mar','abr','mai','jun',
      'jul','ago','set','out','nov','dez'];
    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final name = context.watch<AuthController>().studentName;
    final controller = context.watch<ActivityController>();
    final activities = controller.items;
    return UniBackground(
      child: Column(children: [
        UniPageHeader(onBack: () => Navigator.pushNamed(context, AppRoutes.modules)),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 24),
              HomeGreeting(name: name, date: _formatDate(DateTime.now())),
              const SizedBox(height: 20),
              if (controller.status == LoadStatus.error)
                UniErrorState(onRetry: controller.load)
              else if (controller.status == LoadStatus.loading ||
                       controller.status == LoadStatus.initial)
                const UniLoading()
              else
                HomeActivitySection(activity: activities.isEmpty ? null : activities.first),
              const SizedBox(height: 16),
              const HomeSupportSection(),
              const SizedBox(height: 24),
            ]),
          )),
        )),
      ]),
    );
  }
}
