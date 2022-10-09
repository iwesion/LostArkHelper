/*
 * @Author: wesion
 * @Date: 2022-09-30 14:47:59
 * @LastEditTime: 2022-10-08 18:03:59
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class DropDownDialog extends StatefulWidget {
  List<int> list;
  int? i;
  double? width;
  void Function(int)? onPressed;
  DropDownDialog(
      {Key? key, required this.list, this.onPressed, this.i, this.width})
      : super(key: key);

  @override
  State<DropDownDialog> createState() => _DropDownDialogState();
}

class _DropDownDialogState extends State<DropDownDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (widget.onPressed != null) {
                widget.onPressed!(index);
              }
              SmartDialog.dismiss();
            },
            child: Container(
              height: 30,
              width: 80,
              color: widget.list[index] == widget.i
                  ? Colors.grey[300]
                  : Colors.white,
              child: Center(child: Text(widget.list[index].toString())),
            ),
          );
        },
        itemCount: widget.list.length,
      ),
    );
  }
}
