import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix_clone_task/models/movies.dart';

class ApiService {
  static const String baseUrl = 'https://api.tvmaze.com';

  Future<List<Movie>> fetchAllMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/search/shows?q=all'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Movie.fromJson(item)).toList();
    }
    throw Exception('Failed to load movies');
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/shows?q=$query'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Movie.fromJson(item)).toList();
    }
    throw Exception('Failed to search movies');
  }
}