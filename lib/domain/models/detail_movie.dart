
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/domain/models/genre.dart';

part 'detail_movie.g.dart';


@JsonSerializable()
class DetailMovie{

  final int revenue;

  final int? runtime;
  final String status;
  final String? tagline;
  @JsonKey(name: "original_language")
  final String? originalLanguage;

 final List<Genre> genres;

  factory DetailMovie.fromJson(Map<String, dynamic> json) =>
      _$DetailMovieFromJson(json);

  DetailMovie(this.genres, this.revenue, this.runtime, this.status, this.tagline, this.originalLanguage);

  Map<String, dynamic> toJson() => _$DetailMovieToJson(this);
}