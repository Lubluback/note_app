// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteAppModel _$NoteAppModelFromJson(Map<String, dynamic> json) => NoteAppModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$NoteAppModelToJson(NoteAppModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'content': instance.content,
    };
