import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:plataforma_educacional/core/data/flaky_repository.dart';
import 'package:plataforma_educacional/features/ai_chat/data/chat_repository.dart';
import 'package:plataforma_educacional/features/ai_chat/data/in_memory_chat_repository.dart';
import 'package:plataforma_educacional/features/ai_chat/data/sqlite_chat_repository.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/controllers/chat_controller.dart';
import 'package:plataforma_educacional/features/auth/presentation/controllers/auth_controller.dart';
import 'package:plataforma_educacional/features/calendar/data/activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/data/in_memory_activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/data/sqlite_activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/presentation/controllers/activity_controller.dart';
import 'package:plataforma_educacional/features/friends/data/friend_repository.dart';
import 'package:plataforma_educacional/features/friends/data/in_memory_friend_repository.dart';
import 'package:plataforma_educacional/features/friends/presentation/controllers/friend_controller.dart';
import 'package:plataforma_educacional/features/planner/data/planner_repository.dart';
import 'package:plataforma_educacional/features/planner/data/in_memory_planner_repository.dart';
import 'package:plataforma_educacional/features/planner/presentation/controllers/planner_controller.dart';
import 'package:plataforma_educacional/features/settings/data/notification_repository.dart';
import 'package:plataforma_educacional/features/settings/data/in_memory_notification_repository.dart';
import 'package:plataforma_educacional/features/settings/data/sqlite_notification_repository.dart';
import 'package:plataforma_educacional/features/settings/presentation/controllers/notification_controller.dart';
import 'package:plataforma_educacional/features/study_groups/data/group_repository.dart';
import 'package:plataforma_educacional/features/study_groups/data/in_memory_group_repository.dart';
import 'package:plataforma_educacional/features/study_groups/data/sqlite_group_repository.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/controllers/group_controller.dart';
import 'package:plataforma_educacional/features/teachers/data/teacher_repository.dart';
import 'package:plataforma_educacional/features/teachers/data/in_memory_teacher_repository.dart';
import 'package:plataforma_educacional/features/teachers/presentation/controllers/teacher_controller.dart';
import 'package:plataforma_educacional/features/workload/data/workload_repository.dart';
import 'package:plataforma_educacional/features/workload/data/in_memory_workload_repository.dart';
import 'package:plataforma_educacional/features/workload/presentation/controllers/workload_controller.dart';

/// Repositórios injetáveis: os de calendário/grupos/lembretes/chat têm versão SQLite.
class AppRepositories {
  AppRepositories({
    ActivityRepository? activities,
    GroupRepository? groups,
    FriendRepository? friends,
    TeacherRepository? teachers,
    PlannerRepository? planner,
    WorkloadRepository? workload,
    NotificationRepository? notifications,
    ChatRepository? chat,
    this.preferences,
  }) : activities = FlakyActivityRepository(
         activities ?? InMemoryActivityRepository(),
       ),
       groups = groups ?? InMemoryGroupRepository(),
       friends = friends ?? InMemoryFriendRepository(),
       teachers = teachers ?? InMemoryTeacherRepository(),
       planner = planner ?? InMemoryPlannerRepository(),
       workload = workload ?? InMemoryWorkloadRepository(),
       notifications = notifications ?? InMemoryNotificationRepository(),
       chat = chat ?? InMemoryChatRepository();

  factory AppRepositories.sqlite(
    Database db, {
    SharedPreferences? preferences,
  }) => AppRepositories(
    activities: SqliteActivityRepository(db),
    groups: SqliteGroupRepository(db),
    notifications: SqliteNotificationRepository(db),
    chat: SqliteChatRepository(db),
    preferences: preferences,
  );

  final ActivityRepository activities;
  final GroupRepository groups;
  final FriendRepository friends;
  final TeacherRepository teachers;
  final PlannerRepository planner;
  final WorkloadRepository workload;
  final NotificationRepository notifications;
  final ChatRepository chat;
  final SharedPreferences? preferences;
}

class AppProviders extends StatelessWidget {
  const AppProviders({
    super.key,
    required this.child,
    this.repositories,
    this.authController,
  });
  final Widget child;
  final AppRepositories? repositories;
  final AuthController? authController;

  @override
  Widget build(BuildContext context) {
    final repos = repositories ?? AppRepositories();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (_) => authController ?? AuthController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ActivityController(repos.activities)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => GroupController(repos.groups)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => FriendController(repos.friends)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => TeacherController(repos.teachers)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlannerController(repos.planner)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkloadController(repos.workload)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationController(
            repos.notifications,
            preferences: repos.preferences,
          )..load(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ChatController(repos.chat, context.read<ActivityController>())
                ..load(),
        ),
      ],
      child: child,
    );
  }
}
