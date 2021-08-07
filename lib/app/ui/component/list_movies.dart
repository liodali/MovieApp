import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
      viewModel.initMovies("/popular");
    });
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(),
        StreamComponent<List<Movie>>(
          stream: viewModel.stream!,
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
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Text((movies[0] as Movie).title);
                },
                itemCount: movies.length,
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: false,
              ),
            );
          },
        ),
      ],
    );
  }
}
