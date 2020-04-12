import 'package:flutter/material.dart';
import 'package:fluttertictactoe/screens/game_screen_without_ai.dart';
import './screens/game_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget _showDialog() {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Tic Tac Toe'),
          ),
          body: AlertDialog(
            title: Text('Choose Game Mode...'),
            content: Text('Play with AI or play with friend?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, GameScreen.pageId),
                  child: Text('AI')),
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, GameScreenWithoutAi.pageId);
                  },
                  child: Text('Friend')),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: _showDialog(),
      theme: ThemeData.dark(),
      routes: {
        GameScreenWithoutAi.pageId: (context) => GameScreenWithoutAi(),
        GameScreen.pageId: (context) => GameScreen(),
      },
    );
  }
}
