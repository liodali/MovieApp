import 'package:json_annotation/json_annotation.dart';

part 'gender.g.dart';

@JsonSerializable()
class Gender {
  final int id;
  final String name;

  factory Gender.fromJson(Map<String, dynamic> json) =>
      _$GenderFromJson(json);


  Map<String, dynamic> toJson() => _$GenderToJson(this);

  Gender(this.id, this.name,);
}