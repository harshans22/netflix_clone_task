class Movie {
  final int id;
  final String name;
  final String? imageUrl;
  final String summary;
  final String? premiered;
  final double? rating;
  final List<String>? genres;

  Movie({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.summary,
    this.premiered,
    this.rating,
    this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final show = json['show'];
    return Movie(
      id: show['id'],
      name: show['name'],
      imageUrl: show['image']?['original'],
      summary: show['summary'] ?? '',
      premiered: show['premiered'],
      rating: show['rating']?['average']?.toDouble(),
      genres: List<String>.from(show['genres'] ?? []),
    );
  }
}