import 'package:flutter/material.dart';
import 'package:todo_list/domain/states/theme_switcher_notifier.dart';
import 'package:todo_list/navigation/app_navigation.dart';
import 'package:todo_list/ui/home/task_list_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.navigator}) : super(key: key);
  final AppNavigator navigator;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    ThemeSwitcherNotifier.instance.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      theme: ThemeSwitcherNotifier.instance.currentTheme(),
      routes: widget.navigator.routes,
      initialRoute: widget.navigator.initialRoute,
      onGenerateRoute: widget.navigator.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
    );
  }
}
