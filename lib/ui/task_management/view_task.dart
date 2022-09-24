import 'package:flutter/material.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/navigation/app_navigation.dart';

class ViewTaskPage extends StatelessWidget {
  const ViewTaskPage({Key? key, required this.task}) : super(key: key);
  final Task task;

  void enterEditingTask(BuildContext context) {
    Navigator.of(context).pushNamed(
      NavigationRouteNames.editingTaskRoute,
      arguments: task,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Просмотр задачи'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => enterEditingTask(context),
        child: const Icon(
          Icons.edit,
        ),
      ),
      body: ViewTaskWidget(task: task),
    );
  }
}

class ViewTaskWidget extends StatelessWidget {
  const ViewTaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              task.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              task.description,
              style:
                  Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
