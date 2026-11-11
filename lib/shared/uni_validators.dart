/// Validadores reutilizáveis, com mensagens em português para a UI.
abstract final class UniValidators {
  static String? nonEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe $fieldName.';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Informe seu e-mail.';
    final email = value.trim();
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      return 'Digite um e-mail válido.';
    }
    return null;
  }

  static String? birthDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe sua data de nascimento.';
    }
    final match = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').firstMatch(value.trim());
    if (match == null) return 'Use o formato DD/MM/AAAA.';
    final day = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final year = int.parse(match.group(3)!);
    if (year < 1900 || year > DateTime.now().year) {
      return 'Informe uma data válida.';
    }
    final date = DateTime(year, month, day);
    if (date.year != year || date.month != month || date.day != day ||
        date.isAfter(DateTime.now())) {
      return 'Informe uma data válida.';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Informe sua senha.';
    if (value.length < 6) return 'Use pelo menos 6 caracteres.';
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Confirme sua senha.';
    if (value != password) return 'As senhas não coincidem.';
    return null;
  }
}
