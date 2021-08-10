import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/DetailMovieViewModel.dart';
import 'movie_image.dart';
import 'note_movie.dart';

class FlexibleAppBarMovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = context.read<DetailMovieViewModel>().movie;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return HookBuilder(builder: (ctx) {
          var maxHeight = useState(constraints.maxHeight);
          final maxPaddingLeft = 120.0;
          final maxPaddingBottom = 42.0;
          final maxFontSizeText = 16.0;
          final paddingLeft = useState(maxPaddingLeft);
          final paddingBottom = useState(maxPaddingBottom);
          final fontSizeText = useState(10.0);
          useEffect(() {
            if (constraints.maxHeight > 100 &&
                maxHeight.value < constraints.maxHeight) {
              if (paddingLeft.value < maxPaddingLeft) paddingLeft.value += 2;
              if (paddingBottom.value < maxPaddingBottom)
                paddingBottom.value += 2;
              if (fontSizeText.value > 10) {
                fontSizeText.value--;
              }
            } else if (constraints.maxHeight > 96 &&
                maxHeight.value > constraints.maxHeight) {
              if (paddingLeft.value > 56.0) paddingLeft.value -= 2;
              if (paddingBottom.value > 16.0) paddingBottom.value -= 2;
              if (fontSizeText.value < maxFontSizeText) {
                fontSizeText.value++;
              }
            }
            maxHeight.value = constraints.maxHeight;
          });
          return FlexibleSpaceBar(
            background: Stack(
              children: [
                if (movie.backdrop != null) ...[
                  MovieImage(
                    url: "w780${movie.backdrop!}",
                    size: Size(MediaQuery.of(context).size.width, 256),
                    fit: BoxFit.fill,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0),
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(1)
                        ],
                        stops: [0.6, 0.8],
                      ),
                    ),
                  ),
                ],
                Positioned(
                  height: 136,
                  bottom: 12,
                  left: 12,
                  width: 96,
                  child: Hero(
                    tag: movie.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: MovieImage(
                        url: "w780${movie.poster!}",
                        size: Size.fromHeight(136),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 120,
                  child: Hero(
                    tag: "${movie.vote + movie.voteCount}",
                    child: Material(
                      type: MaterialType.transparency,
                      child: IntrinsicWidth(
                        child: NoteMovie(
                          note: movie.vote,
                          votes: movie.voteCount,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: Hero(
              tag: movie.title,
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  movie.title,
                  style: TextStyle(
                    fontSize: fontSizeText.value,
                  ),
                ),
              ),
            ),
            titlePadding: EdgeInsets.only(
              left: paddingLeft.value.toDouble(),
              bottom: paddingBottom.value.toDouble(),
              right: 5,
            ),
            centerTitle: false,
          );
        });
      },
    );
  }
}
