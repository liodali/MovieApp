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
    final controller = useScrollController();
    useEffect(() {
      controller.addListener(() async {
        if (controller.offset > -56 &&
            !controller.position.outOfRange &&
            controller.position.axisDirection == AxisDirection.down) {
          final viewModel = context.read<MoviesViewModel>();
          print(
              "${controller.offset},${controller.position.maxScrollExtent} : fetch ${viewModel.page}");
          Future.microtask(() async => await viewModel.getMovies());
        }
      });
    }, [controller]);
    final textController = useTextEditingController();
    return Scaffold(
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        headerSliverBuilder: (ctx, _) {
          return [
            SliverAppBar(
              title: SearchTextMovie(
                textController: textController,
                hint: MyAppLocalizations.of(context)!.searchHint,
                onTap: () {},
              ),
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
          ];
        },
        body: ListMovies(),
      ),
    );
  }
}
