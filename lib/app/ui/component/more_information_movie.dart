import 'package:flutter/material.dart';
import 'package:movie_app/app/common/utilities.dart';
import 'package:movie_app/app/ui/widget/badge_movie.dart';
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieInformation(
              icon: Icon(Icons.access_time),
              information:
                  "${detail?.runtime != null && detail?.runtime != 0 ? calculateDurationMovie(detail!.runtime!) : "-"}",
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
              icon: Padding(
                padding: EdgeInsets.only(
                  top: 12.0,
                ),
                child: Icon(Icons.local_movies),
              ),
              informationWidget: detail != null
                  ? Container(
                      width: MediaQuery.of(context).size.width - 64,
                      child: Wrap(
                        direction: Axis.horizontal,
                        verticalDirection: VerticalDirection.down,
                        spacing: 5.0,
                        children: detail.genres
                            .map((e) => e.name)
                            .map(
                              (e) => BadgeMovie(
                                elevation: 1,
                                color: Theme.of(context).dividerColor,
                                title: Text(e),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : Text("-"),
              // information:
              //     "${detail?.genres.map((e) => e.name).reduce((value, element) => "$value,$element") ?? "-"}",
            ),
          ],
        );
      },
    );
  }
}
