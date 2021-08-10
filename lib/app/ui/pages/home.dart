import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/app/common/app_localization.dart';
import 'package:movie_app/app/ui/widget/loading_widget.dart';
import 'package:movie_app/app/ui/widget/search_text_movie.dart';
import 'package:movie_app/app/ui/widget/tab_movies_types.dart';
import 'package:movie_app/domain/common/utilities.dart';
import 'package:provider/provider.dart';

import '../../common/routes.dart';
import '../../viewmodel/MoviesViewModel.dart';
import '../component/list_movies.dart';

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final offset = useState(0.0);

    useEffect(() {
      final offsetListener = () async {
        offset.value = controller.offset;
      };
      controller.addListener(offsetListener);
      return () => controller.removeListener(offsetListener);
    }, [controller]);
    final textController = useTextEditingController();
    return Scaffold(
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (notif) {
          if (notif.metrics.pixels > (notif.metrics.maxScrollExtent - 50) &&
              notif.metrics.axisDirection == AxisDirection.down) {
            final viewModel = context.read<MoviesViewModel>();
            print(
                "${notif.metrics.pixels},${notif.metrics.maxScrollExtent} : fetch ${viewModel.page}");
            Future.microtask(() async => await viewModel.getMovies());
          }
          return true;
        },
        child: CustomScrollView(
          controller: controller,
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: SearchTextMovie(
                textController: textController,
                hint: MyAppLocalizations.of(context)!.searchHint,
                onTap: () {},
              ),
              pinned: true,
              floating: false,
              forceElevated: true,
              elevation: 2,
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ElevatedButton(
                      onPressed: () async {
                        await context
                            .navigate(AppRouter.favoriteMoviesNamePage);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          minimumSize: Size(48, 24),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      child: Icon(
                        Icons.bookmark_border,
                        size: 24,
                      )),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(72),
                child: TabMoviesTypes(
                  tabs: categoriesMovies,
                  selectedCategory: (category) async {
                    if (offset.value > 100) {
                      controller.jumpTo(0);
                    }
                    final movieViewModel = context.read<MoviesViewModel>();
                    movieViewModel.setTypeMovieSelected(category);
                    await movieViewModel.getMovies(restart: true);
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              sliver: ListMovies(),
            ),
            SliverToBoxAdapter(
              child: Selector<MoviesViewModel, bool>(
                builder: (ctx, isLoading, _) {
                  if (!isLoading) {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: LoadingWidget(
                      loadingText: MyAppLocalizations.of(context)!.moreMovies,
                    ),
                  );
                },
                selector: (ctx, vm) => vm.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
