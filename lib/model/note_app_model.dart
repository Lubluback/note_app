import 'package:json_annotation/json_annotation.dart';
part 'note_app_model.g.dart';

@JsonSerializable()
class NoteAppModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'content')
  String? content;

  NoteAppModel({
    this.id,
    this.title,
    this.content,
  });

  NoteAppModel.create({
    required this.id,
    required this.title,
    required this.content,
  });
  

  factory NoteAppModel.fromJson(Map<String, dynamic> json) {
    return _$NoteAppModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NoteAppModelToJson(this);
}
//{"id":"123","name":"luba"}
//"{"id":"123","name":"luba"}"
