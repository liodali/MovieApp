import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/app/common/app_localization.dart';
import 'package:movie_app/app/ui/component/item_movie.dart';
import 'package:movie_app/app/ui/widget/loading_widget.dart';
import 'package:movie_app/app/ui/widget/stream_component.dart';
import 'package:movie_app/app/viewmodel/MoviesViewModel.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:provider/provider.dart';

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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 196,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 12),
                itemBuilder: (ctx, index) {
                  return ItemMovie(
                    movie: movies[index],
                  );
                },
                itemCount: movies.length,
                addAutomaticKeepAlives: true,
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
