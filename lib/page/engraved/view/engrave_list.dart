/*
 * @Author: wesion
 * @Date: 2022-09-20 14:43:07
 * @LastEditTime: 2022-10-08 17:57:30
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reorderables/reorderables.dart';
import '../../../common/my_dialog.dart';
import '../../../provider/engraved_provider/engraved_provider.dart';
import '../../../provider/engraved_provider/model/engraved_model.dart';

class EngraveList extends StatelessWidget {
  const EngraveList({
    Key? key,
    required this.comModel,
    required this.model,
  }) : super(key: key);

  final EngravedPageModel comModel;
  final EngravedModel model;

  @override
  Widget build(BuildContext context) {
    List list = comModel.commonEngraved + model.currentProfession.engraved;
    void _onReorder(int oldIndex, int newIndex) {
      context.read<EngravedModel>().swapPlaces(oldIndex, newIndex);
    }

    return PrimaryScrollController(
      controller: ScrollController(),
      child: ReorderableTable(
        children: model.targetModelList
            .asMap()
            .entries
            .map((e) => ReorderableTableRow(
                  key: ObjectKey(e.value),
                  children: [
                    _listItem(
                      e.key,
                      list,
                      context,
                    )
                  ],
                ))
            .toList(),
        onReorder: _onReorder,
      ),
    );
  }

  Slidable _listItem(int index, List<dynamic> list, BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              context.read<EngravedModel>().delect(index);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: '删除',
          )
        ],
      ),
      child: _item(list, context, index),
    );
  }

  Container _item(List<dynamic> list, BuildContext context, int index) {
    return Container(
      height: 50,
      child: Row(
        children: [
          //铭刻选择
          GestureDetector(
            onTap: () => {
              SmartDialog.show(
                builder: (xcontext) {
                  return MyDialog(
                    list: list,
                    onTap: (indexx) {
                      context
                          .read<EngravedModel>()
                          .chgEngrave(list[indexx], index);
                    },
                  );
                },
              )
            },
            child: Container(
              width: 200,
              color: model.targetModelList[index].color,
              child: Center(
                  child: Text(
                model.targetModelList[index].engrave ?? "",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
          //修改铭刻期望值
          GestureDetector(
            onTap: () {
              SmartDialog.show(
                builder: (context) => MyDialog(
                  list: comModel.engraveExpect,
                  onTap: (indexx) {
                    context.read<EngravedModel>().chgEngraveExpect(
                        comModel.engraveExpect[indexx], index);
                  },
                ),
              );
            },
            child: Container(
              color: model.targetModelList[index].color?.withAlpha(100),
              width: 100,
              child: Center(
                  child: Text(
                model.targetModelList[index].engraveEnergy.toString(),
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
          //期望值差
          Container(
            width: 100,
            child: Center(
                child: Text(
              model.targetModelList[index].gap.toString(),
              style: TextStyle(
                  color: model.targetModelList[index].gap! >= 0
                      ? Colors.cyan[300]
                      : Colors.red),
            )),
          ),
        ],
      ),
    );
  }
}
