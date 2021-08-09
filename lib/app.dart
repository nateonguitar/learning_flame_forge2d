import 'package:flutter/material.dart';
import 'package:learning_flame_forge2d/test_physics.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Izzy Pets',
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
        primarySwatch: Colors.lime,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
        primarySwatch: Colors.lime,
      ),
      themeMode: ThemeMode.dark,
      home: TestPhysicsPage(),
    );
  }
}
