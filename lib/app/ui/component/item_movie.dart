import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app/ui/widget/movie_image.dart';
import 'package:movie_app/app/ui/widget/note_movie.dart';

import '../../../domain/models/movie.dart';

class ItemMovie extends StatelessWidget {
  final Movie movie;

  const ItemMovie({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 196,
      child: Card(
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              if (movie.poster != null) ...[
                MovieImage(
                  url: "w780${movie.poster!}",
                  size: Size.fromHeight(196),
                  fit: BoxFit.fill,
                ),
                ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 2,
                    sigmaY: 2,
                  ),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black45,
                            Colors.transparent,
                          ],
                          stops: [
                            0.7,
                            1
                          ]).createShader(
                        rect,
                      );
                    },
                    blendMode: BlendMode.dstOut,
                    child: MovieImage(
                      url: "w780${movie.poster!}",
                      size: Size.fromHeight(196),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.6)
                      ],
                      stops: [0.3, 0.8],
                    ),
                  ),
                ),
              ],
              Positioned(
                bottom: 8,
                left: 3,
                right: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      movie.title,
                      maxLines: 1,
                      minFontSize: 12,
                      maxFontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                    NoteMovie(
                      note: movie.vote,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
