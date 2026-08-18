// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'Task.dart';
import 'Task_repository.dart';

class TaskManager {
  final Storage = TaskStorage();
  TaskManager();
  void add_task() {
    DateTime? deadline;
    String? title;
    String? type_string;
    String? priority_string;
    while (title is! String) {
      print("Enter task's title");
       title = stdin.readLineSync();
    }
    title = title.toString();
    while (type_string != "normal" && type_string != "urgent") {
      print("Enter task's type 'normal,urgent'");
    }
    type_string = type_string.toString();
    Type type = Type.values.firstWhere((t) => t.name == type_string);

    while (true) {
      print("Enter deadline in (YYYY-MM--DD)");
      String deadline_string = stdin.readLineSync()!;
      if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(deadline_string)) {
        print("Invalid Format!\n Use YYYY-MM-DD.");
        continue;
      }
      if (deadline_string.isEmpty) {
        print("Invalid date");
        continue;
      }
      deadline = DateTime.tryParse(deadline_string);
      break;
    }
    ;

    while (priority_string == "low" &&
        priority_string == "medium" &&
        priority_string == "high") {
      print("Enter priority\n:'low'\n'medium'\n'high'!");
      priority_string = stdin.readLineSync();
      priority_string = priority_string.toString();
    }
    Priority priority = Priority.values.firstWhere(
      (priority) => priority.name == priority_string,
    );
    final Task task = Task(
      type,
      title,
      DateTime.now(),
      priority,
      deadline!,
      Status.pending,
    );
    Storage.add_task(task);
  }

  void view_tasks() {
    Storage.show_tasks();
  }

  void delete_task() {
    tasks_db = loadTasks();
    int index = int.parse(stdin.readLineSync()!);
    Task task = tasks_db.firstWhere((task) => task.ID == index);
    Storage.delete(task);
  }

  void update_task() {
    tasks_db = loadTasks();
    int index = int.parse(stdin.readLineSync()!);
    Task task = tasks_db.firstWhere((task) => task.ID == index);
    Storage.update(task);
  }

  void sort_tasks(String priority) {
    Storage.sort_tasks(priority);
  }
}
