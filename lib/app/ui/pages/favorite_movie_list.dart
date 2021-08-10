import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/app/common/app_localization.dart';
import 'package:movie_app/app/ui/widget/loading_widget.dart';
import 'package:movie_app/app/ui/widget/my_future_builder_component.dart';
import 'package:movie_app/app/viewmodel/FavoriteMovieViewModel.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:movie_app/domain/models/response.dart';
import 'package:provider/provider.dart';

import '../component/movies_favorites.dart';
import '../widget/empty_list.dart';

class FavoriteMovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteMoviesViewModel(),
      child: FavoriteMovieListCore(),
    );
  }
}

class FavoriteMovieListCore extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<FavoriteMoviesViewModel>();
    useEffect(() {
      vm.getMovieFavoriteList();
    }, [vm]);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () => AutoRouter.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              MyAppLocalizations.of(context)!.favMovieTitle,
            ),
          ),
          MyFutureBuilderComponent<List<Movie>>(
            future: vm.moviesFav,
            loading: SliverFillRemaining(
              fillOverscroll: false,
              hasScrollBody: false,
              child: LoadingWidget(),
            ),
            errorWidget: SliverFillRemaining(
              fillOverscroll: false,
              hasScrollBody: false,
              child: Center(
                child: Text("Error!"),
              ),
            ),
            mapTo: (response) => (response as MoviesResponse).data,
            builder: (movies) {
              if (movies.isEmpty) {
                return EmptyList();
              }
              return MoviesFavorites(
                movies: movies,
              );
            },
          )
        ],
      ),
    );
  }
}
