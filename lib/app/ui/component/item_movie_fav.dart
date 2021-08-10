import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app/ui/widget/movie_image.dart';
import 'package:movie_app/app/ui/widget/note_movie.dart';
import 'package:movie_app/domain/models/movie.dart';

class ItemMovieFav extends StatelessWidget {
  final Movie movie;
  final Function(Movie movie)? delete;

  const ItemMovieFav({
    Key? key,
    required this.movie,
    this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 132,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: MovieImage(
                    url: "w780${movie.poster}",
                    size: Size(84, 128),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      title: AutoSizeText(
                        movie.title,
                        minFontSize: 16,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      subtitle: AutoSizeText(movie.releaseDate ?? ""),
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      isThreeLine: false,
                    ),
                    NoteMovie(
                      note: movie.vote,
                      votes: movie.voteCount,
                      elevation: 3,
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (delete != null) {
                    await delete!(movie);
                  }
                },
                icon: Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}
