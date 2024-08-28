class Validator {
  // Telefon raqam uchun validator
  static String? validatePhoneNumber(String? value) {
    RegExp phoneRegExp = RegExp(r'^\d{2}(\s*\d{1,3}){2,3}\s*\d{1,3}$');

    if (value == null || value.isEmpty) {
      return 'Telefon raqamini kiriting';
    } else if (!phoneRegExp.hasMatch(value)) {
      return 'Yaroqli telefon raqamini kiriting (masalan, 901234567)';
    }
    return null; // Hammasi yaxshi bo'lsa, null qaytadi
  }

  // Ism uchun validator
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ismingizni kiriting';
    } else if (value.length < 2) {
      return 'Ismingiz kamida 2 ta belgidan iborat bo\'lishi kerak';
    }
    return null; // Hammasi yaxshi bo'lsa, null qaytadi
  }

  // Parol uchun validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Parolni kiriting';
    } else if (value.length < 6) {
      return 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak';
    }
    return null; // Hammasi yaxshi bo'lsa, null qaytadi
  }

  // Parolni tasdiqlash (confirm password) uchun validator
  static String? validateConfirmPassword(
      String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Parolni tasdiqlang';
    } else if (value != originalPassword) {
      return 'Parollar mos kelmayapti';
    }
    return null; // Hammasi yaxshi bo'lsa, null qaytadi
  }
}
