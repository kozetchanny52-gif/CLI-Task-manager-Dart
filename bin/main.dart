import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:task_manager/Task.dart';
import 'package:task_manager/Task_manager.dart';
import 'package:task_manager/task_repository.dart';

var task_manager = TaskManager();

void Priority_choice() {
  print("1.low\n2.medium\n3.high");
  int priority_choice = int.parse(stdin.readLineSync()!);
  switch (priority_choice) {
    case 1:
      task_manager.sort_tasks("low");
    case 2:
      task_manager.sort_tasks("medium");
    case 3:
      task_manager.sort_tasks("high");
    default:
      Priority_choice();
  }
}

void Menu() {
  print(
    "========MENU=======\n"
    " 1.ADD TASK\n"
    "2.MARK TASK AS DONE\n"
    "3.DELETE TASK\n"
    "4.VIEW TASKS\n"
    "5.SORT TASKS\n",
  );
  int menu_choice = int.parse(stdin.readLineSync()!);
  switch (menu_choice) {
    case 1:
      task_manager.add_task();
      quit();
    case 2:
      task_manager.update_task();
      quit();
    case 3:
      task_manager.delete_task();
      quit();
    case 4:
      task_manager.view_tasks();
    case 5:
      Priority_choice();
      quit();
    default:
      print(
        "Invalid Choice:\n"
        "1,2,3,4,5 accepted",
      );
      Menu();
  }
}

void quit() {
  String? yes_or_no;
  while (true) {
    print(
      "Wanna return to menu?"
      "Enter:'Y' or 'N'",
    );
    yes_or_no = stdin.readLineSync();
    if (yes_or_no != "Y" && yes_or_no != "N") {
      continue;
    }
    break;
  }
  yes_or_no == 'Y' ? Menu() : '';
}

void main() {
  Menu();
}
