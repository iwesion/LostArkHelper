/*
 * @Author: wesion
 * @Date: 2022-09-19 16:32:41
 * @LastEditTime: 2022-09-20 11:24:42
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../provider/engraved_provider/engraved_provider.dart';
import '../provider/engraved_provider/model/engraved_model.dart';

class MyDialog extends StatefulWidget {
  List list;
  void Function(int index)? onTap;
  MyDialog({Key? key, required this.list, this.onTap}) : super(key: key);

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
              onTap: () {
                SmartDialog.dismiss();
                if (widget.onTap != null) {
                  widget.onTap!(index);
                }
              },
              title: Text(widget.list[index].toString()));
        },
        itemCount: widget.list.length,
      ),
    );
  }
}
