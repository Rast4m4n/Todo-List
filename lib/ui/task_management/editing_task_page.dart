import 'package:flutter/material.dart';
import 'package:todo_list/data/repository/shared_preferences_repository.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/navigation/app_navigation.dart';

class EditingTaskPage extends StatefulWidget {
  const EditingTaskPage({Key? key, required this.task}) : super(key: key);

  final Task task;
  @override
  State<EditingTaskPage> createState() => _EditingTaskPageState();
}

class _EditingTaskPageState extends State<EditingTaskPage> {
  late final _titleController = TextEditingController(text: widget.task.title);
  late final _descriptionController =
      TextEditingController(text: widget.task.description);

  Color colorButton = Colors.grey;

  bool isCanPressed = false;

  Future<void> editTask() async {
    final task = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        id: widget.task.id);
    TaskRepository.instance.editTask(task);
    await SharedPreferencesRepository.instance.editTasks(task).then((value) =>
        Navigator.of(context).popAndPushNamed(NavigationRouteNames.taskRoute));
  }

  void isEditing() {
    if (_titleController.text != widget.task.title ||
        _descriptionController.text != widget.task.description) {
      colorButton = Colors.blueGrey;
      isCanPressed = true;
    } else {
      isCanPressed = false;
      colorButton = Colors.grey;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Изменение  задачи')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorButton,
        onPressed: isCanPressed ? editTask : null,
        child: const Icon(
          Icons.save,
        ),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => isEditing(),
            autofocus: true,
            controller: _titleController,
            maxLines: 1,
            decoration: const InputDecoration(
              labelText: 'Название задачи',
            ),
          ),
          TextField(
            onChanged: (value) => isEditing(),
            controller: _descriptionController,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: 'Написать программу',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
