import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import '../services/api_services.dart';

class TaskProvider with ChangeNotifier {

  List<Task> tasks = [];
  bool loading = false;

  final ApiService _api = ApiService();

  /// GET TASKS
  Future fetchTasks() async {

    loading = true;
    notifyListeners();

    try {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final data = await _api.get("task", token: token);

      print("TASK RESPONSE: $data");

      if (data != null && data is List) {
        tasks = data.map((e) => Task.fromJson(e)).toList();
      }

    } catch (e) {
      print("FETCH TASK ERROR: $e");
    }

    loading = false;
    notifyListeners();
  }

  Future createTask(String title,String description) async {

    try {

      final prefs = await SharedPreferences.getInstance();

      final token = prefs.getString("token");
      final userId = prefs.getString("userId");

      await _api.post(
          "task",
          {
            "title": title,
            "description": description,
            "userId": userId
          },
          token: token
      );

      await fetchTasks();

    } catch (e) {
      print("CREATE TASK ERROR: $e");
    }
  }

  /// DELETE TASK
  Future deleteTask(String id) async {

    try {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      await _api.delete("task/$id", token: token);

      await fetchTasks();

    } catch (e) {
      print("DELETE TASK ERROR: $e");
    }
  }

  ///for complete the task
  Future completeTask(String id) async {

    try {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      await _api.get(
          "task/complete/$id",
          token: token
      );

      await fetchTasks();

    } catch (e) {
      //print("COMPLETE TASK ERROR: $e");
    }
  }


  /// DASHBOARD

  int get totalTasks => tasks.length;

  int get completedTasks =>
      tasks.where((t) => t.completed).length;

  int get pendingTasks =>
      tasks.where((t) => !t.completed).length;
}