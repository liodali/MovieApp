import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/domain/models/movie.dart';

class HiveDB {
  static Box? _box;

  static Future<void> init(String boxName) async {
    _box = await Hive.openBox(boxName);
  }

  static Box get db => _box!;
}

mixin LocalStorageMixin {
  final dbFavoriteHive = HiveDB.db;

  final String favoriteIdsKey = "FavoriteMoviesIds";

  @visibleForTesting
  Future<void> clearAll() async {
    await dbFavoriteHive.clear();
    await dbFavoriteHive.deleteFromDisk();
  }

  Future<bool> isMovieFavorite(int id) async {
    return dbFavoriteHive.containsKey(id);
  }

  Future<void> addFavorite(Movie movie) async {
    if (!dbFavoriteHive.containsKey(movie.id)) {
      await dbFavoriteHive.put(movie.id, movie.toJson());
    }
  }

  Future<void> deleteFavorite(int movieId) async {
    if (dbFavoriteHive.containsKey(movieId)) {
      dbFavoriteHive.delete(movieId);
    }
  }

  Future<Movie?> getFavoriteById(int id) async {
    if (dbFavoriteHive.containsKey(id)) {
      Map<String, dynamic> map = await dbFavoriteHive.get(id);
      return Movie.fromJson(map);
    }
    return null;
  }

  Future<List<Movie>> getFavorites() async {
    List<int> ids = dbFavoriteHive.keys as List<int>;
    List<Movie> movies = [];
    for (int id in ids) {
      final m = await getFavoriteById(id);
      movies.add(m!);
    }
    return movies;
  }
}
