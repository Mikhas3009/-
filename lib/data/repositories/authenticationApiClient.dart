import 'dart:convert';
import 'package:eco_city/domain/models/registration/registrationModel.dart'
    as regData;
import 'package:eco_city/data/repositories/apiClient.dart';
import 'package:eco_city/domain/models/user/userModel.dart' as userData;
import 'package:eco_city/utils/helpers/showSnackBar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationApiClient {
  Future<void> login(context, String phone, String password) async {
    // Запрос на сервер
    final response =
        await ApiClient().post('auth', {'phone': phone, 'password': password});

    // Обработка ответа от сервера
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        var accessToken = response.headers.values
            .toString()
            .split('accessToken=')[1]
            .split(';')
            .first;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        print(accessToken);

        Get.offAndToNamed('/profile');
      } else {
        showSnackBar(context, responseBody['message']);
      }
    } else {
      showSnackBar(context, 'Ошибка подключения к серверу');
    }
  }

  Future<void> checkPhone(context, String phone) async {
    // Запрос на сервер
    final response = await ApiClient().post('checkPhone', {'number': phone});

    // Обработка ответа от сервера
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        Get.toNamed('/verifyPhone');
      } else {
        showSnackBar(context, responseBody['message']);
      }
    } else {
      showSnackBar(context, 'Ошибка подключения к серверу');
    }
  }

  Future<void> verifyPhone(context, String phoneToken) async {
    // Запрос на сервер
    final response =
        await ApiClient().post('verifyNumber', {'phoneToken': phoneToken});

    // Обработка ответа от сервера
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        regData.userCode = responseBody['code'];
        showSnackBar(
          context,
          "Ваш код: ${responseBody['code']}",
        );
      } else {
        showSnackBar(context, responseBody['message']);
      }
    } else {
      showSnackBar(context, 'Ошибка подключения к серверу');
    }
  }

  Future<void> register(context, String phone, String name, String phoneToken,
      String password, String email, String address, String region) async {
    // Запрос на сервер
    final response = await ApiClient().post('reg', {
      'name': name,
      'phone': phone,
      'phoneToken': phoneToken,
      'password': password,
      'email': email,
      'address': address,
      'region': region
    });

    // Обработка ответа от сервера
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        Get.offAndToNamed('/profile');
      } else {
        showSnackBar(context, responseBody['message']);
      }
    } else {
      showSnackBar(context, 'Ошибка подключения к серверу');
    }
  }

  Future<void> isLoggedIn(context) async {
    // Запрос на сервер
    final response = await ApiClient().get('isLoggedIn');

    // Обработка ответа от сервера
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseBody = jsonDecode(response.body);
      print('USER LOGGED? $responseBody');
      if (responseBody['success'] == true) {
        Get.offAndToNamed('/profile');
      } else {
        Get.offAndToNamed('/startScreen');
      }
    } else {
      showSnackBar(context, 'Ошибка подключения к серверу');
    }
  }

  Future<void> getUserCookie(context) async {
    // Запрос на сервер
    final response = await ApiClient().get('personalData');

    // Обработка ответа от сервера
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseBody = jsonDecode(response.body);

      userData.userId = responseBody['id'];
      userData.userRole = responseBody['role'];
      userData.userName = responseBody['name'];
      userData.userEmail = responseBody['email'];
      userData.userPhone = responseBody['phone'];
      userData.userPhoneToken = responseBody['phoneToken'];
      userData.userPassword = responseBody['password'];
      userData.userAddress = responseBody['address'];

      print('USER COOKIE: ${jsonDecode(response.body)}');
      isLoggedIn(context);
    } else {
      showSnackBar(context, 'Ошибка подключения к серверу');
    }
  }
}
