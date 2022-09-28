import 'package:flutter/material.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/ui/home/taskList/task_list_page.dart';

class FavoriteTasksPage extends StatefulWidget {
  const FavoriteTasksPage({Key? key}) : super(key: key);

  @override
  State<FavoriteTasksPage> createState() => _FavoriteTasksPageState();
}

class _FavoriteTasksPageState extends State<FavoriteTasksPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 10,
      color: Colors.white,
      backgroundColor: Colors.blueGrey,
      onRefresh: () {
        return Future<void>.delayed(const Duration(seconds: 1))
            .then((value) => setState(() {}));
      },
      child: FutureBuilder<List<Task>>(
        future: TaskRepository.instance.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks =
                snapshot.data!.where((element) => element.isFavorite).toList();
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return TaskCard(
                  task: tasks[index],
                  updateList: () => setState(() {}),
                );
              },
              itemCount: tasks.length,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
