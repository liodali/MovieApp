import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:provider/provider.dart';

import '../../common/routes.dart';
import '../../viewmodel/MoviesViewModel.dart';
import '../widget/loading_widget.dart';
import '../widget/stream_component.dart';
import 'item_movie.dart';

class ListMovies extends StatefulWidget {
  ListMovies({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateListMovies();
}

class _StateListMovies extends State<ListMovies> {
  MoviesViewModel? viewModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      viewModel!.initMovies();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewModel == null) viewModel = Provider.of<MoviesViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamComponent<List<Movie>>(
      stream: viewModel!.stream!,
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
        if (movies.isEmpty && viewModel!.isLoading) {
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
                  await AutoRouter.of(context).navigate(
                    MovieDetailRoute(
                      movie: movies[index],
                    ),
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
