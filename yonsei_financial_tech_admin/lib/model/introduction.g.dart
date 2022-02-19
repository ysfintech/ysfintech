// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'introduction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Intro _$IntroFromJson(Map<String, dynamic> json) => Intro(
      content: json['content'] as String,
      id: json['id'] as int,
      imagePath: json['imagePath'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$IntroToJson(Intro instance) => <String, dynamic>{
      'content': instance.content,
      'id': instance.id,
      'imagePath': instance.imagePath,
      'name': instance.name,
      'role': instance.role,
      'title': instance.title,
    };
