

import 'package:flutter/material.dart';

class MatrixBox extends StatefulWidget {
  const MatrixBox({super.key});

  @override
  _MatrixBoxState createState() => _MatrixBoxState();
}

class _MatrixBoxState extends State<MatrixBox> {
  List<List<bool>> _boxes = List.generate(4, (_) => List.filled(4, false));
  List<int> _lastClickedBoxes = [];

  void _toggleBoxColor(int row, int col) {
    setState(() {
      _boxes[row][col] = !_boxes[row][col];

      if (_boxes[row][col]) {
        _lastClickedBoxes.add(row * 4 + col);
        if (_lastClickedBoxes.length > 2) {
          int lastBox = _lastClickedBoxes.removeAt(0);
          int lastRow = lastBox ~/ 4;
          int lastCol = lastBox % 4;
          _boxes[lastRow][lastCol] = false;
        }
      }
    });
  }

  String _getBoxLabel(int row, int col) {
    return 'Box #${row * 4 + col + 1}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrix Box'),
      ),
      body: Center(
        child: Table(
          children: List.generate(
            4,
            (row) => TableRow(
              children: List.generate(
                4,
                (col) => GestureDetector(
                  onTap: () {
                    _toggleBoxColor(row, col);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: _boxes[row][col] ? Colors.red : Colors.blue,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(_boxes[row][col] ? _getBoxLabel(row, col) : ''),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


