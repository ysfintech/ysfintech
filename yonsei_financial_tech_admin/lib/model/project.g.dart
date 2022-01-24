// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      content: json['content'] as String,
      from: json['from'] as String,
      id: json['id'] as int,
      imageDesc: json['imageDesc'] as String,
      imagePath: json['imagePath'] as String,
      period: json['period'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'content': instance.content,
      'from': instance.from,
      'id': instance.id,
      'imageDesc': instance.imageDesc,
      'imagePath': instance.imagePath,
      'period': instance.period,
      'title': instance.title,
    };
