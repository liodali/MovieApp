import 'package:flutter/material.dart';
import 'package:movie_app/app/common/utilities.dart';
import 'package:movie_app/app/ui/widget/movie_information.dart';
import 'package:movie_app/app/viewmodel/DetailMovieViewModel.dart';
import 'package:movie_app/domain/models/detail_movie.dart';
import 'package:provider/provider.dart';

class MoreInformationMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<DetailMovieViewModel, DetailMovie?>(
      selector: (ctx, vm) => vm.detailMovie,
      builder: (ctx, detail, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieInformation(
              icon: Icon(Icons.access_time),
              information:
              "${detail?.runtime != null ? calculateDurationMovie(detail!.runtime!) : "-"}",
            ),
            SizedBox(
              height: 5,
            ),
            MovieInformation(
              icon: Icon(Icons.public),
              information: "${detail?.originalLanguage?.toUpperCase() ?? "-"}",
            ),
            SizedBox(
              height: 5,
            ),
            MovieInformation(
              icon: Icon(Icons.local_movies),
              information:
              "${detail?.genres.map((e) => e.name).reduce((value, element) => "$value,$element") ?? "-"}",
            ),
          ],
        );
      },
    );
  }
}
