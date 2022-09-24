import 'package:flutter/material.dart';
import 'package:todo_list/data/repository/shared_preferences_repository.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/domain/models/task.dart';

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
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) async {
                    await SharedPreferencesRepository.instance
                        .deleteTask(tasks[index].id);
                    TaskRepository.instance.deleteTask(tasks[index].id);
                    setState(() {});
                  },
                  background: Container(color: Colors.red),
                  child: FavoriteTaskCard(task: tasks[index]),
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

class FavoriteTaskCard extends StatelessWidget {
  const FavoriteTaskCard({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: ListTile(
          onTap: () => {},
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          title: Text(task.title),
          subtitle: Text(
            task.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            splashRadius: 0.1,
          ),
        ),
      ),
    );
  }
}
