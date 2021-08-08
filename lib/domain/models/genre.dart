import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genre {
  final int id;
  final String name;

  factory Genre.fromJson(Map<String, dynamic> json) =>
      _$GenreFromJson(json);


  Map<String, dynamic> toJson() => _$GenreToJson(this);

  Genre(this.id, this.name,);
}