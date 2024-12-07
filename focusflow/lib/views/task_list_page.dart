import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import '../models/task.dart';
import 'add_task_page.dart';
import 'edit_task_page.dart';

class TaskListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, taskViewModel, _) {
          return FutureBuilder(
            future: taskViewModel.loadTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (taskViewModel.tasks.isEmpty) {
                return Center(
                  child: Text(
                    'No tasks available. Add some!',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return ListView.builder(
                itemCount: taskViewModel.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskViewModel.tasks[index];
                  return ListTile(
                    title: Text(task.name, style: TextStyle(color: Colors.white)),
                    subtitle: Text(task.description, style: TextStyle(color: Colors.grey[400])),
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => EditTaskPage(task: task),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AddTaskPage(),
        ),
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.blueGrey[900],
    );
  }
}
