import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:provider/provider.dart';

import '../../common/routes.dart';
import '../../viewmodel/movies_view_model.dart';
import '../widget/loading_widget.dart';
import '../widget/stream_component.dart';
import 'item_movie.dart';

class ListMovies extends HookWidget {
  ListMovies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MoviesViewModel>(context);
    useEffect(() {
      viewModel.initMovies();
    }, [context]);
    return StreamComponent<List<Movie>>(
      stream: viewModel.stream,
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
      builder: (movies) {
        if (movies.isEmpty && viewModel.isLoading) {
          return SliverFillRemaining(
            child: LoadingWidget(),
          );
        }
        return SliverFillRemaining(
          hasScrollBody: true,
          fillOverscroll: true,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 196,
                mainAxisSpacing: 8,
                crossAxisSpacing: 12),
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () async {
                  await context.navigate(
                    AppRouter.detailMovieNamePage,
                    arguments: movies[index],
                  );
                },
                child: ItemMovie(
                  movie: movies[index],
                ),
              );
            },
            itemCount: movies.length,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
          ),
        );
      },
    );
  }
}
