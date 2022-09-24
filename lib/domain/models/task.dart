import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Task {
  final String title;
  final String description;
  final int id;
  final bool isFavorite;
  Task({
    required this.title,
    required this.description,
    required this.id,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
        'id': id,
        'isFavorite': isFavorite,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'] as String,
        description: json['description'] as String,
        id: json['id'] as int,
        isFavorite: json['isFavorite'] as bool,
      );

  Task copyWith({
    String? title,
    String? description,
    int? id,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
