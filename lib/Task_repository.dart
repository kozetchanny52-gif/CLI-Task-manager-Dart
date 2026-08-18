import 'Task.dart';
import 'dart:convert';
import 'dart:io';

List<Task> tasks_db = [];

abstract class Repository<T> {
  void add_task(T task);
  void update(T task);
  void delete(T task);
  void show_tasks();
  void sort_tasks(String priority);
}

class TaskStorage implements Repository<Task> {
  TaskStorage();
  @override
  void add_task(task) {
    tasks_db = loadTasks();
    tasks_db.add(task);
    saveTasks(tasks_db);
  }

  @override
  void delete(task) {
    tasks_db = loadTasks();
    if (tasks_db.isEmpty) {
      exception("ADVISABLE TO ADD A TASK!");
    } else {
      tasks_db.remove(Task);
      saveTasks(tasks_db);
    }
  }

  @override
  void update(task) {
    if (tasks_db.isEmpty) {
      exception("ADVISABLE TO ADD A TASK!");
    } else {
      task.status = task.status.name == "pending"
          ? Status.pending
          : Status.done;
      saveTasks(tasks_db);
    }
  }

  @override
  void show_tasks() {
    tasks_db = loadTasks();
    tasks_db.isEmpty
        ? exception("ADVISABLE TO ADD A TASK!")
        : print(tasks_db.join("\n"));
  }

  @override
  void sort_tasks(String priority) {
    tasks_db = loadTasks();
    if (tasks_db.isEmpty) {
      exception("ADVISABLE TO ADD A TASK");
    } else {
      if (priority == 'low') {
        var low_tasks = tasks_db.firstWhere(
          (task) => task.priority == Priority.low,
        );
        print(low_tasks.toString());
      } else if (priority == 'medium') {
        var medium_tasks = tasks_db.firstWhere(
          (task) => task.priority == Priority.medium,
        );
        print(medium_tasks.toString());
      } else if (priority == 'high') {
        var high_tasks = tasks_db.firstWhere(
          (task) => task.priority == Priority.high,
        );
        print(high_tasks.toString());
      }
    }
  }
}

void saveTasks(tasks_db) {
  final file = File('tasks.json');

  final jsonData = jsonEncode(tasks_db.map((task) => task.toJson()).toList());

  file.writeAsStringSync(jsonData);
}

List<Task> loadTasks() {
  final file = File('tasks.json');

  if (!file.existsSync()) {
    return [];
  }

  final jsonData = file.readAsStringSync();

  final List<dynamic> data = jsonDecode(jsonData);

  return data.map((item) => Task.fromJson(item)).toList();
}
