import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../../core/interactors/check_movie_is_fav_use_case.dart';
import '../../../domain/models/movie.dart';
import '../../common/locator.dart';
import '../../common/routes.dart';
import '../../viewmodel/search_movie_view_model.dart';
import '../widget/stream_component.dart';
import 'item_movie_fav.dart';

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(
        Icons.arrow_back_ios,
        size: 24,
      ),
    );
  }

  @override
  void close(BuildContext context, Movie? result) {
    context.read<SearchMovieViewModel>().clear();
    super.close(context, result);
  }

  @override
  Widget buildResults(BuildContext context) {
    return HookBuilder(builder: (ctx) {
      final searchVM =
          useMemoized(() => context.read<SearchMovieViewModel>(), [ctx]);

      useEffect(() {
        if (query != searchVM.query) {
          searchVM.setQuery(query);
          searchVM.update();
        }
      }, [query]);
      return SearchMovieResult();
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink();
  }
}

class SearchMovieResult extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchMovieResultState();
}

class _SearchMovieResultState extends State<SearchMovieResult> {
  SearchMovieViewModel? searchVM;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (searchVM == null) {
      searchVM = context.read<SearchMovieViewModel>();
      searchVM!.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (searchVM!.isQueryEmpty) {
      return SizedBox.shrink();
    }

    return StreamComponent<List<Movie>>(
      stream: searchVM!.stream,
      builder: (movies) {
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (ctx, index) {
            return HookBuilder(builder: (ctx) {
              final stateFav = useState(false);
              useEffect(() {
                Future.delayed(Duration.zero, () async {
                  stateFav.value = await getIt<CheckMovieIsFavoriteUseCase>()
                      .invoke(movies[index].id);
                });
              });
              return GestureDetector(
                onTap: () async {
                  await context.navigate(AppRouter.detailMovieNamePage,
                      arguments: movies[index]);
                },
                child: ItemMovieFav(
                  actionMovie: (movie) => Icon(
                    stateFav.value ? Icons.bookmark : Icons.bookmark_border,
                    color: stateFav.value ? Colors.amber : null,
                    size: 24,
                  ),
                  movie: movies[index],
                ),
              );
            });
          },
        );
      },
    );
  }
}
