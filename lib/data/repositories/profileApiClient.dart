import 'dart:convert';
import 'package:eco_city/domain/models/news/newsModeration.dart'
    as newsModerationData;
import 'package:eco_city/data/repositories/apiClient.dart';
import 'package:eco_city/utils/helpers/showSnackBar.dart';
import 'package:get/route_manager.dart';

class profileApiClient {
  Future<void> userLogout(context) async {
    // Отправляем запрос
    final response = await ApiClient().get('logOut');

    // Обрабатываем запрос
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body == 'OK') {
        Get.offAndToNamed('/startScreen');
      }
    } else {
      showSnackBar(context, 'Ошибка подключения к серверу');
    }
  }

  Future<void> registerOrganizations(context, String name, String phone,
      String password, String email, String address) async {
    // Запрос на сервер
    final response = await ApiClient().post('regOrganizations', {
      'name': name,
      'phone': phone,
      'password': password,
      'email': email,
      'address': address
    });

    // Обработка ответа от сервера
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        showSnackBar(context, 'Организация успешно добавлена');
      } else {
        showSnackBar(context, responseBody['message']);
      }
    } else {
      showSnackBar(context, 'Ошибка подключения к серверу');
    }
  }

  Future<void> getUnconfirmedMarks(context) async {
    // Запрос на сервер
    final response = await ApiClient().get('map/unConfirmedMarks');

    // Обработка ответа от сервера
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        newsModerationData.newsModerationJSON = responseBody['data'];
        print(responseBody['data']);
      } else {
        showSnackBar(context, responseBody['message']);
      }
    } else {
      showSnackBar(context, 'Ошибка подключения к серверу');
    }
  }
}
