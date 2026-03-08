import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/button.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final title = TextEditingController();
  final description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 24, right: 24, top: 32,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("New Task", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1A1C1E))),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 24),

          _buildLabel("Title"),
          _buildCustomTextField(title, "Task title", isFocused: true),

          const SizedBox(height: 20),

          _buildLabel("Description"),
          _buildCustomTextField(description, "Describe your task...", maxLines: 4),

          const SizedBox(height: 32),


          TButton(text: "Create Task",
              onTap: () async {
                if (title.text.isNotEmpty) {
                 await provider.createTask(title.text, description.text);
                Navigator.pop(context);
               }},
            width: double.infinity,
            height: 56,
            backgroundColor: Colors.deepPurple,
          ),

        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF44474E))),
    );
  }

  Widget _buildCustomTextField(TextEditingController controller, String hint, {int maxLines = 1, bool isFocused = false}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF8E9199)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE1E2EC), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF4F52E1), width: 2), // The blue focus line
        ),
      ),
    );
  }
}