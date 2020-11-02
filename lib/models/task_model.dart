import 'dart:convert';

class Task {
  int id;
  String title;
  DateTime date;
  String priority;
  int status;

  Task({
    this.title,
    this.date,
    this.priority,
    this.status,
  });

  Task.withId({
    this.id,
    this.title,
    this.date,
    this.priority,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? null,
      'title': title,
      'date': date?.millisecondsSinceEpoch,
      'priority': priority,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Task.withId(
      id: map['id'],
      title: map['title'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      priority: map['priority'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
