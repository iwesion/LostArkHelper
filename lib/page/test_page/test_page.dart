/*
 * @Author: wesion
 * @Date: 2022-10-08 16:50:57
 * @LastEditTime: 2022-10-08 17:22:07
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:lost_ark/common/my_color.dart';
import 'package:reorderables/reorderables.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<ReorderableTableRow> _itemRows = [];
  var data = [
    ['Alex', 'D', 'B+', 'AA', ''],
    ['Bob', 'AAAAA+', '', 'B', ''],
    ['Cindy', '', 'To Be Confirmed', '', ''],
    ['Duke', 'C-', '', 'Failed', ''],
    ['Ellenina', 'C', 'B', 'A', 'A'],
    ['Floral', '', 'BBB', 'A', 'A'],
  ];
  @override
  void initState() {
    super.initState();

    Widget _textWithPadding(String text) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Text(text, textScaleFactor: 1.1),
      );
    }

    _itemRows = data.map((row) {
      return ReorderableTableRow(
        //a key must be specified for each row
        key: ObjectKey(row),
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _textWithPadding('${row[0]}'),
          _textWithPadding('${row[1]}'),
          _textWithPadding('${row[2]}'),
          _textWithPadding('${row[3]}'),
//          Text('${row[4]}'),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var headerRow = ReorderableTableRow(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Name', textScaleFactor: 1.5),
          Text('Math', textScaleFactor: 1.5),
          Text('Science', textScaleFactor: 1.5),
          Text('Physics', textScaleFactor: 1.5),
          Text('Sports', textScaleFactor: 1.5)
        ]);

    void _onReorder(int oldIndex, int newIndex) {
      // setState(() {
      //   ReorderableTableRow row = _itemRows.removeAt(oldIndex);
      //   _itemRows.insert(newIndex, row);
      // });
    }

    return ReorderableTable(
      header: headerRow,
      children: _itemRows,
      onReorder: _onReorder,
    );
  }
}
