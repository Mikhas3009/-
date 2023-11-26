String parsePhoneNumber(String formattedNumber) {
  String phone = formattedNumber.replaceAll(RegExp(r'\D'), '');

  if (phone.startsWith('8')) {
    phone = '7${phone.substring(1)}';
  }

  return phone;
}
