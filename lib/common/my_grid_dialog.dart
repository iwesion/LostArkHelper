/*
 * @Author: wesion
 * @Date: 2022-10-08 18:46:32
 * @LastEditTime: 2022-10-10 16:36:13
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
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
          width: 300,
          height: 300,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //横轴三个子widget
              childAspectRatio: 2, //宽高比为1时，子widget
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            children: widget.list
                .asMap()
                .entries
                .map((e) => InkWell(
                      onTap: () {
                        SmartDialog.dismiss();
                        if (widget.onTap != null) {
                          widget.onTap!(e.key);
                        }
                      },
                      hoverColor: Colors.grey[400],
                      child: Container(
                        color: widget.model?.engrave == e.value
                            ? widget.model?.color
                            : Colors.transparent,
                        child: Center(child: Text(e.value)),
                      ),
                    ))
                .toList(),
          )),
    );
  }
}
