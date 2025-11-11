const Map<String, String> kServiceCategoryLabels = {
  'PLOMERIA': 'Plomeria',
  'CARPINTERIA': 'Carpinteria',
  'ASEO': 'Aseo',
  'ELECTRICIDAD': 'Electricidad',
  'PINTURA': 'Pintura',
  'JARDINERIA': 'Jardineria',
  'COSTURA': 'Costura',
  'COCINA': 'Cocina',
  'TECNOLOGIA': 'Tecnologia',
};

String _stripDiacritics(String input) {
  const Map<String, String> replacements = {
    'Á': 'A',
    'À': 'A',
    'Â': 'A',
    'Ã': 'A',
    'Ä': 'A',
    'á': 'a',
    'à': 'a',
    'â': 'a',
    'ã': 'a',
    'ä': 'a',
    'É': 'E',
    'È': 'E',
    'Ê': 'E',
    'Ë': 'E',
    'é': 'e',
    'è': 'e',
    'ê': 'e',
    'ë': 'e',
    'Í': 'I',
    'Ì': 'I',
    'Î': 'I',
    'Ï': 'I',
    'í': 'i',
    'ì': 'i',
    'î': 'i',
    'ï': 'i',
    'Ó': 'O',
    'Ò': 'O',
    'Ô': 'O',
    'Õ': 'O',
    'Ö': 'O',
    'ó': 'o',
    'ò': 'o',
    'ô': 'o',
    'õ': 'o',
    'ö': 'o',
    'Ú': 'U',
    'Ù': 'U',
    'Û': 'U',
    'Ü': 'U',
    'ú': 'u',
    'ù': 'u',
    'û': 'u',
    'ü': 'u',
    'Ñ': 'N',
    'ñ': 'n',
    'Ç': 'C',
    'ç': 'c',
  };

  final buffer = StringBuffer();
  for (final rune in input.runes) {
    final char = String.fromCharCode(rune);
    buffer.write(replacements[char] ?? char);
  }
  return buffer.toString();
}

String normalizeCategoryValue(String? raw) {
  if (raw == null) return '';
  final sanitized = _stripDiacritics(raw).toUpperCase().trim();
  if (sanitized.isEmpty) return '';
  for (final key in kServiceCategoryLabels.keys) {
    if (_stripDiacritics(key).toUpperCase() == sanitized) {
      return key;
    }
  }
  return sanitized;
}

String categoryDisplayLabel(String? value) {
  if (value == null || value.isEmpty) return '';
  final normalized = normalizeCategoryValue(value);
  return kServiceCategoryLabels[normalized] ?? value;
}

