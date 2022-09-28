import 'package:flutter/material.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/domain/enums/priority_enum.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/domain/states/theme_switcher_notifier.dart';
import 'package:todo_list/ui/home/favoriteTasks/favorite_tasks_page.dart';
import 'package:todo_list/ui/home/taskList/view_model.dart';

final routeObserver = RouteObserver<ModalRoute<void>>();

class TasksListPage extends StatefulWidget {
  const TasksListPage({Key? key}) : super(key: key);

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  late final model = ViewModel(context);
  int _selectedTab = 0;
  void _currentPage(int index) {
    if (_selectedTab == index) return;
    _selectedTab = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelInh(
      model: model,
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text(_selectedTab == 0 ? 'Список задач' : 'Избранные задачи'),
            actions: [
              IconButton(
                  tooltip: ThemeSwitcherNotifier.isDark ? 'Тёмный режим' : 'Светлый режим',
                  onPressed: ThemeSwitcherNotifier.instance.switchTheme,
                  icon: ThemeSwitcherNotifier.isDark
                      ? const Icon(Icons.dark_mode_outlined)
                      : const Icon(Icons.light_mode),
                  splashRadius: 20,
                  highlightColor:
                      ThemeSwitcherNotifier.isDark ? const Color.fromARGB(255, 57, 57, 57) : Colors.blueGrey),
              const SizedBox(width: 8),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => ViewModelInh.of(context)?.model.enterAddTaskPage(),
            child: const Icon(Icons.add),
          ),
          body: IndexedStack(
            index: _selectedTab,
            children: const [
              TasksPage(),
              FavoriteTasksPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Задачи',
                tooltip: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Избранные',
                tooltip: '',
              ),
            ],
            selectedIconTheme: const IconThemeData(size: 26),
            unselectedIconTheme: const IconThemeData(size: 20),
            selectedFontSize: 16,
            onTap: _currentPage,
          ),
        );
      }),
    );
  }
}

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: TaskRepository.instance.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final tasks = snapshot.data!;
          return ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) async {
                  ViewModelInh.of(context)?.model.deleteTask(tasks[index].id, index);
                  setState(() {});
                },
                background: Container(color: Colors.red),
                child: TaskCard(
                  task: tasks[index],
                  updateList: () => setState(() {}),
                ),
              );
            },
            itemCount: tasks.length,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({
    Key? key,
    required this.task,
    required this.updateList,
  }) : super(key: key);
  final Task task;
  final VoidCallback updateList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  ViewModel? vm;
  @override
  void didChangeDependencies() {
    vm = ViewModelInh.of(context)?.model;
    super.didChangeDependencies();
  }

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
          onTap: () => vm?.enterViewTask(widget.task),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          title: Text(widget.task.title),
          subtitle: Text(
            widget.task.description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  vm?.onFavoritePressed(widget.task);
                  widget.updateList();
                },
                icon: Icon(
                  widget.task.isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: widget.task.isFavorite ? Colors.red : null,
                ),
              ),
              PopupMenuButton(
                tooltip: 'Приоритетность',
                icon: Icon(Icons.flag, color: widget.task.priority.getColor()),
                itemBuilder: (BuildContext context) {
                  return PriorityEnum.values
                      .map(
                        (e) => PopupMenuItem(
                          onTap: () {
                            vm?.selectPriority(widget.task, e);
                            widget.updateList();
                          },
                          child: ListTile(
                            title: Text(e.getName()),
                            trailing: Icon(Icons.flag, color: e.getColor()),
                          ),
                        ),
                      )
                      .toList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
