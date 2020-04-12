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
  bool _isPlayer;
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

  void _onTap(int index) {
    win = WinCheck.winCheck(_ticButtons);
    if (_breakPoint() || win != null) {
      setState(() {
        _showDialog = true;
      });

//      print('a win or breakpoint occured');
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
            size: 60.0,
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
            size: 60.0,
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
        _showDialog = true;
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
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(),
        child: _ticButtons[index].icon,
      ),
    ));
  }

  Container get buildVerticalLine => Container(
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 50.0,
      ),
      color: Colors.white24,
      width: 5.0);

  Container get buildHorizontalLine => Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 40.0,
      ),
      color: Colors.white24,
      height: 5.0);

  Widget buildGridView() => AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            buildHorizontalLine,
            buildHorizontalLine,
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            buildVerticalLine,
            buildVerticalLine,
          ])
        ],
      ));

  Widget _messageString() {
    Widget message;
    if (win.row == -1) {
      message = Text('Draw');
//      print(win.row.toString());

    } else {
      message = Text(win.playerWon ? 'Player "0" won' : 'Player "X" won ');
    }
    return message;
  }

  Widget buildWinCross() => AspectRatio(
      aspectRatio: 1.0, child: CustomPaint(painter: PaintLine(win)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      backgroundColor: Colors.black,
      body: _showDialog
          ? AlertDialog(
              title: _messageString(),
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
                      Expanded(
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.70,
                            child: buildGridView(),
                          ),
                        ),
                      )
                    ],
                  ),
                  buildWinCross(),
                  Column(
                    children: <Widget>[
//                Text(
//                  _isPlayer ? 'It\'s your turn' : 'It\'s your opponents turn',
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 24.0,
//                  ),
//                ),
                      Expanded(
                        child: Center(
                          child: Container(
//                      padding: EdgeInsets.all(60.0),
                            height: MediaQuery.of(context).size.height * 0.70,
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
