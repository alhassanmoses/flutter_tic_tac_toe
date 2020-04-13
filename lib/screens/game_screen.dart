import 'dart:io';

import 'package:flutter/material.dart';
import '../win_check/win_data.dart';

import '../ai/ai.dart';
import '../models/tic_buttons.dart';
import '../constants/constants.dart';
import '../win_check/check_win.dart';
import '../win_check/paint_line.dart';
import 'game_screen_without_ai.dart';
//import '../ai/./decision.dart';

//enum WhoIsPlaying {
//  player,
//  opponent,
//  noPlayer,
//}

class GameScreen extends StatefulWidget {
  static const pageId = 'GameScreen-with_ai';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<String>> _tempField = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
//  int co = 0;

  AI ai;
  MediaQueryData _media;
  int _aiMoveIndex;
  WinData win;
  bool _winOrDraw = false;
  bool _showDialog = false;
  String _tempString = '';
  int count = 0;
  bool _isPlayer;
  List<TicButtons> _ticButtons;
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

  void _aiMove() {
    int a = 0;
    int i = 0;
    int y = 0;

    for (a = 0; a < 3; a++) {
      for (i = 0; i < 3; i++) {
        if (_ticButtons[y].winVal == kNotSet) {
          _tempString = '';
        } else if (_ticButtons[y].winVal == kIsPlayer) {
          _tempString = 'o';
        } else if (_ticButtons[y].winVal == kIsOpponent) {
          _tempString = 'x';
        }
        _tempField[a][i] = _tempString;
        y++;
      }
    }

    var aiMove = ai.getDecision();
    String f = aiMove.row.toString();
    String s = aiMove.column.toString();
    _aiMoveIndex = int.parse('$f$s', radix: 3);
//    print('ai move index is: $_aiMoveIndex');

//      print('ai move is $number');

//    for (int k = 0; k < 3; k++) {
//      for (int t = 0; t < 3; t++) {
//        print(_tempField[k][t]);
//      }
//    }
  }

//  void _displayAiMove() {
//    _aiMove();
//  }

  void _onTap(int index) {
//    print('count is $co');
    win = WinCheck.winCheck(_ticButtons);
    if (_breakPoint() || win != null) {
      return;
    }

//    if (_breakPoint()) {
//      print('${_tempField[0][0]} ${_tempField[0][1]} ${_tempField[0][2]}');
//      print('${_tempField[1][0]} ${_tempField[1][1]} ${_tempField[1][2]}');
//      print('${_tempField[2][0]} ${_tempField[2][1]} ${_tempField[2][2]}');
//      print('the value is ${_tempField[0][0]}');
//
//      return;
//    }

    _aiMove();
    if (_ticButtons[index].isWidgetSet ||
        _ticButtons[_aiMoveIndex].isWidgetSet) {
//      print('there is a container ${index.toString()}');
      return;
    } else if (!_ticButtons[index].isWidgetSet &&
        !_ticButtons[_aiMoveIndex].isWidgetSet) {
//      print('There is no container ${index.toString()}');
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
      }
      if (!_isPlayer) {
        _aiMove();
//        _makeAiMove();
        setState(() {
          _ticButtons[_aiMoveIndex].icon = Icon(
            Icons.clear,
            color: Colors.lightBlueAccent,
            size: 80.0,
          );
          _ticButtons[_aiMoveIndex].winVal = kIsOpponent;
          _ticButtons[_aiMoveIndex].isWidgetSet = true;

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
//      print(
//          'the row is: ${win.row.toString()} the col is: ${win.col.toString()} ');
      print('a win or breakpoint occured');
      return;
    }

//    co++;
  }

//  void _makeAiMove() {
//    print(_aiMoveIndex);
//    setState(() {
//      _ticButtons[_aiMoveIndex].icon = Icon(
//        Icons.clear,
//        color: Colors.lightBlueAccent,
//        size: 60.0,
//      );
//      _ticButtons[_aiMoveIndex].winVal = kIsOpponent;
//      _ticButtons[_aiMoveIndex].isWidgetSet = true;
//      _isPlayer = !_isPlayer;
//    });
//  }

  Widget _buildGridTiles(int index) {
    return GridTile(
        child: GestureDetector(
      onTap: () => _onTap(index),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: Colors.white24)),
        child: _ticButtons[index].icon,
//        child: Container(),
      ),
    ));
  }

  Widget _whoMovesNext() {
    String string = '';

    if (win != null) {
      if (win.row == -1) {
        string = 'Draw';
      } else {
        string = win.playerWon ? 'Player "O" won' : 'Player "X" won';
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
          fontSize: 30.0,
        ),
      ),
    );
    return message;
  }

  Widget buildWinCross() => AspectRatio(
        aspectRatio: 1.0,
        child: CustomPaint(
          painter: PaintLine(win),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _media = MediaQuery.of(context);
    ai = AI(_tempField, '0', 'x');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Tic Tac Toe'),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _showDialog
            ? AlertDialog(
//                title: Text('Reset'),
                content: Text('Re-play with AI or Friend?'),
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
            : Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _whoMovesNext(),
                      Expanded(
                        child: Center(
                          child: Container(
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
                  if (_winOrDraw) buildWinCross(),
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
