import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  @JsonKey(name: '_id')
  String id;
  String title;
  bool isDone;

  Todo({this.id, this.title, this.isDone = false});

  toggle() {
    isDone = !isDone;
  }

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}