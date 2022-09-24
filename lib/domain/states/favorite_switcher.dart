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

  bool isFavorite = false;

  void pressedFavorite(String title, String description, int id) async {
    if (!isFavorite) {
      isFavorite = true;
      await SharedPreferencesRepository.instance
          .saveButtonStateFavorite(isFavorite);
      final task = TaskRepository.instance.addToFavoriteTask(
        Task(
          title: title,
          description: description,
          id: id,
        ),
      );
      await SharedPreferencesRepository.instance.saveFavoriteTask(task);
    } else {
      isFavorite = false;
      await SharedPreferencesRepository.instance
          .saveButtonStateFavorite(isFavorite);
      await SharedPreferencesRepository.instance.deleteFavoriteTask(id);
      TaskRepository.instance.deleteFavoriteTask(id);
    }
  }
}
