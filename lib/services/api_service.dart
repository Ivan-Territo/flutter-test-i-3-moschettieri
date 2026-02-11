import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/dish.dart';

/// Servizio responsabile di tutte le chiamate di rete (HTTP).
/// Utilizza il pacchetto [dio] che è molto potente per gestire le API.
class ApiService {
  // L'URL base è l'indirizzo comune a tutte le nostre chiamate.
  static const String _baseUrl =
      'https://69846b7e885008c00db120c3.mockapi.io/api/v1';

  // Creiamo un'istanza di Dio configurata con il nostro URL base.
  final Dio _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  /// Recupera la lista di tutte le tavole da surf disponibili.
  Future<List<Map<String, dynamic>>> getBoards() async {
    try {
      final response = await _dio.get('/Exam1');

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
  Future<List<Dish>> getMenu() async {
    try {
      final response = await _dio.get('/Exam1');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        if (data.isNotEmpty && data[0]['menu'] != null) {
          final List<dynamic> menuRaw = data[0]['menu'];
          return menuRaw
              .cast<Map<String, dynamic>>() // Forza il tipo a Map
              .map((json) => Dish.fromJson(json))
              .toList();
        }
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
      debugPrint('Errore getRooms: $e');
      return [];
    }
  }
}
