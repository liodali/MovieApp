import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/app/ui/widget/movie_image.dart';
import 'package:movie_app/app/ui/widget/note_movie.dart';
import 'package:movie_app/domain/models/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  const MovieDetail({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              actions: [],
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    MovieImage(
                      url: "w780${movie.backdrop!}",
                      size: Size(MediaQuery.of(context).size.width,256),
                      fit: BoxFit.fill,
                    ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                          Theme.of(context).scaffoldBackgroundColor.withOpacity(1)
                        ],
                        stops: [0.6, 0.8],
                      ),
                    ),
                  ),
                    Positioned(
                      height: 136,
                      bottom: 12,
                      left: 12,
                      width: 96,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: MovieImage(
                          url: "w780${movie.poster!}",
                          size: Size.fromHeight(136),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.title),
                          NoteMovie(
                            note: movie.vote,
                            votes: movie.voteCount,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              expandedHeight: 256,
              backgroundColor: Colors.transparent,
            ),
          ];
        },
        body: Stack(
          children: [

          ],
        ),
      ),
    );
  }
}
