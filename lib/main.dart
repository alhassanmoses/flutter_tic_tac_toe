import 'package:flutter/material.dart';
import './screens/game_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: GameScreen(),
    );
  }
}
