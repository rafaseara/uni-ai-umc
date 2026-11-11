enum Priority { low, medium, high }

extension PriorityLabel on Priority {
  String get label => switch (this) {
    Priority.low => 'Baixa',
    Priority.medium => 'Média',
    Priority.high => 'Alta',
  };
}
