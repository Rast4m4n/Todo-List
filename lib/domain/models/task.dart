import 'package:json_annotation/json_annotation.dart';
import 'package:todo_list/domain/enums/priority_enum.dart';

@JsonSerializable()
class Task {
  final String title;
  final String description;
  final int id;
  final bool isFavorite;
  final PriorityEnum priority;
  Task({
    required this.title,
    required this.description,
    required this.id,
    this.isFavorite = false,
    this.priority = PriorityEnum.low,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
        'id': id,
        'isFavorite': isFavorite,
        'priority': priority.value,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'] as String,
        description: json['description'] as String,
        id: json['id'] as int,
        isFavorite: json['isFavorite'] as bool,
        priority: PriorityEnumExt.getById(json['priority'] as int),
      );

  Task copyWith({
    String? title,
    String? description,
    int? id,
    bool? isFavorite,
    PriorityEnum? priority,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
      isFavorite: isFavorite ?? this.isFavorite,
      priority: priority ?? this.priority,
    );
  }
}
