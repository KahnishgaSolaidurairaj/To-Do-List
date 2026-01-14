import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController controller;
  final Function() onSave;
  final Function() onCancel;

  const AddTaskDialog({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Task"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "Enter task name"),
      ),
      actions: [
        TextButton(onPressed: onCancel, child: const Text("Cancel")),
        ElevatedButton(onPressed: onSave, child: const Text("Save")),
      ],
    );
  }
}
