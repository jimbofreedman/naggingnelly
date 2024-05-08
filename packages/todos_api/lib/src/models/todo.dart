import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos_api/todos_api.dart';

part 'todo.g.dart';

/// {@template todo_item}
/// A single `todo` item.
///
/// Contains a [title], [description] and [id], in addition to a [isCompleted]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Todo]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Todo extends Equatable {
  /// {@macro todo_item}
  Todo(
      {required this.title,
      this.id = null,
      this.description = '',
      DateTime? createdAt,
      this.isCompleted = false,
      this.order = -1,
      this.startAt = null,
      this.dueAt = null,
      this.streak = null,
      this.streakSavers = null,
      this.streakHistory = const {}})
      : createdAt = createdAt ?? DateTime.now();

  /// The unique identifier of the `todo`.
  ///
  /// Cannot be empty.
  final String? id;

  /// The title of the `todo`.
  ///
  /// Note that the title may be empty.
  final String title;

  /// The description of the `todo`.
  ///
  /// Defaults to an empty string.
  final String description;

  /// Whether the `todo` is completed.
  ///
  /// Defaults to `false`.
  final bool isCompleted;

  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime createdAt;

  final num order;
  @JsonKey(fromJson: nullableDateTimeFromTimestamp)
  final DateTime? startAt;
  @JsonKey(fromJson: nullableDateTimeFromTimestamp)
  final DateTime? dueAt;
  final int? streak;
  final int? streakSavers;
  final Map<DateTime, DateTime?> streakHistory;

  /// Returns a copy of this `todo` with the given values updated.
  ///
  /// {@macro todo_item}
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    bool? isCompleted,
    num? order,
    DateTime? startAt,
    DateTime? dueAt,
    int? streak,
    int? streakSavers,
    Map<DateTime, DateTime?>? streakHistory,
  }) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        isCompleted: isCompleted ?? this.isCompleted,
        order: order ?? this.order,
        startAt: startAt ?? this.startAt,
        dueAt: dueAt ?? this.dueAt,
        streak: streak ?? this.streak,
        streakSavers: streakSavers ?? this.streakSavers,
        streakHistory: streakHistory ?? this.streakHistory);
  }

  /// Deserializes the given [JsonMap] into a [Todo].
  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);

  /// Converts this [Todo] into a [JsonMap].
  JsonMap toJson() => _$TodoToJson(this);

  @override
  List<Object> get props => [
        id ?? "",
        title,
        description,
        order,
        startAt ?? "",
        dueAt ?? "",
        streak ?? "",
        streakSavers ?? "",
        streakHistory
      ];

  static DateTime? nullableDateTimeFromTimestamp(dynamic timestamp) {
    return timestamp != null ? dateTimeFromTimestamp(timestamp!) : null;
  }

  static DateTime dateTimeFromTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else {
      final DateTime d = DateTime.parse(timestamp);
      return d;
    }
  }
}
