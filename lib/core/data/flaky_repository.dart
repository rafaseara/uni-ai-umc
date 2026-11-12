import 'package:flutter/foundation.dart';
import 'package:plataforma_educacional/core/data/list_repository.dart';
import 'package:plataforma_educacional/core/models/identified.dart';
import 'package:plataforma_educacional/features/calendar/data/activity_repository.dart';
import 'package:plataforma_educacional/features/calendar/models/calendar_activity.dart';

/// Apenas em debug: demonstra o estado de erro sem alterar arquivos de código.
class FaultSwitch {
  FaultSwitch._();
  static final ValueNotifier<bool> enabled = ValueNotifier<bool>(false);
}

class FlakyRepository<T extends Identified> implements ListRepository<T> {
  FlakyRepository(this.delegate);
  final ListRepository<T> delegate;

  @override
  Future<List<T>> getAll() {
    if (FaultSwitch.enabled.value) {
      throw StateError('Falha simulada de carregamento (modo demonstração).');
    }
    return delegate.getAll();
  }

  @override
  Future<void> add(T item) => delegate.add(item);
  @override
  Future<void> update(T item) => delegate.update(item);
  @override
  Future<void> delete(String id) => delegate.delete(id);
}

class FlakyActivityRepository extends FlakyRepository<CalendarActivity>
    implements ActivityRepository {
  FlakyActivityRepository(ActivityRepository super.repository);
}
