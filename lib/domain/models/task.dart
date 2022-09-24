import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Task {
  final String title;
  final String description;
  final int id;
  Task({
    required this.title,
    required this.description,
    required this.id,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
        'id': id,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'] as String,
        description: json['description'] as String,
        id: json['id'] as int,
      );
}
