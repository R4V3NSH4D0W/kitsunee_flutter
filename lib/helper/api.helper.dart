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

Future<List<dynamic>> fetchSpotLight({int? number}) async {
  final url = Uri.parse(
      '$baseUrl/api/zoroanime/spotlight${number != null ? '?page=$number' : ''}');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return List<dynamic>.from(json.decode(response.body)['results']);
  } else {
    throw Exception('Failed to load anime data');
  }
}

Future<List<dynamic>> fetchSearchResult({required String query}) async {
  final url = Uri.parse('$baseUrl/api/zoroanime/search?q=$query');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return List<dynamic>.from(json.decode(response.body)['results']);
  } else {
    throw Exception('Failed to load anime data');
  }
}

Future<Map<String, dynamic>> fetchAnimeDetail({required String id}) async {
  final url = Uri.parse('$baseUrl/api/zoroanime/animeinfo?id=$id');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load anime data');
  }
}

Future<Map<String, dynamic>> fetchJikanAnime({required int malId}) async {
  final url = Uri.parse('https://api.jikan.moe/v4/anime/$malId');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse['data'];
  } else {
    throw Exception('Failed to load anime data');
  }
}

Future<List<dynamic>> fetchReleaseSchedule({required String date}) async {
  final url = Uri.parse('$baseUrl/api/zoroanime/schedule?date=$date');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return List<dynamic>.from(json.decode(response.body)['results']);
  } else {
    throw Exception('Failed to load anime data');
  }
}

Future<Map<String, dynamic>> fetchEpisodeSource({required String id}) async {
  print("id: $id");
  final url = Uri.parse('$baseUrl/api/zoroanime/episodesource?id=$id');

  final response = await http.get(url);
  print("response: ${response.body}");

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load anime data');
  }
}
