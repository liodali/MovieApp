import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/movie.dart';
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
    }, [detailVM]);
    return Scaffold(
      primary: true,
      body: NestedScrollView(
        headerSliverBuilder: (ctx, _) {
          return [
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 8,
                    top: 5,
                    bottom: 5,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(32, 24),
                        padding: EdgeInsets.all(12),
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Icon(
                      Icons.bookmark_border,
                      size: 26,
                    ),
                  ),
                ),
              ],
              pinned: true,
              flexibleSpace: FlexibleAppBarMovieDetail(),
              expandedHeight: 256,
              //backgroundColor: Colors.transparent,
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
