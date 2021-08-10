import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/domain/models/movie.dart';

import 'item_movie_fav.dart';

class MoviesFavorites extends HookWidget {
  final List<Movie> movies;

  MoviesFavorites({
    Key? key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      initialItemCount: movies.length,
      itemBuilder: (ctx, index, animation) {
        return FadeTransition(
          opacity: animation,
          child: ItemMovieFav(
            movie: movies[index],
          ),
        );
      },
    );
  }
}
