import 'dart:async';
import 'dart:convert';
import 'package:eco_city/utils/constants/url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final String baseUrl = URL;

  getTokenFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('accessToken') ?? '';

    return token;
  }

  Future<http.Response> get(String route) async {
    var token = '';
    await getTokenFromLocal().then((res) => {token = res});

    final response = await http.get(
      Uri.parse('$baseUrl/$route'),
      headers: {
        'Content-Type': 'application/json',
        'cookie': 'accessToken=$token'
      },
    );

    return response;
  }

  Future<http.Response> post(String route, Map<String, dynamic> data) async {
    String accessToken = await getTokenFromLocal();

    final response = await http.post(
      Uri.parse('$baseUrl/$route'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'HttpHeaders.cookieHeader': 'accessToken=${accessToken}'
      },
    );

    return response;
  }

  Future<http.Response> put(String route, Map<String, dynamic> data) async {
    String accessToken = getTokenFromLocal();

    final response = await http.put(
      Uri.parse('$baseUrl/$route'),
      body: data,
      headers: {
        'Content-Type': 'application/json',
        'HttpHeaders.cookieHeader': 'accessToken=$accessToken'
      },
    );

    return response;
  }

  Future<http.Response> delete(String route, Map<String, dynamic> data) async {
    String accessToken = getTokenFromLocal();

    final response = await http.delete(
      Uri.parse('$baseUrl/$route'),
      body: data,
      headers: {
        'Content-Type': 'application/json',
        'HttpHeaders.cookieHeader': 'accessToken=$accessToken'
      },
    );

    return response;
  }
}
