import 'package:plataforma_educacional/core/navigation/uni_module_shell.dart';
import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/navigation/modules_page.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/pages/chat_conversation_page.dart';
import 'package:plataforma_educacional/features/ai_chat/presentation/pages/chat_page.dart';
import 'package:plataforma_educacional/features/auth/presentation/pages/login_page.dart';
import 'package:plataforma_educacional/features/auth/presentation/pages/new_password_page.dart';
import 'package:plataforma_educacional/features/auth/presentation/pages/sign_up_page.dart';
import 'package:plataforma_educacional/features/auth/presentation/pages/verify_code_page.dart';
import 'package:plataforma_educacional/features/auth/presentation/pages/welcome_page.dart';
import 'package:plataforma_educacional/features/calendar/presentation/pages/calendar_page.dart';
import 'package:plataforma_educacional/features/friends/presentation/pages/friends_page.dart';
import 'package:plataforma_educacional/features/home/presentation/pages/home_page.dart';
import 'package:plataforma_educacional/features/logout/presentation/pages/logout_entry_page.dart';
import 'package:plataforma_educacional/features/logout/presentation/pages/logout_success_page.dart';
import 'package:plataforma_educacional/features/planner/presentation/pages/weekly_planner_page.dart';
import 'package:plataforma_educacional/features/profile/presentation/pages/profile_menu_page.dart';
import 'package:plataforma_educacional/features/profile/presentation/pages/profile_page.dart';
import 'package:plataforma_educacional/features/settings/presentation/pages/notifications_page.dart';
import 'package:plataforma_educacional/features/settings/presentation/pages/settings_page.dart';
import 'package:plataforma_educacional/features/study_groups/presentation/pages/study_groups_page.dart';
import 'package:plataforma_educacional/features/teachers/presentation/pages/teacher_plans_page.dart';
import 'package:plataforma_educacional/features/teachers/presentation/pages/teacher_profile_page.dart';
import 'package:plataforma_educacional/features/teachers/presentation/pages/teachers_page.dart';
import 'package:plataforma_educacional/features/workload/presentation/pages/workload_page.dart';

/// Rotas centralizadas da interface. O login ainda é demonstrativo.
class AppRoutes {
  AppRoutes._();

  static const welcome = '/';
  static const login = '/login';
  static const signUp = '/cadastro';
  static const verifyCode = '/verificar-codigo';
  static const newPassword = '/nova-senha';
  static const home = '/home';
  static const modules = '/modulos';
  static const calendar = '/calendario';
  static const groups = '/grupos';
  static const friends = '/amigos';
  static const profileMenu = '/menu-perfil';
  static const profile = '/perfil';
  static const chat = '/chat';
  static const chatConversation = '/chat/conversa';
  static const teachers = '/professores';
  static const teacherProfile = '/professores/perfil';
  static const teacherPlans = '/professores/planos';
  static const planner = '/planejamento';
  static const workload = '/sobrecarga';
  static const settings = '/configuracoes';
  static const notifications = '/notificacoes';
  static const logoutEntry = '/saida';
  static const logoutSuccess = '/saida/concluida';

  static Map<String, WidgetBuilder> get routes => {
    welcome: (_) => const WelcomePage(),
    login: (_) => const LoginPage(),
    signUp: (_) => const SignUpPage(),
    verifyCode: (_) => const VerifyCodePage(),
    newPassword: (_) => const NewPasswordPage(),
    home: (context) => HomePage(
      userName:
          'Estudante', // Substituir pelo nome real após integrar autenticação.
      onMenu: () => Navigator.pushNamed(context, modules),
      onNotifications: () => Navigator.pushNamed(context, notifications),
      onCalendar: () => Navigator.pushNamed(context, calendar),
      onTeachers: () => Navigator.pushNamed(context, teachers),
      onGroups: () => Navigator.pushNamed(context, groups),
      onAiChat: () => Navigator.pushNamed(context, chat),
      onProfile: () => Navigator.pushNamed(context, profileMenu),
    ),
    modules: (_) => const UniModuleShell(currentIndex: 0, child: ModulesPage()),
    calendar: (_) =>
        const UniModuleShell(currentIndex: 3, child: CalendarPage()),
    groups: (_) => const StudyGroupsPage(),
    friends: (_) => const UniModuleShell(currentIndex: 4, child: FriendsPage()),
    profileMenu: (_) =>
        const UniModuleShell(currentIndex: 4, child: ProfileMenuPage()),
    profile: (_) => const UniModuleShell(currentIndex: 4, child: ProfilePage()),
    chat: (_) => const UniModuleShell(currentIndex: 2, child: ChatPage()),
    chatConversation: (_) => const ChatConversationPage(),
    teachers: (_) =>
        const UniModuleShell(currentIndex: 0, child: TeachersPage()),
    teacherProfile: (_) => const TeacherProfilePage(),
    teacherPlans: (_) => const TeacherPlansPage(),
    planner: (_) =>
        const UniModuleShell(currentIndex: 0, child: WeeklyPlannerPage()),
    workload: (_) =>
        const UniModuleShell(currentIndex: 0, child: WorkloadPage()),
    settings: (_) =>
        const UniModuleShell(currentIndex: 4, child: SettingsPage()),
    notifications: (_) =>
        const UniModuleShell(currentIndex: 4, child: NotificationsPage()),
    logoutEntry: (context) => LogoutEntryPage(
      onLogin: () => Navigator.pushNamed(context, login),
      onRegister: () => Navigator.pushNamed(context, signUp),
    ),
    logoutSuccess: (_) => const LogoutSuccessPage(),
  };
}
