import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';
@JsonSerializable()
class Movie {
  final int id;
  final String title;
  @JsonKey(name: "poster_path")
  final String? poster;
  @JsonKey(name: "backdrop_path")
  final String? backdrop;
  final bool adult;
  final String overview;
  @JsonKey(name: "release_date")
  final String? releaseDate;

  final double popularity;
  @JsonKey(name: "vote_count")
  final int voteCount;
  @JsonKey(name: "vote_average")
  final double vote;

  factory Movie.fromJson(Map<String, dynamic> json) =>
      _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  Movie(
    this.id,
    this.title,
    this.poster,
    this.adult,
    this.overview,
    this.releaseDate,
    this.popularity,
    this.voteCount,
    this.vote,
    this.backdrop,
  );
}

