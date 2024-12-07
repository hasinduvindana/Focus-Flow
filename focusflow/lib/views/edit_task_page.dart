import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../viewmodels/task_viewmodel.dart';

class EditTaskPage extends StatelessWidget {
  final Task task;

  EditTaskPage({required this.task});

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = task.name;
    _descriptionController.text = task.description;

    return AlertDialog(
      backgroundColor: Colors.blueGrey[800],
      title: Text('Edit Task', style: TextStyle(color: Colors.white)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Task Name'),
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Task Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Provider.of<TaskViewModel>(context, listen: false).deleteTask(task.id!);
            Navigator.of(context).pop();
          },
          child: Text('Delete', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            final updatedTask = Task(
              id: task.id,
              name: _nameController.text,
              description: _descriptionController.text,
              date: task.date,
              time: task.time,
              location: task.location,
            );
            Provider.of<TaskViewModel>(context, listen: false).updateTask(updatedTask);
            Navigator.of(context).pop();
          },
          child: Text('Update', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
