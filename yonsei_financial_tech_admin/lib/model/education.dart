import 'package:json_annotation/json_annotation.dart';

part 'education.g.dart';

@JsonSerializable()
class Edu {
  final String content;
  final String title;

  Edu({required this.content, required this.title});

  factory Edu.fromJson(Map<String, dynamic> json) => _$EduFromJson(json);
  Map<String, dynamic> toJson() => _$EduToJson(this);
}