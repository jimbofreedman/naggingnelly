import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.completed,
    required this.createdAt,
    required this.startAt,
    required this.dueAt,
    required this.streak,
    required this.streakSavers,
    required this.streakHistory,
  });
  String id;
  String title;
  bool completed;
  DateTime? createdAt;
  DateTime? startAt;
  DateTime? dueAt;
  int? streak;
  int? streakSavers;
  Map<DateTime, DateTime?> streakHistory;

  Todo copyWith({
    String? id,
    String? title,
    bool? completed,
    DateTime? createdAt,
    DateTime? startAt,
    DateTime? dueAt,
    int? streak,
    int? streakSavers,
    Map<DateTime, DateTime?> streakHistory = const {},
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      startAt: startAt ?? this.startAt,
      dueAt: dueAt ?? this.dueAt,
      streak: streak ?? this.streak,
      streakSavers: streakSavers ?? this.streakSavers,
      streakHistory:
          streakHistory.isNotEmpty ? streakHistory : this.streakHistory,
    );
  }

  // ignore: prefer_constructors_over_static_methods
  static Todo fromJson(String id, Map<String, dynamic> data) {
    final raw = data['streakHistory'];
    final streakHistory = (raw != null)
        ? (raw as Map<dynamic, dynamic>).map(
            (dynamic k, dynamic v) =>
                MapEntry((k as Timestamp).toDate(), (v as Timestamp).toDate()),
          )
        : <DateTime, DateTime?>{};

    return Todo(
      id: id,
      title: data['title'] as String,
      completed: data['completed'] as bool,
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      startAt: data['startAt'] != null
          ? (data['startAt'] as Timestamp).toDate()
          : null,
      dueAt:
          data['dueAt'] != null ? (data['dueAt'] as Timestamp).toDate() : null,
      streak: data['streak'] as int,
      streakSavers: data['streakSavers'] as int,
      streakHistory: streakHistory,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
      'createdAt': createdAt,
      'startAt': startAt,
      'dueAt': dueAt,
      'streak': streak,
      'streakSavers': streakSavers,
      'streakHistory': streakHistory,
    };
  }

  void complete() {
    if (startAt != null && dueAt != null) {
      streak = (streak ?? 0) + 1;
      if ((streak!) % 7 == 0) {
        streakSavers = (streakSavers ?? 0) + 1;
      }
      streakHistory[startAt!] = dueAt;
    }
    startAt = startAt?.add(const Duration(days: 1));
    dueAt = dueAt?.add(const Duration(days: 1));
  }

  void fail() {
    if ((streakSavers ?? 0) > 0) {
      streakSavers = (streakSavers!) - 1;
    } else {
      streak = 0;
    }

    streakHistory[startAt!] = null;
    startAt = startAt?.add(const Duration(days: 1));
    dueAt = dueAt?.add(const Duration(days: 1));
  }
}
