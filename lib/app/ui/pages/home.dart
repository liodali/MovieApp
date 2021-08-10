import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/app/common/app_localization.dart';
import 'package:movie_app/app/ui/widget/search_text_movie.dart';
import 'package:movie_app/app/ui/widget/tab_movies_types.dart';
import 'package:movie_app/domain/common/utilities.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/MoviesViewModel.dart';
import '../component/list_movies.dart';

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // final controller = useScrollController();
    // useEffect(() {
    //   final scrollNotification = () async {
    //     if (controller.offset > controller.position.maxScrollExtent - 56 &&
    //         !controller.position.outOfRange &&
    //         controller.position.axisDirection == AxisDirection.down) {}
    //   };
    //   controller.addListener(scrollNotification);
    //   return () => controller.removeListener(scrollNotification);
    // }, [controller]);
    final textController = useTextEditingController();
    return Scaffold(
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (notif) {
          if (notif.metrics.pixels == notif.metrics.maxScrollExtent &&
              notif.metrics.axisDirection == AxisDirection.down) {
            final viewModel = context.read<MoviesViewModel>();
            print(
                "${notif.metrics.pixels},${notif.metrics.maxScrollExtent} : fetch ${viewModel.page}");
            Future.microtask(() async => await viewModel.getMovies());
          }
          return true;
        },
        child: NestedScrollView(
          //controller: controller,
          headerSliverBuilder: (ctx, _) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                sliver: SliverAppBar(
                  title: SearchTextMovie(
                    textController: textController,
                    hint: MyAppLocalizations.of(context)!.searchHint,
                    onTap: () {},
                  ),
                  pinned: true,
                  floating: false,
                  forceElevated: true,
                  elevation: 2,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(72),
                    child: TabMoviesTypes(
                      tabs: categoriesMovies,
                      selectedCategory: (category) async {
                        final movieViewModel = context.read<MoviesViewModel>();
                        movieViewModel.setTypeMovieSelected(category);
                        await movieViewModel.getMovies(restart: true);
                      },
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListMovies(),
        ),
      ),
    );
  }
}
