import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:provider/provider.dart';

import '../../common/app_localization.dart';
import '../../common/routes.dart';
import '../../viewmodel/MoviesViewModel.dart';
import '../widget/loading_widget.dart';
import '../widget/stream_component.dart';
import 'item_movie.dart';

class ListMovies extends HookWidget {
  ListMovies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MoviesViewModel>();
    useEffect(() {
      viewModel.initMovies();
    });
    return CustomScrollView(
      primary: false,
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox.shrink(),
        ),
        StreamComponent<List<Movie>>(
          stream: viewModel.stream!,
          key: Key(viewModel.typeMovieSelected),
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
                    onTap: () {
                      AutoRouter.of(context).navigate(
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
        ),
        Selector<MoviesViewModel, bool>(
          builder: (ctx, isLoading, _) {
            if (!isLoading) {
              return SliverToBoxAdapter();
            }
            return SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              sliver: SliverToBoxAdapter(
                child: LoadingWidget(
                  loadingText: MyAppLocalizations.of(context)!.moreMovies,
                ),
              ),
            );
          },
          selector: (ctx, vm) => vm.isLoading,
        ),
      ],
    );
  }
}
