import 'package:eco_city/utils/helpers/parsePhoneNumber.dart';

class RegistrationValidate {
  static String? validatePhone(String value, bool button) {
    value = parsePhoneNumber(value);

    if (button) {
      if (value.isEmpty) {
        return 'Заполните поле';
      } else {
        if (value.length < 11) {
          return 'Неверный формат номера';
        } else if (value.length > 11) {
          return 'Неверный формат номера';
        } else if (value[0] != '7') {
          return 'Неверный код страны';
        }
      }
    }

    return null;
  }

  static String? validateCode(String value, bool button) {
    if (button) {
      if (value.isEmpty) {
        return 'Заполните поле';
      } else {
        if (value.length < 4) {
          return 'Неверная длина кода';
        } else if (value.length > 4) {
          return 'Неверная длина кода';
        } else if (value.length != 4 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
          return 'Неверный формат кода';
        }
      }
    }

    return null;
  }

  static String? validateName(String value, bool button) {
    if (button) {
      if (value.isEmpty) {
        return 'Заполните поле';
      } else {
        if (value.length < 5) {
          return 'Минимальная длина 5 символов';
        } else if (value.length > 100) {
          return 'Максимальная длина 100 символов';
        } else if (!RegExp(r'^[a-zA-Zа-яА-Я\s]+$').hasMatch(value)) {
          return 'Неверный формат ФИО';
        }
      }
    }

    return null;
  }

  static String? validateEmail(String value, bool button) {
    if (button) {
      if (value.isEmpty) {
        return 'Заполните поле';
      } else {
        if (value.length < 5) {
          return 'Минимальная длина 5 символов';
        } else if (value.length > 100) {
          return 'Максимальная длина 100 символов';
        } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(value)) {
          return 'Неверный формат электронной почты';
        }
      }
    }

    return null;
  }

  static String? validateAddress(String value, bool button) {
    if (button) {
      if (value.isEmpty) {
        return 'Заполните поле';
      } else {
        if (value.length < 5) {
          return 'Минимальная длина 5 символов';
        } else if (value.length > 100) {
          return 'Максимальная длина 200 символов';
        }
      }
    }

    return null;
  }

  static String? validatePassword(String value, bool button) {
    if (button) {
      if (value.isEmpty) {
        return 'Заполните поле';
      } else {
        if (value.length < 5) {
          return 'Минимальная длина пароля 5 символов';
        } else if (value.length > 30) {
          return 'Максимальная длина пароля 30 символов';
        }
      }
    }

    return null;
  }
}
