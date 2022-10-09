/*
 * @Author: wesion
 * @Date: 2022-10-08 18:46:32
 * @LastEditTime: 2022-10-09 11:06:00
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lost_ark/common/my_color.dart';

import '../provider/engraved_provider/model/engraved_model.dart';

class MyGridDialog extends StatefulWidget {
  List list;
  void Function(int index)? onTap;
  TargetModel? model;
  MyGridDialog({Key? key, required this.list, this.onTap, this.model})
      : super(key: key);

  @override
  State<MyGridDialog> createState() => _MyGridDialogState();
}

class _MyGridDialogState extends State<MyGridDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //横轴三个子widget
            childAspectRatio: 2, //宽高比为1时，子widget
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
          ),
          children: widget.list
              .asMap()
              .entries
              .map((e) => GestureDetector(
                    onTap: () {
                      SmartDialog.dismiss();
                      if (widget.onTap != null) {
                        widget.onTap!(e.key);
                      }
                    },
                    child: Container(
                      color: widget.model?.engrave == e.value
                          ? widget.model?.color
                          : Colors.white,
                      child: Center(child: Text(e.value)),
                    ),
                  ))
              .toList(),
        ));
  }
}
