import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final maskFormatter = MaskTextInputFormatter(
  mask: '+# (###) ###-##-##',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

String parsePhone(String phoneNumber) {
  String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

  if (digitsOnly.length != 11) {
    return 'Некорректный номер телефона';
  }
  String countryCode = digitsOnly.substring(0, 1);
  String regionCode = digitsOnly.substring(1, 4);
  String remainingDigits = digitsOnly.substring(4);

  String formattedNumber =
      '+$countryCode ($regionCode) ${remainingDigits.substring(0, 3)}-${remainingDigits.substring(3, 5)}-${remainingDigits.substring(5)}';

  return formattedNumber;
}
