import 'package:flutter/material.dart';

import '../models/movies.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: movie.imageUrl != null
                  ? Image.network(
                      movie.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey,
                      child: const Icon(Icons.movie, size: 100),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (movie.rating != null)
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        const SizedBox(width: 4),
                        Text(
                          '${movie.rating}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (movie.genres != null && movie.genres!.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: movie.genres!
                          .map((genre) => Chip(
                                label: Text(genre),
                                backgroundColor: Colors.red,
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                              ))
                          .toList(),
                    ),
                  const SizedBox(height: 16),
                  const Text(
                    'Summary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.summary.replaceAll(RegExp(r'<[^>]*>'), ''),
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
