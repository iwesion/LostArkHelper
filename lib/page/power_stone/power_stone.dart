/*
 * @Author: wesion
 * @Date: 2022-09-17 18:00:26
 * @LastEditTime: 2022-10-14 16:53:24
 * @Description: 
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lost_ark/page/power_stone/view/drop_down_dialog.dart';
import 'package:provider/provider.dart';

import '../../provider/power_stone_provider/power_stone_provider.dart';

class PowerStone extends StatefulWidget {
  const PowerStone({Key? key}) : super(key: key);

  @override
  State<PowerStone> createState() => _PowerStoneState();
}

class _PowerStoneState extends State<PowerStone> {
  List titles = ["铭刻1", "铭刻2", "负面"];
  List<int> power = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
  List<int> stoneHole = [10, 9, 8, 7];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PowerStoneProvider>().initView();
  }

  @override
  Widget build(BuildContext context) {
    PowerStoneProvider watchModel = context.watch<PowerStoneProvider>();
    PowerStoneProvider readModel = context.read<PowerStoneProvider>();
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("能力石"),
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
                                return DropDownDialog(
                                  list: stoneHole,
                                  i: watchModel.stoneGrid,
                                  onPressed: (index) {
                                    print(stoneHole[index]);
                                    readModel.chgStoneGrid(stoneHole[index]);
                                  },
                                );
                              });
                        },
                        child: Text("${watchModel.stoneGrid}格"));
                  }),
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
            color: Colors.grey[500],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Builder(builder: (contexxt) {
                  return TextButton(
                      onPressed: () {
                        SmartDialog.showAttach(
                            targetContext: contexxt,
                            alignment: Alignment.bottomCenter,
                            scalePointBuilder: (selfSize) =>
                                Offset(selfSize.width, 0),
                            builder: (_) {
                              return DropDownDialog(
                                list: power,
                                onPressed: (index) {
                                  readModel.expectPower1 = power[index];
                                  readModel.chgUI();
                                },
                              );
                            });
                      },
                      child: RichText(
                          text: TextSpan(text: "铭刻1期望值:", children: [
                        TextSpan(text: readModel.expectPower1.toString())
                      ])));
                }),
                Builder(builder: (contexxt) {
                  return TextButton(
                      onPressed: () {
                        SmartDialog.showAttach(
                            targetContext: contexxt,
                            alignment: Alignment.bottomCenter,
                            scalePointBuilder: (selfSize) =>
                                Offset(selfSize.width, 0),
                            builder: (_) {
                              return DropDownDialog(
                                list: power,
                                onPressed: (index) {
                                  readModel.expectPower2 = power[index];
                                  readModel.chgUI();
                                },
                              );
                            });
                      },
                      child: RichText(
                          text: TextSpan(text: "铭刻2期望值:", children: [
                        TextSpan(text: readModel.expectPower2.toString())
                      ])));
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
                              return DropDownDialog(
                                list: power.reversed.toList(),
                                onPressed: (index) {
                                  readModel.expectEegative =
                                      power.reversed.toList()[index];
                                  readModel.chgUI();
                                },
                              );
                            });
                      },
                      child: RichText(
                          text: TextSpan(text: "负面期望值:", children: [
                        TextSpan(text: watchModel.expectEegative.toString())
                      ])));
                }),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              List<bool> s;
              if (index == 0) {
                s = watchModel.currentStone.powerOne;
              } else if (index == 1) {
                s = watchModel.currentStone.powerTwe;
              } else {
                s = watchModel.currentStone.negative;
              }
              return Container(
                height: 100,
                child: Row(
                  children: [
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: Center(child: Text(titles[index]))),
                    Expanded(
                      child: ListView.builder(
                        controller: ScrollController(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, indexx) {
                          if (indexx < s.length) {
                            String path = "";
                            if (index == 2) {
                              path = s[indexx]
                                  ? "images/power_stone/negative_success.png"
                                  : "images/power_stone/negative_fail.png";
                            } else {
                              path = s[indexx]
                                  ? "images/power_stone/engrave_success.png"
                                  : "images/power_stone/engrave_fail.png";
                            }
                            return Opacity(
                              opacity: s[indexx] ? 1 : 0.2,
                              child: Image.asset(
                                path,
                                width: 50,
                                height: 50,
                              ),
                            );
                          }
                          if (index == 2) {
                            return Image.asset(
                              "images/power_stone/negative_normal.png",
                              width: 50,
                              height: 50,
                            );
                          } else {
                            return Image.asset(
                              "images/power_stone/engrave_normal.png",
                              width: 50,
                              height: 50,
                            );
                          }
                        },
                        itemCount: watchModel.stoneGrid,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        "images/power_stone/star.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              if (index == 0) {
                                readModel.chg(powerOne: true);
                              } else if (index == 1) {
                                readModel.chg(powerTwe: true);
                              } else {
                                readModel.chg(negative: true);
                              }
                            },
                            child: Image.asset(
                              "images/power_stone/success.png",
                              width: 50,
                              height: 50,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (index == 0) {
                                readModel.chg(powerOne: false);
                              } else if (index == 1) {
                                readModel.chg(powerTwe: false);
                              } else {
                                readModel.chg(negative: false);
                              }
                            },
                            child: Image.asset(
                              "images/power_stone/failed.png",
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
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
                TextButton(
                    onPressed: () {
                      readModel.reset();
                    },
                    child: Text("重置")),
                TextButton(
                    onPressed: () {
                      readModel.rollback();
                    },
                    child: Text("后退")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
