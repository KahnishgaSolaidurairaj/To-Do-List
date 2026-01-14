import 'package:flutter/material.dart';
import '../components/todo.dart';
import '../components/add.dart';
import '../components/storage.dart';

class General extends StatefulWidget {
  const General({super.key});

  @override
  State<General> createState() => _GeneralTabState();
}

class _GeneralTabState extends State<General> {
  List tasks = [];
  final storage = ToDoStorage();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    tasks = await storage.loadTasks("generalTasks");
    setState(() {});
  }

  void saveTasks() {
    storage.saveTasks("generalTasks", tasks);
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        controller: controller,
        onSave: () {
          setState(() {
            tasks.add({"task": controller.text, "completed": false});
          });
          controller.clear();
          saveTasks();
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  void toggleCheckbox(int index) {
    setState(() {
      tasks[index]["completed"] = !tasks[index]["completed"];
    });
    saveTasks();
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => ToDoComponent(
          taskName: tasks[index]["task"],
          taskCompleted: tasks[index]["completed"],
          onChanged: (value) => toggleCheckbox(index),
          deleteTask: () => deleteTask(index),
        ),
      ),
    );
  }
}
