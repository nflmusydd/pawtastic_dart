extension StringExtension on String {
  
  String ucfirstChar() {
    if (isEmpty) return this;
    for (int i = 0; i < length; i++) {
      final code = codeUnitAt(i);
      if (code >= 97 && code <= 122) {
        return substring(0, i) + String.fromCharCode(code - 32) + substring(i + 1);
      }
    }
    return this;
  }

  // Hanya huruf pertama dari string yang kapital, reset setelah ada tanda titik
  // Contoh: "hello world" -> "Hello world"
  String ucfirst() {
    if (isEmpty) return this;
    final chars = split('');
    bool capitalizeNext = true;
    for (int i = 0; i < chars.length; i++) {
      final char = chars[i];
      if (capitalizeNext && RegExp(r'[a-zA-Z]').hasMatch(char)) {
        chars[i] = char.toUpperCase();
        capitalizeNext = false;
      }
      if (char == '.') {
        capitalizeNext = true;
      }
    }
    return chars.join();
  }

  // Huruf pertama tiap kata kapital (Title Case)
  // Contoh: "hello world" -> "Hello World"
  String toTitleCase() {
    if (trim().isEmpty) return this;
    return trim()
      .split(RegExp(r'\s+'))
      .map((word) => word.ucfirst())
      .join(' ');
  }

  // String toUpperCase() {} tidak perlu ditambahkan, bawaan flutter sudah ada
}
