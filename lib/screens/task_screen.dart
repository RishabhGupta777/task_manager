import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'add_task_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TaskProvider>(context, listen: false).fetchTasks());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text("My Tasks", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: provider.tasks.length,
        itemBuilder: (context, index) {
          final task = provider.tasks[index];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: task.completed ? Colors.white.withOpacity(0.6) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  activeColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  value: task.completed,
                  onChanged: task.completed ? null : (value) => provider.completeTask(task.id),
                ),
              ),
              title: Text(task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: task.completed ? TextDecoration.lineThrough : null,
                    color: task.completed ? Colors.grey : Colors.black87,
                  )),
              subtitle: Text(task.description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: task.completed ? TextDecoration.lineThrough : null,
                    color: task.completed ? Colors.grey : Colors.black87,
                  )
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () => provider.deleteTask(task.id),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          builder: (context) => AddTaskScreen(),
        ),
        label: const Text("New Task",style: TextStyle(color: Colors.white),),
        icon: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}