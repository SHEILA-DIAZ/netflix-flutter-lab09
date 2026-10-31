import 'package:flutter/foundation.dart';

class Movie {
  final String id, title, genre, description, photo, rating;
  final int year;
  final bool local, isSeries;
  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.description,
    required this.photo,
    required this.year,
    required this.rating,
    this.local = false,
    this.isSeries = false,
  });
}

class Category {
  final String name;
  final List<Movie> movies;
  const Category(this.name, this.movies);
}

// Un único estado compartido mantiene favoritos durante la sesión.
class Favorites extends ChangeNotifier {
  final Set<String> _ids = {};
  bool contains(Movie movie) => _ids.contains(movie.id);
  void toggle(Movie movie) {
    if (!_ids.remove(movie.id)) {
      _ids.add(movie.id);
    }
    notifyListeners();
  }
}
