import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/dish.dart';

class ApiService {
  // Sostituisci con il tuo URL corretto se diverso
  static const String _baseUrl =
      'https://69846b7e885008c00db120c3.mockapi.io/api/v1';
  final Dio _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  Future<List<Dish>> getMenu() async {
    try {
      final response = await _dio.get('/Exam1'); // Endpoint corretto

      if (response.statusCode == 200) {
        // L'API restituisce un array con un oggetto che contiene la chiave "boards"
        final List<dynamic> data = response.data;
        if (data.isNotEmpty && data[0]['boards'] != null) {
          final List<dynamic> boards = data[0]['boards'];
          return boards.cast<Map<String, dynamic>>();
        }
        return [];
      }
      return [];
    } catch (e) {
      debugPrint('Errore getBoards: $e');
      return [];
    }
  }

  /// Recupera la lista di tutti i piatti del menu.
  Future<List<Map<String, dynamic>>> getMenu() async {
    try {
      final response = await _dio.get('/Exam1');

      if (response.statusCode == 200) {
        // L'API restituisce un array con un oggetto che contiene la chiave "menu"
        final List<dynamic> data = response.data;
        if (data.isNotEmpty && data[0]['menu'] != null) {
          final List<dynamic> menu = data[0]['menu'];
          return menu.cast<Map<String, dynamic>>();
        }
        return [];
      }
      return [];
    } catch (e) {
      debugPrint('Errore getMenu: $e');
      return [];
    }
  }

  /// Recupera la lista di tutte le stanze disponibili.
  Future<List<Map<String, dynamic>>> getRooms() async {
    try {
      final response = await _dio.get('/Exam1');

      if (response.statusCode == 200) {
        // L'API restituisce un array con un oggetto che contiene la chiave "rooms"
        final List<dynamic> data = response.data;
        if (data.isNotEmpty && data[0]['rooms'] != null) {
          final List<dynamic> rooms = data[0]['rooms'];
          return rooms.cast<Map<String, dynamic>>();
        }
        return [];
      }
      return [];
    } catch (e) {
      debugPrint('Errore API: $e');
      return [];
    }
  }
}
