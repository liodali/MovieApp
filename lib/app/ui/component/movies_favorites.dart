import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/movie.dart';
import '../../common/app_localization.dart';
import '../../common/routes.dart';
import '../../viewmodel/FavoriteMovieViewModel.dart';
import 'item_movie_fav.dart';

class MoviesFavorites extends HookWidget {
  final List<Movie> movies;

  MoviesFavorites({
    Key? key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final moviesState = useState(movies);
    ValueNotifier<int?> previousMovie = useState(null);
    ValueNotifier<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?>
        snackBarController = useState(null);
    final animatedKey = useMemoized(() => GlobalKey<SliverAnimatedListState>());
    final viewModel =
        useMemoized(() => context.read<FavoriteMoviesViewModel>(), [0]);

    useEffect(() {}, ["stateMovies"]);
    return SliverAnimatedList(
      key: animatedKey,
      initialItemCount: moviesState.value.length,
      itemBuilder: (ctx, index, animation) {
        return FadeTransition(
          opacity: animation,
          child: GestureDetector(
            onTap: () async {
              final movie = moviesState.value[index];
              await context.navigate(
                AppRouter.detailMovieNamePage,
                arguments: moviesState.value[index],
              );
              bool isFav = await viewModel.checkMovieInFavorite(movie.id);
              if (!isFav) {
                final indexMovie = moviesState.value.indexOf(movie);
                Movie? removed = moviesState.value.removeAt(indexMovie);
                animatedKey.currentState!.removeItem(
                  indexMovie,
                  (context, animation) => FadeTransition(
                    opacity: animation,
                    child: ItemMovieFav(
                      movie: removed,
                      actionMovie: (_) => SizedBox.shrink(),
                    ),
                  ),
                );
              }
            },
            child: ItemMovieFav(
              actionMovie: (movie) {
                return IconButton(
                  onPressed: () async {
                    if (snackBarController.value != null) {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      if (previousMovie.value != null) {
                        viewModel
                            .removeMovieFromFavoriteList(previousMovie.value!);
                      }
                    }
                    final indexMovie = moviesState.value.indexOf(movie);
                    Movie? removed = moviesState.value.removeAt(indexMovie);
                    animatedKey.currentState!.removeItem(
                      indexMovie,
                      (context, animation) => FadeTransition(
                        opacity: animation,
                        child: ItemMovieFav(
                          movie: removed!,
                          actionMovie: (_) => SizedBox.shrink(),
                        ),
                      ),
                    );
                    previousMovie.value = removed.id;
                    snackBarController.value =
                        ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "${removed.title} ${MyAppLocalizations.of(context)!.successRemoveFromFavMod}"),
                        action: SnackBarAction(
                          onPressed: () {
                            removed = null;
                            final index = indexMovie;
                            previousMovie.value = null;
                            moviesState.value.insert(index, movie);
                            animatedKey.currentState!.insertItem(index);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          label: "UNDO",
                        ),
                      ),
                    );
                    snackBarController.value!.closed.then((value) async {
                      if (removed != null) {
                        removed = null;
                        previousMovie.value = null;
                        snackBarController.value = null;
                        viewModel.removeMovieFromFavoriteList(movie.id);
                      }
                    });
                  },
                  icon: Icon(Icons.delete),
                );
              },
              movie: moviesState.value[index],
            ),
          ),
        );
      },
    );
  }
}
