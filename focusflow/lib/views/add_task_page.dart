import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../viewmodels/task_viewmodel.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _location;

  void _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) setState(() => _selectedDate = pickedDate);
  }

  void _selectTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) setState(() => _selectedTime = pickedTime);
  }

  void _submitTask() {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedTime != null &&
        _location != null) {
      final newTask = Task(
        name: _nameController.text,
        description: _descriptionController.text,
        date: DateFormat.yMd().format(_selectedDate!),
        time: _selectedTime!.format(context),
        location: _location!,
      );
      Provider.of<TaskViewModel>(context, listen: false).addTask(newTask);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey[800],
      title: Text('Add New Task', style: TextStyle(color: Colors.white)),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
              validator: (value) => value!.isEmpty ? 'Please enter a task name' : null,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
              validator: (value) => value!.isEmpty ? 'Please enter a task description' : null,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null ? 'Select Date' : DateFormat.yMd().format(_selectedDate!),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  onPressed: _selectDate,
                  icon: Icon(Icons.calendar_today, color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedTime == null ? 'Select Time' : _selectedTime!.format(context),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  onPressed: _selectTime,
                  icon: Icon(Icons.access_time, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: _submitTask,
          child: Text('OK', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
