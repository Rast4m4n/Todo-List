import 'package:todo_list/data/repository/shared_preferences_repository.dart';
import 'package:todo_list/data/repository/task_repository.dart';
import 'package:todo_list/domain/models/task.dart';

class FavoriteSwitcher {
  static FavoriteSwitcher? _singleton;
  static FavoriteSwitcher get instance => _singleton!;
  FavoriteSwitcher._internal();

  factory FavoriteSwitcher() {
    _singleton ??= FavoriteSwitcher._internal();
    return instance;
  }

  void _favoriteEdit(Task task, bool isFavorite) async {
    final newTask = task.copyWith(isFavorite: isFavorite);
    TaskRepository.instance.editTask(newTask);
    await SharedPreferencesRepository.instance.editTask(newTask);
  }

  void addFavorite(Task task) async {
    _favoriteEdit(task, true);
  }

  void deleteFavorite(Task task) async {
    _favoriteEdit(task, false);
  }
}
