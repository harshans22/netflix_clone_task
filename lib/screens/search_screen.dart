import 'package:flutter/material.dart';
import 'package:netflix_clone_task/utils/debouncer.dart';

import '../models/movies.dart';
import '../services/api_services.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  List<Movie> searchResults = [];
  bool isLoading = false;
  final _debouncer = Debouncer(milliseconds: 500);

  void _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final results = await _apiService.searchMovies(query);
      setState(() {
        searchResults = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Search failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search movies...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          onChanged: (query) {
            _debouncer.run(() {
              _performSearch(query);
            });
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: movie,
                  ),
                  child: MovieCard(movie: movie),
                );
              },
            ),
    );
  }
}
