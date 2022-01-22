// class Information {
//   final String title;
//   final String content;

//   Information({this.content, this.title});
// }

import 'package:json_annotation/json_annotation.dart';

part 'introduction.g.dart';

@JsonSerializable()
class Intro {
  final String content;
  final int id;
  final String imagePath;
  final String name;
  final String role;
  final String title;

  Intro({
    required this.content,
    required this.id,
    required this.imagePath,
    required this.name,
    required this.role,
    required this.title,
  });

  factory Intro.fromJson(Map<String, dynamic> json) => _$IntroFromJson(json);
  Map<String, dynamic> toJson() => _$IntroToJson(this);

  Intro.clone(Intro intro)
      : this(
          content: intro.content,
          id: intro.id,
          imagePath: intro.imagePath,
          name: intro.name,
          role: intro.role,
          title: intro.title,
        );

  Intro shallowCopyWithImagePath(String newPath) => Intro(
        content: this.content,
        id: this.id,
        imagePath: newPath,
        name: this.name,
        role: this.role,
        title: this.title,
      );
}
