import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String? baseUrl = dotenv.env['BASE_URL'];

Future<List<dynamic>> fetchPopularAnime({int? number}) async {
  final url = Uri.parse(
      '$baseUrl/api/zoroanime/popularanime${number != null ? '?page=$number' : ''}');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return List<dynamic>.from(json.decode(response.body)['results']);
  } else {
    throw Exception('Failed to load anime data');
  }
}

Future<List<dynamic>> fetchMostFavorite({int? number}) async {
  final url = Uri.parse(
      '$baseUrl/api/zoroanime/mostfavorite${number != null ? '?page=$number' : ''}');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return List<dynamic>.from(json.decode(response.body)['results']);
  } else {
    throw Exception('Failed to load anime data');
  }
}

Future<List<dynamic>> fetchTopAiring({int? number}) async {
  final url = Uri.parse(
      '$baseUrl/api/zoroanime/topairing${number != null ? '?page=$number' : ''}');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return List<dynamic>.from(json.decode(response.body)['results']);
  } else {
    throw Exception('Failed to load anime data');
  }
}

Future<List<dynamic>> fetchMovie({int? number}) async {
  final url = Uri.parse(
      '$baseUrl/api/zoroanime/movie${number != null ? '?page=$number' : ''}');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return List<dynamic>.from(json.decode(response.body)['results']);
  } else {
    throw Exception('Failed to load anime data');
  }
}
