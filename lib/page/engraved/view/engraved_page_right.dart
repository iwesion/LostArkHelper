/*
 * @Author: wesion
 * @Date: 2022-09-20 16:29:18
 * @LastEditTime: 2022-10-09 11:22:22
 * @Description: 
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lost_ark/common/my_dialog.dart';
import 'package:lost_ark/provider/engraved_provider/engraved_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/my_color.dart';
import '../../../provider/engraved_provider/model/engraved_model.dart';
import '../../power_stone/view/drop_down_dialog.dart';

class EngravePageRightView extends StatefulWidget
    with ChangeNotifier, DiagnosticableTreeMixin {
  EngravePageRightView({Key? key}) : super(key: key);

  @override
  State<EngravePageRightView> createState() => _EngravePageRightViewState();
}

class _EngravePageRightViewState extends State<EngravePageRightView> {
  @override
  Widget build(BuildContext context) {
    EngravedModel model = context.read<EngravedModel>();

    ///职业铭刻+通用

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        EquipmentModel listItem = model.equipmentList[index];
        List engraveList;
        if (index == 5) {
          engraveList = model.targetModelList
              .where(
                  (e) => !model.currentProfession.engraved.contains(e.engrave))
              .map((e) => e.engrave)
              .toList();
        } else {
          engraveList = model.targetModelList.map((e) => e.engrave).toList();
        }
        return Column(
          children: [
            Container(
              height: 100,
              child: Row(
                children: [
                  //首饰名字
                  Container(
                    width: 100,
                    child: Center(child: Text(listItem.name)),
                  ),
                  Column(
                    children: [
                      // 铭刻1
                      GestureDetector(
                        onTap: () {
                          SmartDialog.show(
                            builder: (context) {
                              return MyDialog(
                                list: engraveList,
                                onTap: (indexx) {
                                  model.equipmentList[index].engraved1 =
                                      engraveList[indexx];
                                  for (var target in model.targetModelList) {
                                    if (target.engrave == engraveList[indexx]) {
                                      model.equipmentList[index]
                                          .engravedColor1 = target.color;
                                    }
                                  }
                                  model.chgEquipmentModel();
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          color: model.equipmentList[index].engravedColor1 ??
                              Colors.transparent,
                          child: Center(
                              child: Text(
                            listItem.engraved1 ?? "选择铭刻",
                            style: TextStyle(
                                color: listItem.engraved1 != null
                                    ? Colors.white
                                    : Colors.grey[400]),
                          )),
                        ),
                      ),
                      // 铭刻2
                      GestureDetector(
                        onTap: () {
                          SmartDialog.show(
                            builder: (context) {
                              return MyDialog(
                                list: engraveList,
                                onTap: (indexx) {
                                  model.equipmentList[index].engraved2 =
                                      engraveList[indexx];
                                  for (var target in model.targetModelList) {
                                    if (target.engrave == engraveList[indexx]) {
                                      model.equipmentList[index]
                                          .engravedColor2 = target.color;
                                    }
                                  }
                                  model.chgEquipmentModel();
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          color: model.equipmentList[index].engravedColor2 ??
                              Colors.transparent,
                          child: Center(
                              child: Text(
                            listItem.engraved2 ?? "选择铭刻",
                            style: TextStyle(
                                color: listItem.engraved2 != null
                                    ? Colors.white
                                    : Colors.grey[400]),
                          )),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      // 铭刻1数
                      Builder(builder: (contexxt) {
                        return GestureDetector(
                          onTap: () {
                            SmartDialog.showAttach(
                                targetContext: contexxt,
                                alignment: index > 4
                                    ? Alignment.topCenter
                                    : Alignment.bottomCenter,
                                // animationType: SmartAnimationType.scale,
                                scalePointBuilder: (selfSize) =>
                                    Offset(selfSize.width, 0),
                                builder: (_) {
                                  List<int> list = index != 5
                                      ? index == 6
                                          ? [3, 6, 9, 12]
                                          : [3, 4, 5, 6]
                                      : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
                                  return DropDownDialog(
                                    width: 100,
                                    list: list,
                                    onPressed: (indexx) {
                                      model.equipmentList[index].engravedNum1 =
                                          list[indexx];
                                      model.chgEquipmentModel();
                                    },
                                  );
                                });
                          },
                          child: Container(
                            color: Colors.transparent,
                            height: 50,
                            width: 100,
                            child: Center(
                                child: Text(
                              listItem.engravedNum1.toString(),
                              style: TextStyle(
                                  color: listItem.engravedNum1 != null &&
                                          listItem.engravedNum1! > 0
                                      ? Color.fromARGB(255, 40, 7, 255)
                                      : Colors.grey[300],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24),
                            )),
                          ),
                        );
                      }),
                      // 铭刻2数
                      Builder(builder: (contexxt) {
                        return GestureDetector(
                          onTap: () {
                            SmartDialog.showAttach(
                                targetContext: contexxt,
                                alignment: index > 4
                                    ? Alignment.topCenter
                                    : Alignment.bottomCenter,
                                // animationType: SmartAnimationType.scale,
                                scalePointBuilder: (selfSize) =>
                                    Offset(selfSize.width, 0),
                                builder: (_) {
                                  List<int> list = index != 5
                                      ? index == 6
                                          ? [3, 6, 9, 12]
                                          : [3, 4, 5, 6]
                                      : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
                                  return DropDownDialog(
                                    width: 100,
                                    list: list,
                                    onPressed: (indexx) {
                                      model.equipmentList[index].engravedNum2 =
                                          list[indexx];
                                      model.chgEquipmentModel();
                                    },
                                  );
                                });
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            color: Colors.transparent,
                            child: Center(
                                child: Text(
                              listItem.engravedNum2.toString(),
                              style: TextStyle(
                                  color: listItem.engravedNum2 != null &&
                                          listItem.engravedNum2! > 0
                                      ? Color.fromARGB(255, 40, 7, 255)
                                      : Colors.grey[300],
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400),
                            )),
                          ),
                        );
                      })
                    ],
                  ),
                  index < 6
                      ? GestureDetector(
                          onTap: () {
                            SmartDialog.show(
                              builder: (context) {
                                List list =
                                    EngravedPageModel().negativeEngraved;
                                return MyDialog(
                                  list: list,
                                  onTap: (indexx) {
                                    model.equipmentList[index].negativeEngrave =
                                        list[indexx];
                                    model.chgEquipmentModel();
                                  },
                                );
                              },
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              SmartDialog.show(
                                builder: (context) {
                                  return MyDialog(
                                    list: EngravedPageModel().negativeEngraved,
                                    onTap: (indexx) {
                                      model.equipmentList[index]
                                              .negativeEngrave =
                                          EngravedPageModel()
                                              .negativeEngraved[indexx];
                                      model.chgEquipmentModel();
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 100,
                              child: Center(
                                  child: Text(
                                listItem.negativeEngrave ?? "选择负面",
                                style: TextStyle(
                                    color: listItem.negativeEngrave != null
                                        ? Colors.black
                                        : Colors.grey[300]),
                              )),
                            ),
                          ),
                        )
                      : Container(),
                  index < 6
                      ? Builder(builder: (contexxt) {
                          return GestureDetector(
                            onTap: () {
                              SmartDialog.showAttach(
                                  targetContext: contexxt,
                                  alignment: index > 3
                                      ? Alignment.topCenter
                                      : Alignment.bottomCenter,
                                  // animationType: SmartAnimationType.scale,
                                  scalePointBuilder: (selfSize) =>
                                      Offset(selfSize.width, 0),
                                  builder: (_) {
                                    List<int> list = index != 5
                                        ? [1, 2, 3, 4, 5]
                                        : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
                                    return DropDownDialog(
                                      width: 100,
                                      list: list,
                                      onPressed: (indexx) {
                                        model.equipmentList[index]
                                            .negativeEngraveNum = list[indexx];
                                        model.chgEquipmentModel();
                                      },
                                    );
                                  });
                            },
                            child: Container(
                              width: 100,
                              color: Colors.transparent,
                              child: Center(
                                  child: Text(
                                listItem.negativeEngraveNum.toString(),
                                style: TextStyle(
                                    color:
                                        listItem.negativeEngraveNum != null &&
                                                listItem.negativeEngraveNum! > 0
                                            ? Colors.black
                                            : Colors.grey[300],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22),
                              )),
                            ),
                          );
                        })
                      : Container(),
                ],
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.red[300],
            )
          ],
        );
      },
      itemCount: model.equipmentList.length,
    );
  }
}
