import 'package:flutter/material.dart';

import '../models/movies.dart';
import '../services/api_services.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<Movie> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final result = await _apiService.fetchAllMovies();
      setState(() {
        movies = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load movies')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
          'https://kreafolk.com/cdn/shop/articles/netflix-logo-design-history-and-evolution-kreafolk_149b6498-ceef-45a6-a671-f45dab16b804.jpg?v=1717725026&width=2048',
          height: 60,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
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
