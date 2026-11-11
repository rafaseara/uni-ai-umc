import 'package:flutter/material.dart';

import 'package:plataforma_educacional/features/auth/presentation/widgets/auth_background.dart';
import 'package:plataforma_educacional/features/home/presentation/widgets/uni_bottom_nav.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.userName = 'Estudante',
    this.onMenu,
    this.onNotifications,
    this.onCalendar,
    this.onTeachers,
    this.onGroups,
    this.onAiChat,
    this.onProfile,
    this.onNavTap,
  });

  final String userName;

  final VoidCallback? onMenu;
  final VoidCallback? onNotifications;
  final VoidCallback? onCalendar;
  final VoidCallback? onTeachers;
  final VoidCallback? onGroups;
  final VoidCallback? onAiChat;
  final VoidCallback? onProfile;
  final ValueChanged<int>? onNavTap;

  static const Color _blue = Color(0xFF00BFFF);
  static const Color _pink = Color(0xFFE500C5);
  static const Color _background = Color(0xFF171719);
  static const Color _card = Color(0xD9202024);
  static const Color _cardBorder = Color(0xFF3A3543);
  static const Color _muted = Color(0xFFCCCCCC);
  static const Color _priority = Color(0xFFFFB86C);

  void _runAction(BuildContext context, VoidCallback? action) {
    if (action != null) {
      action();
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Esta seção ainda não foi conectada.')),
      );
  }

  void _handleNavigation(BuildContext context, int index) {
    if (index == 0) return;

    VoidCallback? action;

    switch (index) {
      case 1:
        action = onGroups;
        break;
      case 2:
        action = onAiChat;
        break;
      case 3:
        action = onCalendar;
        break;
      case 4:
        action = onProfile;
        break;
      default:
        return;
    }

    if (action != null) {
      action();
      return;
    }

    if (onNavTap != null) {
      onNavTap!(index);
      return;
    }

    _runAction(context, null);
  }

  String _formatDate(DateTime date) {
    const weekdays = [
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado',
      'Domingo',
    ];

    const months = [
      'jan',
      'fev',
      'mar',
      'abr',
      'mai',
      'jun',
      'jul',
      'ago',
      'set',
      'out',
      'nov',
      'dez',
    ];

    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];

    return '$weekday, ${date.day} $month';
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Builder(
        builder: (pageContext) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TopBar(
                            onMenu: () => _runAction(pageContext, onMenu),
                            onNotifications: () =>
                                _runAction(pageContext, onNotifications),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Olá, $userName!',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Um passo de cada vez. Vamos estudar?',
                                  style: TextStyle(
                                    color: _muted,
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _InfoChip(
                                      label: _formatDate(DateTime.now()),
                                    ),
                                    const _InfoChip(
                                      label: 'Seu espaço de estudos',
                                      color: _blue,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _HomeCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.event_outlined,
                                      size: 18,
                                      color: _blue,
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Sua próxima atividade',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Revisão de algoritmos',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Hoje · 14h · 1 hora de estudo',
                                  style: TextStyle(color: _muted, fontSize: 12),
                                ),
                                const SizedBox(height: 10),
                                const _PriorityTag(label: 'Alta prioridade'),
                                const SizedBox(height: 18),
                                _GradientButton(
                                  label: 'Ver no calendário',
                                  onPressed: () =>
                                      _runAction(pageContext, onCalendar),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          _HomeCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Aprender fica melhor com apoio.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Encontre orientação e acompanhe os '
                                  'materiais da sua turma.',
                                  style: TextStyle(
                                    color: _muted,
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final teachersButton = _GradientButton(
                                      label: 'Professores',
                                      onPressed: () =>
                                          _runAction(pageContext, onTeachers),
                                    );

                                    final groupsButton = _GradientButton(
                                      label: 'Meus grupos',
                                      onPressed: () =>
                                          _runAction(pageContext, onGroups),
                                    );

                                    final textSize = MediaQuery.textScalerOf(
                                      context,
                                    ).scale(14);

                                    if (constraints.maxWidth < 280 ||
                                        textSize > 18) {
                                      return Column(
                                        children: [
                                          teachersButton,
                                          const SizedBox(height: 12),
                                          groupsButton,
                                        ],
                                      );
                                    }

                                    return Row(
                                      children: [
                                        Expanded(child: teachersButton),
                                        const SizedBox(width: 12),
                                        Expanded(child: groupsButton),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              HomeBottomNav(
                currentIndex: 0,
                onTap: (index) {
                  _handleNavigation(pageContext, index);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onMenu, required this.onNotifications});

  final VoidCallback onMenu;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          IconButton(
            tooltip: 'Abrir menu',
            onPressed: onMenu,
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Uni',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [HomePage._pink, HomePage._blue],
                        ).createShader(bounds);
                      },
                      child: const Text(
                        'A.I.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Abrir notificações',
            onPressed: onNotifications,
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HomePage._card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: HomePage._cardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x30000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, this.color = HomePage._muted});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _PriorityTag extends StatelessWidget {
  const _PriorityTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: HomePage._priority.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HomePage._priority.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.flag_outlined, size: 14, color: HomePage._priority),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: HomePage._priority,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 46,
      padding: const EdgeInsets.all(1.2),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(colors: [HomePage._pink, HomePage._blue]),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: HomePage._background,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: const StadiumBorder(),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
