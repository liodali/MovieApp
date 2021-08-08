import 'package:flutter/material.dart';
import 'package:movie_app/app/ui/widget/flexible_movie_detail.dart';
import 'package:movie_app/app/viewmodel/DetailMovieViewModel.dart';
import 'package:movie_app/domain/models/movie.dart';
import 'package:provider/provider.dart';

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
      child: Scaffold(
        primary: true,
        body: NestedScrollView(
          headerSliverBuilder: (ctx, _) {
            return [
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [],
                pinned: true,
                flexibleSpace: FlexibleAppBarMovieDetail(),
                expandedHeight: 256,
                backgroundColor: Colors.transparent,
              ),
            ];
          },
          body: Stack(
            children: [],
          ),
        ),
      ),
    );
  }
}
