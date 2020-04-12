import './win_data.dart';
import '../constants/constants.dart';
import '../models/tic_buttons.dart';

class WinCheck {
  static WinData winCheck(List<TicButtons> ticButtons) {
    WinData winner;
    int _temp(int i) {
      return ticButtons[i].winVal;
    }

    bool pass1 = checkWinVal(
      _temp(0),
      _temp(1),
      _temp(2),
    );
    bool pass2 = checkWinVal(
      _temp(3),
      _temp(4),
      _temp(5),
    );
    bool pass3 = checkWinVal(
      _temp(6),
      _temp(7),
      _temp(8),
    );
    bool pass4 = checkWinVal(
      _temp(0),
      _temp(3),
      _temp(6),
    );
    bool pass5 = checkWinVal(
      _temp(1),
      _temp(4),
      _temp(7),
    );
    bool pass6 = checkWinVal(
      _temp(2),
      _temp(5),
      _temp(8),
    );
    bool pass7 = checkWinVal(
      _temp(0),
      _temp(4),
      _temp(8),
    );
    bool pass8 = checkWinVal(
      _temp(2),
      _temp(4),
      _temp(6),
    );
    if (pass1) {
      winner = WinData(
          0, 0, kHorizontal, ticButtons[0].winVal == kIsPlayer ? true : false);
    } else if (pass2) {
      winner = WinData(
          1, 0, kHorizontal, ticButtons[3].winVal == kIsPlayer ? true : false);
    } else if (pass3) {
      winner = WinData(
          2, 0, kHorizontal, ticButtons[3].winVal == kIsPlayer ? true : false);
    } else if (pass4) {
      winner = WinData(
          0, 0, kVertical, ticButtons[6].winVal == kIsPlayer ? true : false);
    } else if (pass5) {
      winner = WinData(
          0, 1, kVertical, ticButtons[1].winVal == kIsPlayer ? true : false);
    } else if (pass6) {
      winner = WinData(
          0, 2, kVertical, ticButtons[2].winVal == kIsPlayer ? true : false);
    } else if (pass7) {
      winner =
          WinData(0, 0, 3, ticButtons[0].winVal == kIsPlayer ? true : false);
    } else if (pass8) {
      winner =
          WinData(2, 0, 2, ticButtons[6].winVal == kIsPlayer ? true : false);
    } else if (ticButtons[0].isWidgetSet == true &&
        ticButtons[1].isWidgetSet == true &&
        ticButtons[2].isWidgetSet == true &&
        ticButtons[3].isWidgetSet == true &&
        ticButtons[4].isWidgetSet == true &&
        ticButtons[5].isWidgetSet == true &&
        ticButtons[6].isWidgetSet == true &&
        ticButtons[7].isWidgetSet == true &&
        ticButtons[8].isWidgetSet == true) {
      winner = WinData(-1, -1, -1, null);
//      print('random loop');
    }
    return winner;
  }

  static bool checkWinVal(int first, int second, int third) {
    if ((first == 1 && first == second && third == first) ||
        (first == 2 && first == second && third == first)) {
//      print('a win just occured');
      return true;
    } else {
      return false;
    }
  }
}
