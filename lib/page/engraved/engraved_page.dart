/*
 * @Author: wesion
 * @Date: 2022-09-17 18:12:07
 * @LastEditTime: 2022-09-23 15:25:24
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lost_ark/common/my_color.dart';
import 'package:lost_ark/page/engraved/view/engrave_negative.dart';
import 'package:lost_ark/page/engraved/view/engraved_page_right.dart';
import 'package:lost_ark/provider/engraved_provider/engraved_provider.dart';
import 'package:provider/provider.dart';

import '../../common/my_dialog.dart';
import '../../provider/engraved_provider/model/engraved_model.dart';
import 'view/engrave_list.dart';

class EngravedPage extends StatefulWidget {
  const EngravedPage({Key? key}) : super(key: key);

  @override
  State<EngravedPage> createState() => _EngravedPageState();
}

class _EngravedPageState extends State<EngravedPage> {
  EngravedPageModel comModel = EngravedPageModel();
  @override
  Widget build(BuildContext context) {
    EngravedModel model = context.watch<EngravedModel>();

    return Scaffold(
        body: Container(
      child: Row(
        children: [
          Container(
              width: 400,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        child: TextButton(
                            onPressed: () => {
                                  SmartDialog.show(
                                    builder: (xcontext) {
                                      return MyDialog(
                                        list: comModel.professionList
                                            .map((e) => e.name)
                                            .toList(),
                                        onTap: (index) {
                                          context
                                              .read<EngravedModel>()
                                              .chgProfession(comModel
                                                  .professionList[index]);
                                        },
                                      );
                                    },
                                  )
                                },
                            child: Text("点击选择职业")),
                      ),
                      TextButton(
                          onPressed: () {
                            SmartDialog.show(
                              builder: (context) {
                                return Container(
                                  width: 200,
                                  height: 100,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Center(
                                            child: Text("确认重置所有数据？"),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  SmartDialog.dismiss();
                                                },
                                                child: Text("取消")),
                                            TextButton(
                                                onPressed: () {
                                                  model.reset();
                                                  SmartDialog.dismiss();
                                                },
                                                child: Text(
                                                  "确认",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            "重置",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        child: Center(
                            child: RichText(
                                text: TextSpan(
                                    text: model.currentProfession.name != null
                                        ? "选择的职业是："
                                        : "请先选择职业",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                    children: model.currentProfession.name !=
                                            null
                                        ? [
                                            TextSpan(
                                                text: model
                                                    .currentProfession.name,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff666666)))
                                          ]
                                        : []))),
                      ),
                      TextButton(
                        child: Text("点击增加铭刻"),
                        onPressed: () {
                          SmartDialog.show(
                            builder: (context) {
                              List list = comModel.commonEngraved +
                                  model.currentProfession.engraved;
                              return MyDialog(
                                list: list,
                                onTap: (indexx) {
                                  context
                                      .read<EngravedModel>()
                                      .add(list[indexx]);
                                },
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                  Container(
                    height: 50,
                    color: Colors.grey[200],
                    child: Row(
                      children: [
                        Container(
                          width: 200,
                          child: Center(child: Text("铭刻")),
                        ),
                        Container(
                          width: 100,
                          child: Center(child: Text("期望值")),
                        ),
                        Container(
                          width: 100,
                          child: Center(child: Text("期望差")),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: EngraveList(comModel: comModel, model: model),
                  ),
                  EngraveNegative()
                ],
              )),
          Container(width: 500, height: 700, child: EngravePageRightView())
        ],
      ),
    ));
  }
}
