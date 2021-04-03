import 'package:flutter/material.dart';
import 'package:sleeplogger/domain/event_type.dart';

/// Запись лога событий
class LogEntry {
  final EventType type;
  final String message;
  final int timestamp;

  LogEntry({
    @required this.type,
    @required this.message,
    @required this.timestamp,
  }) : assert(type != null && message != null && timestamp != null);
}
