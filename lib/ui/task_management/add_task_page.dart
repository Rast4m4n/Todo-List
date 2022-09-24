import 'package:flutter/material.dart';
import 'package:todo_list/data/repository/shared_preferences_repository.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/domain/states/theme_switcher_notifier.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final titleController = TextEditingController();
  final descriptionContorller = TextEditingController();

  bool isCanPressed = false;
  Color colorButton = Colors.grey;
  Future<void> addTaskToList() async {
    final task = TaskRepository.instance.createTask(
      title: titleController.text,
      description: descriptionContorller.text,
    );
    await SharedPreferencesRepository.instance.saveTask(task);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void isEditing() {
    if (titleController.text.isEmpty || descriptionContorller.text.isEmpty) {
      isCanPressed = false;
      colorButton = Colors.grey;
    } else {
      isCanPressed = true;
      colorButton = Colors.blueGrey;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавление задачи')),
      floatingActionButton: FloatingActionButton(
        onPressed: isCanPressed ? addTaskToList : null,
        backgroundColor: isCanPressed ? Colors.blueGrey : Colors.grey,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => isEditing(),
              autofocus: true,
              controller: titleController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Название задачи',
                floatingLabelStyle: TextStyle(
                  color: ThemeSwitcherNotifier.isDark
                      ? Colors.white
                      : Colors.blueGrey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ThemeSwitcherNotifier.isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => isEditing(),
              controller: descriptionContorller,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Описание задачи',
                hintStyle: TextStyle(
                  color: ThemeSwitcherNotifier.isDark
                      ? Colors.grey
                      : Colors.blueGrey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
