import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/app/common/app_localization.dart';
import 'package:movie_app/app/ui/widget/action_dialog.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/movie.dart';
import '../../common/routes.dart';
import '../../viewmodel/DetailMovieViewModel.dart';
import '../component/more_information_movie.dart';
import '../component/overview_detail_movie.dart';
import '../widget/flexible_movie_detail.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => DetailMovieViewModel(movie),
      child: MovieDetailCore(),
    );
  }
}

class MovieDetailCore extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final detailVM = context.read<DetailMovieViewModel>();
    useEffect(() {
      detailVM.getDetailMovie();
      detailVM.checkIsFav();
    }, [detailVM]);
    return Scaffold(
      primary: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => context.pop(),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: 8,
                  top: 5,
                  bottom: 5,
                ),
                child: IconButton(
                  onPressed: () async {
                    int response = await showDialog(
                      context: context,
                      builder: (ctx) {
                        return ActionDialog(
                          action: () async {
                            int response = 0;
                            if (!detailVM.isFav) {
                              response = await detailVM.addToFavorite();
                            } else {
                              response = await detailVM.removeFromFavorite();
                            }

                            Navigator.pop(ctx, response);
                          },
                        );
                      },
                    );
                    var message = "";
                    switch (response) {
                      case 200:
                        message = detailVM.isFav
                            ? MyAppLocalizations.of(context)!
                            .successRemoveFromFav
                            : MyAppLocalizations.of(context)!.successAddToFav;
                        break;
                      case 400:
                        message = detailVM.isFav
                            ? MyAppLocalizations.of(context)!
                            .failedToRemoveFromFav
                            : MyAppLocalizations.of(context)!
                            .failedToAddToFav;

                        break;
                    }
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                    detailVM.setIsFav(!detailVM.isFav);
                  },
                  iconSize: 24,
                  icon: Selector<DetailMovieViewModel, bool>(
                    selector: (ctx, vm) => vm.isFav,
                    builder: (ctx, isFav, _) {
                      return Icon(
                        isFav ? Icons.bookmark : Icons.bookmark_border,
                        color: isFav ? Colors.amber : null,
                        size: 24,
                      );
                    },
                  ),
                ),
              ),
            ],
            pinned: true,
            flexibleSpace: FlexibleAppBarMovieDetail(),
            expandedHeight: 256,
            //backgroundColor: Colors.transparent,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: true,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        MoreInformationMovie(),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: OverviewDetailMovie(),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
