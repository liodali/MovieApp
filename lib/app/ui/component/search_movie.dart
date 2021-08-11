import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/app/common/locator.dart';
import 'package:movie_app/app/ui/component/item_movie_fav.dart';
import 'package:movie_app/app/ui/widget/stream_component.dart';
import 'package:movie_app/app/viewmodel/search_movie_view_model.dart';
import 'package:movie_app/core/interactors/check_movie_is_fav_use_case.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/movie.dart';
import '../../common/routes.dart';

class SearchMovieDelegate extends SearchDelegate<Movie> {
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
      onPressed: () => context.pop(),
      icon: Icon(
        Icons.arrow_back_ios,
        size: 24,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return HookBuilder(builder: (ctx) {
      useEffect(() {
        final textQueryVM = context.read<TextSearchVM>();
        textQueryVM.setQuery(query);
      });
      return ChangeNotifierProxyProvider<TextSearchVM, SearchMovieViewModel>(
        create: (_) => SearchMovieViewModel(query),
        update: (ctx, qvm, vm) => vm!..update(qvm.query),
        builder: (ctx, _) {
          return SearchMovieResult();
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink();
  }
}

class SearchMovieResult extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<SearchMovieViewModel>();

    if (vm.isQueryEmpty) {
      return SizedBox.shrink();
    }

    return StreamComponent<List<Movie>>(
      stream: vm.stream,
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
              return ItemMovieFav(
                actionMovie: (movie) => IconButton(
                  onPressed: () async{
                    if (stateFav.value) {
                    } else {}
                  },
                  icon: Icon(
                    stateFav.value ? Icons.bookmark : Icons.bookmark_border,
                    color: stateFav.value ? Colors.amber : null,
                    size: 24,
                  ),
                ),
                movie: movies[index],
              );
            });
          },
        );
      },
    );
  }
}
