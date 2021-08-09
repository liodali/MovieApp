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

  Future<void> addFavorite(Movie movie) async {
    await dbFavoriteHive.put(movie.id, movie.toJson());
    await _addFavoriteIds(movie.id);
  }

  Future<void> deleteFavorite(int movieId) async {
     dbFavoriteHive.delete(movieId);
     _removeFavoriteIds(movieId);
  }

  Future<Movie> getFavoriteById(int id) async {
    Map<String, dynamic> map = await dbFavoriteHive.get(id);
    return Movie.fromJson(map);
  }

  Future<List<Movie>> getFavorites() async {
    List<int> ids = await dbFavoriteHive.get(favoriteIdsKey);
    List<Movie> movies = [];
    for (int id in ids) {
      final m = await getFavoriteById(id);
      movies.add(m);
    }
    return movies;
  }

  Future<void> _addFavoriteIds(int id) async {
    if (dbFavoriteHive.containsKey(favoriteIdsKey)) {
      List<int> list = await dbFavoriteHive.get(favoriteIdsKey);
      int index = dbFavoriteHive.keys.toList().indexOf(id);
      list.add(id);
      await dbFavoriteHive.putAt(index, list);
    } else {
      await dbFavoriteHive.put(favoriteIdsKey, [id]);
    }
  }

  Future<void> _removeFavoriteIds(int id) async {
    if (dbFavoriteHive.containsKey(favoriteIdsKey)) {
      List<int> list = await dbFavoriteHive.get(favoriteIdsKey);
      int index = dbFavoriteHive.keys.toList().indexOf(id);
      list.remove(id);
      await dbFavoriteHive.putAt(index, list);
    }
  }
}
