class exception implements Exception {
  String message;
  exception(this.message);
  @override
  String toString() => "$message";
}

enum Priority { low, medium, high }

enum Type { normal, urgent }

enum Status { pending, done }

class Task {
  static int id = 0;
  final int ID;
  final Type type;
  final String title;
  final DateTime is_created;
  final Priority priority;
  final DateTime deadline;
  Status status = Status.pending;

  Task(this.type, this.title, this.is_created,this.priority, this.deadline, this.status)
    : ID = id++;
  @override
  String toString()=>"$ID | $type | $title | $is_created | $deadline | $status |";
  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'type': type,
      'title': title,
      'is_created':is_created,
      'priority': priority,
      'deadline': deadline.toIso8601String(),
      'status': status,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['type'],
      json['title'],
      json['is_created'],
      json['priority'],
      json['deadline'],
      json['status'],
    );
  }
}
