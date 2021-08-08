import 'package:flutter/material.dart';
import 'package:movie_app/app/viewmodel/DetailMovieViewModel.dart';
import 'package:provider/provider.dart';

class OverviewDetailMovie extends StatelessWidget {
  const OverviewDetailMovie({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String overview = context.read<DetailMovieViewModel>().movie.overview;
    return Text.rich(
      TextSpan(
        text: "Overview\n\n",
        style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 18,
                ) ??
            TextStyle(
              fontSize: 18,
            ),
        children: [
          TextSpan(
            text: overview,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
