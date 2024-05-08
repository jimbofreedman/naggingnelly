// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      title: json['title'] as String,
      id: json['id'] as String?,
      description: json['description'] as String? ?? '',
      createdAt: Todo.dateTimeFromTimestamp(json['createdAt']),
      isCompleted: json['isCompleted'] as bool? ?? false,
      order: json['order'] as num? ?? -1,
      startAt: json['startAt'] == null
          ? null
          : Todo.nullableDateTimeFromTimestamp(json['startAt']),
      dueAt: json['dueAt'] == null
          ? null
          : Todo.nullableDateTimeFromTimestamp(json['dueAt']),
      streak: (json['streak'] as num?)?.toInt() ?? null,
      streakSavers: (json['streakSavers'] as num?)?.toInt() ?? null,
      streakHistory: (json['streakHistory'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(DateTime.parse(k),
                e == null ? null : DateTime.parse(e as String)),
          ) ??
          const {},
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'order': instance.order,
      'startAt': instance.startAt?.toIso8601String(),
      'dueAt': instance.dueAt?.toIso8601String(),
      'streak': instance.streak,
      'streakSavers': instance.streakSavers,
      'streakHistory': instance.streakHistory
          .map((k, e) => MapEntry(k.toIso8601String(), e?.toIso8601String())),
    };
