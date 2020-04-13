import 'dart:io';

import 'package:flutter/material.dart';
import '../win_check/win_data.dart';

import '../models/tic_buttons.dart';
import '../constants/constants.dart';
import '../win_check/check_win.dart';
import '../win_check/paint_line.dart';
import '../screens/game_screen.dart';

class GameScreenWithoutAi extends StatefulWidget {
  static const pageId = 'GameScreen-without_ai';
  @override
  _GameScreenWithoutAiState createState() => _GameScreenWithoutAiState();
}

class _GameScreenWithoutAiState extends State<GameScreenWithoutAi> {
  WinData win;

  int count = 0;
  MediaQueryData _media;
  bool _isPlayer;
  bool _winOrDraw = false;
  List<TicButtons> _ticButtons;
  bool _showDialog = false;
  @override
  void initState() {
    super.initState();
    _isPlayer = true;
    _ticButtons = [];
    for (int i = 0; i < 9; i++) {
      _ticButtons.add(TicButtons(
        index: i,
        icon: Container(),
        isWidgetSet: false,
        winVal: kNotSet,
      ));
    }
  }

  bool _breakPoint() {
    int countt = 0;
    for (int o = 0; o < 9; o++) {
      if (_ticButtons[o].isWidgetSet) {
        countt++;
      }
    }
    if (countt >= 9) {
//      print('widgets are being set somehow');
      return true;
    } else {
      return false;
    }
  }

  Widget _buildButtonChoicesRow() {
    return Positioned(
      bottom: _media.size.height * 0.04,
      left: _media.size.width * 0.25,
      child: Center(
        child: Row(
          children: <Widget>[
            RaisedButton(
              color: Colors.blueGrey,
              onPressed: () {
                setState(() {
                  _showDialog = true;
                });
              },
              child: Text('Reset Game'),
            ),
            SizedBox(
              width: 20.0,
            ),
            RaisedButton(
              color: Colors.blueGrey,
              onPressed: () {
                setState(() {
                  exit(0);
                });
              },
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    win = WinCheck.winCheck(_ticButtons);
    if (_breakPoint() || win != null) {
      return;
    }

    if (_ticButtons[index].isWidgetSet) {
//      print('there is a container ${index.toString()}');
      return;
    } else if (!_ticButtons[index].isWidgetSet) {
      if (_isPlayer) {
        setState(() {
          _ticButtons[index].icon = Icon(
            Icons.panorama_fish_eye,
            color: Colors.green,
            size: 80.0,
          );
          _ticButtons[index].winVal = kIsPlayer;

          _ticButtons[index].isWidgetSet = true;

          WinCheck.winCheck(_ticButtons);
          _isPlayer = !_isPlayer;
        });
      } else if (!_isPlayer) {
        setState(() {
          _ticButtons[index].icon = Icon(
            Icons.clear,
            color: Colors.lightBlueAccent,
            size: 80.0,
          );
          _ticButtons[index].winVal = kIsOpponent;
          _ticButtons[index].isWidgetSet = true;

          WinCheck.winCheck(_ticButtons);

          _isPlayer = !_isPlayer;
        });
      }
    }
    win = WinCheck.winCheck(_ticButtons);
    if (_breakPoint() || win != null) {
      setState(() {
        _winOrDraw = true;
//        _showDialog = true;
      });

//      print('a win or breakpoint occured');
      return;
    }
  }

  Widget _buildGridTiles(int index) {
    return GridTile(
        child: GestureDetector(
      onTap: () => _onTap(index),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: Colors.white24)),
        child: _ticButtons[index].icon,
      ),
    ));
  }

  Widget _whoMovesNext() {
    String string = '';

    if (win != null) {
      if (win.row == -1) {
        string = 'Draw';
      } else {
        string = _isPlayer ? 'Player "X" won' : 'Player "O" won';
      }
    } else {
      string = _isPlayer ? 'It\'s your turn' : 'It\'s your opponents turn';
    }
    Widget message = Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        string,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
      ),
    );
    return message;
  }

  Widget _buildWinCross() => AspectRatio(
      aspectRatio: 1.0, child: CustomPaint(painter: PaintLine(win)));

  @override
  Widget build(BuildContext context) {
    _media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      backgroundColor: Colors.black,
      body: _showDialog
          ? AlertDialog(
//              title: Text('Reset'),
              content: Text('Replay with AI or Friend?'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, GameScreen.pageId),
                    child: Text('AI')),
                FlatButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, GameScreenWithoutAi.pageId),
                    child: Text('Friend')),
              ],
            )
          : SafeArea(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _whoMovesNext(),
                      Expanded(
                        child: Center(
                          child: Container(
//                      padding: EdgeInsets.all(60.0),
                            height: _media.size.height * 0.70,
                            child: GridView.count(
                              crossAxisCount: 3,
                              children:
                                  List<Widget>.generate(9, _buildGridTiles),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_winOrDraw) _buildWinCross(),
                  if (_winOrDraw) _buildButtonChoicesRow(),
                ],
              ),
            ),
    );
  }

  int getIndexPos(int numb) {
    int num = numb;

    int binaryValue = 0;

    int i = 1;

    while (num > 0) {
      binaryValue = binaryValue + (num % 3) * i;

      num = (num / 3).floor();

      i = i * 10;
    }
    return binaryValue;
  }
}
