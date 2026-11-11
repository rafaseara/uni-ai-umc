import 'package:flutter/material.dart';
import 'package:plataforma_educacional/core/models/identified.dart';
import 'package:plataforma_educacional/core/presentation/list_controller.dart';
import 'package:plataforma_educacional/shared/widgets/uni_empty_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_error_state.dart';
import 'package:plataforma_educacional/shared/widgets/uni_loading.dart';

/// Apresentação uniforme dos estados do controller, sem FutureBuilder por tela.
class UniControlledList<T extends Identified> extends StatelessWidget {
  const UniControlledList({
    super.key,
    required this.controller,
    required this.emptyState,
    required this.builder,
  });

  final ListController<T> controller;
  final UniEmptyState emptyState;
  final Widget Function(BuildContext, List<T>) builder;

  @override
  Widget build(BuildContext context) {
    switch (controller.status) {
      case LoadStatus.initial:
      case LoadStatus.loading:
        return const UniLoading();
      case LoadStatus.error:
        return UniErrorState(onRetry: controller.load);
      case LoadStatus.ready:
        final items = controller.items;
        return items.isEmpty ? emptyState : builder(context, items);
    }
  }
}
