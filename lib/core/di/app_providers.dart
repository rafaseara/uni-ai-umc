import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/features/calendar/data/in_memory_activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';
import 'package:plataforma_educacional/features/friends/data/in_memory_friend_repository.dart';
import 'package:plataforma_educacional/features/friends/presentation/controllers/friend_controller.dart';
import 'package:plataforma_educacional/features/planner/data/in_memory_planner_repository.dart';
import 'package:plataforma_educacional/features/planner/presentation/controllers/planner_controller.dart';
import 'package:plataforma_educacional/features/settings/data/in_memory_notification_repository.dart';
import 'package:plataforma_educacional/features/settings/presentation/controllers/notification_controller.dart';
import 'package:plataforma_educacional/features/study_groups/data/in_memory_group_repository.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/controllers/group_controller.dart';
import 'package:plataforma_educacional/features/teachers/data/in_memory_teacher_repository.dart';
import 'package:plataforma_educacional/features/teachers/presentation/controllers/teacher_controller.dart';
import 'package:plataforma_educacional/features/workload/data/in_memory_workload_repository.dart';
import 'package:plataforma_educacional/features/workload/presentation/controllers/workload_controller.dart';

/// Composição da aplicação: repositórios injetados uma vez por execução.
/// Quando houver SQLite, substitua apenas as implementações injetadas aqui.
class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ActivityController(InMemoryActivityRepository())..load()),
        ChangeNotifierProvider(create: (_) => GroupController(InMemoryGroupRepository())..load()),
        ChangeNotifierProvider(create: (_) => FriendController(InMemoryFriendRepository())..load()),
        ChangeNotifierProvider(create: (_) => TeacherController(InMemoryTeacherRepository())..load()),
        ChangeNotifierProvider(create: (_) => PlannerController(InMemoryPlannerRepository())..load()),
        ChangeNotifierProvider(create: (_) => WorkloadController(InMemoryWorkloadRepository())..load()),
        ChangeNotifierProvider(create: (_) => NotificationController(InMemoryNotificationRepository())..load()),
      ],
      child: child,
    );

}
