import 'package:flutter/cupertino.dart';

class Note extends Comparable<Note> {
  final int id;
  final int priority;
  final String title;
  final String dateTime;
  int isFinished;

  Note({
    this.id,
    @required this.priority,
    @required this.title,
    @required this.dateTime,
    @required this.isFinished,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      priority: map['priority'],
      title: map['title'],
      dateTime: map['dateTime'],
      isFinished: map['isFinished'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'priority': priority,
        'title': title,
        'dateTime': dateTime,
        'isFinished': isFinished,
      };

  @override
  int compareTo(Note other) {
    if (priority < other.priority)
      return 1;
    else if (priority > other.priority)
      return -1;
    else
      return 0;
  }

  @override
  String toString() {
    return priority.toString() + ' , ' + title;
  }
}
