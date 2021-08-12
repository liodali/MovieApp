import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app/ui/widget/movie_image.dart';
import 'package:movie_app/app/ui/widget/note_movie.dart';
import 'package:movie_app/domain/models/movie.dart';

class ItemMovieFav extends StatelessWidget {
  final Movie movie;
  final String? titleSearchToColor;
  final Widget Function(Movie) actionMovie;

  //final Function(Movie movie)? delete;

  const ItemMovieFav({
    Key? key,
    required this.movie,
    required this.actionMovie,
    this.titleSearchToColor,
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
                    errorWidget: Icon(
                      Icons.movie,
                      size: 24,
                      color: Colors.grey,
                    ),
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
                      title: titleSearchToColor != null &&
                              titleSearchToColor!.isNotEmpty
                          ? AutoSizeText.rich(
                              TextSpan(
                                children: compute(
                                  titleSearchToColor!,
                                  Theme.of(context).errorColor,
                                ),
                              ),
                              minFontSize: 16,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            )
                          : AutoSizeText(
                              movie.title,
                              minFontSize: 16,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
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
              actionMovie(movie),
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> compute(String textToColor, Color textColor) {
    List<TextSpan> textsSpanTitle = [];
    List<String> searchWords = textToColor.toLowerCase().split(" ");
    // 2. remove duplicated searchable text
    searchWords = Set<String>.from(searchWords).toList();

    // 3. organize filter by length for more precision
    // et save  existing  filters in title
    searchWords.sort((a, b) => b.length.compareTo(a.length));
    searchWords = searchWords
        .where((searchWord) =>
            searchWord.trim().isNotEmpty &&
                movie.title.toLowerCase().contains(searchWord))
        .map((searchWord) => searchWord.toLowerCase())
        .toList();

    // 4. organize  filters with their position in title
    searchWords.sort((a, b) => movie.title
        .toLowerCase()
        .indexOf(a)
        .compareTo(movie.title.toLowerCase().indexOf(b)));
    String titleName = movie.title.toLowerCase();
    searchWords.sort((a, b) {
      if (searchWords.indexOf(a) > 0) {
        titleName =
            titleName.replaceFirst(searchWords[searchWords.indexOf(a) - 1], "");
      }
      return (titleName.indexOf(a) == titleName.indexOf(b))
          ? b.length.compareTo(a.length)
          : titleName.indexOf(a).compareTo(titleName.indexOf(b));
    });

    String mtitle = movie.title;
    while (mtitle.isNotEmpty) {
      // 5. delete  filters where their are not exist in the title anymore
      searchWords = searchWords
          .where((searchWord) =>
              searchWord.length <= mtitle.length &&
              mtitle.toLowerCase().contains(searchWord))
          .toList();
      if (searchWords.isNotEmpty &&
          mtitle.toLowerCase().indexOf(searchWords.first) == 0) {
        textsSpanTitle.add(
          TextSpan(
            text: mtitle.substring(0, searchWords.first.length),
            style: TextStyle(color: textColor),
          ),
        );
        mtitle = mtitle.substring(searchWords.first.length);
        searchWords.removeAt(0);
      } else if (searchWords.isNotEmpty &&
          mtitle.toLowerCase().indexOf(searchWords.first) != 0) {
        textsSpanTitle.add(
          TextSpan(
              text: mtitle.substring(
                  0, mtitle.toLowerCase().indexOf(searchWords.first))),
        );
        mtitle = mtitle.substring(mtitle.toLowerCase().indexOf(searchWords.first));
      } else {
        textsSpanTitle.add(
          TextSpan(text: mtitle.substring(0)),
        );
        mtitle = "";
      }
    }
    return textsSpanTitle;
  }
}
