import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/dish.dart';

class ApiService {
  static const String _baseUrl = 'https://69846b7e885008c00db120c3.mockapi.io/api/v1';
  final Dio _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  Future<List<Dish>> getMenu() async {
    try {
      final response = await _dio.get('/Exam1');

      if (response.statusCode == 200) {
        final List<dynamic> rootList = response.data;

        if (rootList.isNotEmpty) {
          final Map<String, dynamic> mainObject = rootList[0];

          if (mainObject['menu'] != null) {
            final List<dynamic> menuList = mainObject['menu'];
            return menuList.map((json) => Dish.fromJson(json)).toList();
          }
        }
      }
      return [];
    } catch (e) {
      debugPrint('Errore API: $e');
      return [];
    }
  } 
}