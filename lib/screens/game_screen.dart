import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int count = 0;
  int _currentIcon;
  List<TicButtons> _ticButtons;
  @override
  void initState() {
    _currentIcon = 0;
    _ticButtons = [];
    for (int i = 0; i < 9; i++) {
      _ticButtons.add(TicButtons(
        index: i,
        icon: Container(),
        isWidgetSet: false,
        winVal: 0,
      ));
    }
    super.initState();
  }

  bool _checkWinVal(int first, int second, int third) {
    if (first + second + third == 3 || first + second + third == 6) {
      return true;
    } else {
      return false;
    }
  }

  bool _winCheck() {
    int _temp(int i) {
      return _ticButtons[i].winVal;
    }

    bool pass1 = _checkWinVal(
      _temp(0),
      _temp(1),
      _temp(2),
    );
    bool pass2 = _checkWinVal(
      _temp(3),
      _temp(4),
      _temp(5),
    );
    bool pass3 = _checkWinVal(
      _temp(6),
      _temp(7),
      _temp(8),
    );
    bool pass4 = _checkWinVal(
      _temp(0),
      _temp(3),
      _temp(5),
    );
    bool pass5 = _checkWinVal(
      _temp(1),
      _temp(4),
      _temp(7),
    );
    bool pass6 = _checkWinVal(
      _temp(2),
      _temp(5),
      _temp(8),
    );
    bool pass7 = _checkWinVal(
      _temp(0),
      _temp(4),
      _temp(8),
    );
    bool pass8 = _checkWinVal(
      _temp(2),
      _temp(4),
      _temp(6),
    );
    bool pass9 = _checkWinVal(
      _temp(0),
      _temp(1),
      _temp(2),
    );
    if (pass1 ||
        pass2 ||
        pass3 ||
        pass4 ||
        pass5 ||
        pass6 ||
        pass7 ||
        pass8 ||
        pass9) {
      return true;
    } else {
      return false;
    }
  }

  void _onTap(int index) {
    if (_ticButtons[index].isWidgetSet) {
      print('there is a container ${index.toString()}');
      return;
    } else if (!_ticButtons[index].isWidgetSet) {
//      print('There is no container ${index.toString()}');
      if (_currentIcon == 1) {
        setState(() {
          _ticButtons[index].icon = Icon(
            Icons.panorama_fish_eye,
            color: Colors.green,
            size: 60.0,
          );
          _ticButtons[index].winVal = 1;

          _ticButtons[index].isWidgetSet = true;
          _currentIcon = 0;
          _winCheck();
        });
      } else if (_currentIcon == 0) {
        setState(() {
          _ticButtons[index].icon = Icon(
            Icons.clear,
            color: Colors.lightBlueAccent,
            size: 60.0,
          );
          _ticButtons[index].winVal = 2;
          _ticButtons[index].isWidgetSet = true;
          _currentIcon = 1;
        });
      }
    }
  }

  Widget _buildGridTiles(int index) {
    return GridTile(
        child: GestureDetector(
      onTap: () => _onTap(index),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
        ),
        child: _ticButtons[index].icon,
//        child: Container(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'Let the games begin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List<Widget>.generate(9, _buildGridTiles),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicButtons {
  final int index;
  Widget icon;
  bool isWidgetSet;
  int winVal;
  TicButtons({this.index: -1, this.icon, this.isWidgetSet, this.winVal});
}
