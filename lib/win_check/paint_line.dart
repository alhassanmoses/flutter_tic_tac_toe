import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './win_data.dart';

class PaintLine extends CustomPainter {
  Paint _paint;
  WinData _winData;

  @override
  bool hitTest(Offset position) {
    return false;
  }

  PaintLine(WinData win) {
    this._winData = win;
    _paint = Paint();
    _paint.color = Colors.green;
    _paint.strokeWidth = 20.0;
    _paint.strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print('paint');
    if (_winData != null) {
      if (_winData.paintLine == 0) {
        _drawHorizontalLine(_winData.row, size, canvas);
      } else if (_winData.paintLine == 1) {
        _drawVerticalLine(_winData.col, size, canvas);
      } else if (_winData.paintLine == 2) {
        _drawDiagonalLine(true, size, canvas);
      } else if (_winData.paintLine == 3)
        _drawDiagonalLine(false, size, canvas);
    }
  }

  void _drawVerticalLine(int column, Size size, Canvas canvas) {
    if (column == 0) {
      var x = size.width / 3 / 2;
      var top = Offset(x, 130.0);
      var bottom = Offset(x, size.height + 60.0);
      canvas.drawLine(top, bottom, _paint);
    } else if (column == 1) {
      var x = size.width / 2;
      var top = Offset(x, 130.0);
      var bottom = Offset(x, size.height + 60.0);
      canvas.drawLine(top, bottom, _paint);
    } else {
      var columnWidth = size.width / 3;
      var x = columnWidth * 2 + columnWidth / 2;
      var top = Offset(x, 130.0);
      var bottom = Offset(x, size.height + 60.0);
      canvas.drawLine(top, bottom, _paint);
    }
  }

  void _drawHorizontalLine(int row, Size size, Canvas canvas) {
    if (row == 0) {
      var y = size.height / 3 / 0.83;
      var left = Offset(30.0, y);
      var right = Offset(size.width - 30.0, y);
      canvas.drawLine(left, right, _paint);
    } else if (row == 1) {
      var y = size.height / 1.36;
      var left = Offset(30.0, y);
      var right = Offset(size.width - 30.0, y);
      canvas.drawLine(left, right, _paint);
    } else {
      var columnHeight = size.height / 2.34;
      var y = columnHeight * 2 + columnHeight / 2;
      var left = Offset(30.0, y);
      var right = Offset(size.width - 30.0, y);
      canvas.drawLine(left, right, _paint);
    }
  }

  void _drawDiagonalLine(bool isAscending, Size size, Canvas canvas) {
    if (isAscending) {
      var bottomLeft = Offset(35.0, size.height + 60.0);
      var topRight = Offset(size.width - 30.0, 130.0);
      canvas.drawLine(bottomLeft, topRight, _paint);
    } else {
      var topLeft = Offset(40.0, 140.0);
      var bottomRight = Offset(size.width - 40.0, size.height + 50.0);
      canvas.drawLine(topLeft, bottomRight, _paint);
    }
  }

  @override
  bool shouldRepaint(PaintLine oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PaintLine oldDelegate) => false;
}
