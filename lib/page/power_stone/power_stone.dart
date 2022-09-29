/*
 * @Author: wesion
 * @Date: 2022-09-17 18:00:26
 * @LastEditTime: 2022-09-29 18:46:11
 * @Description: 
 */
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class PowerStone extends StatefulWidget {
  const PowerStone({Key? key}) : super(key: key);

  @override
  State<PowerStone> createState() => _PowerStoneState();
}

class _PowerStoneState extends State<PowerStone> {
  List titles = ["铭刻1", "铭刻2", "负面"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("能力石"),
                  TextButton(onPressed: () {}, child: Text("10格")),
                ],
              ),
              Row(
                children: [
                  Text("自动调整"),
                  Switch(value: true, onChanged: (b) {}),
                ],
              )
            ],
          ),
          Container(
            height: 100,
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Builder(builder: (contexxt) {
                  return TextButton(
                      onPressed: () {
                        SmartDialog.showAttach(
                          targetContext: contexxt,
                          alignment: Alignment.bottomCenter,
                          // animationType: SmartAnimationType.scale,
                          scalePointBuilder: (selfSize) =>
                              Offset(selfSize.width, 0),
                          builder: (_) {
                            return Container(
                                height: 50, width: 30, color: Colors.red);
                          },
                        );
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "铭刻1:>=",
                              children: [TextSpan(text: "7")])));
                }),
                Builder(builder: (contexxt) {
                  return TextButton(
                      onPressed: () {
                        SmartDialog.showAttach(
                          targetContext: contexxt,
                          alignment: Alignment.bottomCenter,
                          // animationType: SmartAnimationType.scale,
                          scalePointBuilder: (selfSize) =>
                              Offset(selfSize.width, 0),
                          builder: (_) {
                            return Container(
                                height: 50, width: 30, color: Colors.red);
                          },
                        );
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "铭刻2:>=",
                              children: [TextSpan(text: "7")])));
                }),
                Builder(builder: (contexxt) {
                  return TextButton(
                      onPressed: () {
                        SmartDialog.showAttach(
                          targetContext: contexxt,
                          alignment: Alignment.bottomCenter,
                          // animationType: SmartAnimationType.scale,
                          scalePointBuilder: (selfSize) =>
                              Offset(selfSize.width, 0),
                          builder: (_) {
                            return Container(
                                height: 50, width: 30, color: Colors.red);
                          },
                        );
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "负面:>=", children: [TextSpan(text: "7")])));
                }),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                child: Row(
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        child: Center(child: Text(titles[index]))),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [1, 2, 3, 4, 5, 6, 7, 8, 9]
                            .map((e) => Container(
                                  color: Colors.red,
                                  width: 40,
                                  height: 40,
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Column(
                        children: [Text("成功"), Text("失败")],
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: 3,
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: Text("重置")),
                TextButton(onPressed: () {}, child: Text("后退")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
