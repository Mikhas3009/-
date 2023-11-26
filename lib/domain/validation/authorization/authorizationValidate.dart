import 'package:eco_city/utils/helpers/parsePhoneNumber.dart';

class AuthorizationValidate {
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
