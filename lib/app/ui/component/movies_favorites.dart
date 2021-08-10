import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/app/common/app_localization.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/movie.dart';
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
    final movieState = useState(movies);
    ValueNotifier<int?> previousMovie = useState(null);
    ValueNotifier<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?>
        snackBarController = useState(null);
    final animatedKey = useMemoized(() => GlobalKey<SliverAnimatedListState>());
    final viewModel =
        useMemoized(() => context.read<FavoriteMoviesViewModel>(), [0]);

    useEffect(() {}, ["stateMovies"]);
    return SliverAnimatedList(
      key: animatedKey,
      initialItemCount: movieState.value.length,
      itemBuilder: (ctx, index, animation) {
        return FadeTransition(
          opacity: animation,
          child: ItemMovieFav(
            delete: (m) {
              if (snackBarController.value != null) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                if (previousMovie.value != null) {
                  viewModel.removeMovieFromFavoriteList(previousMovie.value!);
                }
              }
              final indexMovie = movieState.value.indexOf(m);
              Movie? removed = movieState.value.removeAt(indexMovie);
              animatedKey.currentState!.removeItem(
                indexMovie,
                (context, animation) => FadeTransition(
                  opacity: animation,
                  child: ItemMovieFav(
                    movie: removed!,
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
                      movieState.value.insert(index, m);
                      animatedKey.currentState!.insertItem(index);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    label: "UNDO",
                  ),
                ),
              );

              snackBarController.value!.closed.then((value) async {
                /*
                previousMovie.value != null &&
                    snackBarController.value != null &&
                 */
                if (removed != null) {
                  removed = null;
                  previousMovie.value = null;
                  snackBarController.value = null;
                  viewModel.removeMovieFromFavoriteList(m.id);
                }
              });
            },
            movie: movieState.value[index],
          ),
        );
      },
    );
  }
}
