import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:humanize_duration/humanize_duration.dart';
import 'package:todos_repository/todos_repository.dart';

extension RoundDurationExtension on Duration {
  /// Rounds the time of this duration up to the nearest multiple of [to].
  Duration ceil(Duration to) {
    final us = inMicroseconds;
    final toUs = to.inMicroseconds.abs(); // Ignore if [to] is negative.
    final mod = us % toUs;
    if (mod != 0) {
      return Duration(microseconds: us - mod + toUs);
    }
    return this;
  }
}

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    required this.todo,
    super.key,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
    this.confirmDismiss,
  });

  final Todo todo;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final ConfirmDismissCallback? confirmDismiss;
  final VoidCallback? onTap;

  Duration clampDueDate(DateTime dueAt) {
    final duration = dueAt.difference(DateTime.now());

    if (duration.inDays.abs() >= 7) {
      return duration.ceil(const Duration(days: 7));
    } else if (duration.inDays.abs() >= 1) {
      return duration.ceil(const Duration(days: 1));
    } else if (duration.inHours.abs() >= 1) {
      return duration.ceil(const Duration(hours: 1));
    } else if (duration.inMinutes.abs() >= 1) {
      return duration.ceil(const Duration(minutes: 1));
    } else {
      return duration;
    }
  }

  Widget dueDuration(BuildContext context, DateTime dueAt) {
    final duration = clampDueDate(dueAt);
    final theme = Theme.of(context);

    if (duration.inSeconds > 0) {
      return Text(
        'Due in ${humanizeDuration(duration)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: theme.colorScheme.primary,
        ),
      );
    } else {
      return Text(
        'Due ${humanizeDuration(duration)} ago',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: theme.colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: Key('todoListTile_dismissible_${todo.id}'),
      onDismissed: onDismissed,
      confirmDismiss: confirmDismiss,
      background: Container(
        alignment: Alignment.centerLeft,
        color: theme.colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.check_circle,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ExpansionTile(
        title: ListTile(
          onTap: onTap,
          title: Text(
            todo.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: !todo.isCompleted
                ? null
                : TextStyle(
                    color: captionColor,
                    decoration: TextDecoration.lineThrough,
                  ),
          ),
          subtitle:
              todo.dueAt != null ? dueDuration(context, todo.dueAt!) : null,
          leading: todo.streak != null
              ? badges.Badge(
                  badgeContent: Text(
                    todo.streak.toString(),
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: theme.colorScheme.primary,
                  ),
                )
              : null,
        ),
        children: <Widget>[
          Text(todo.id ?? 'no id'),
          Text(todo.description),
          Text(todo.startAt.toString()),
          Text(todo.dueAt.toString()),
          Text(todo.streak.toString()),
          Text(todo.streakSavers.toString()),
          Text(todo.streakHistory.toString()),
        ],
      ),
    );
  }
}
