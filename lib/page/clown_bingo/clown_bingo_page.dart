/*
 * @Author: wesion
 * @Date: 2022-09-23 17:12:26
 * @LastEditTime: 2022-09-26 18:30:04
 * @Description: 
 */
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/bingo_provider/bingo_provider.dart';

class ClownBingoPage extends StatefulWidget {
  const ClownBingoPage({Key? key}) : super(key: key);

  @override
  State<ClownBingoPage> createState() => _ClownBingoPageState();
}

class _ClownBingoPageState extends State<ClownBingoPage> {
  @override
  Widget build(BuildContext context) {
    BingoProvider watchmodel = context.watch<BingoProvider>();
    BingoProvider readmodel = context.read<BingoProvider>();

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 300,
            color: Colors.grey[100],
            child: Column(
              children: [
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            readmodel.resetBingo();
                          },
                          child: Text("重置")),
                      TextButton(
                          onPressed: () {
                            readmodel.cancleBingo();
                          },
                          child: Text("后退")),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: watchmodel.isInanna,
                          activeColor: Colors.red,
                          onChanged: (b) {
                            readmodel.handleInanna(b!);
                          }),
                      Text("使用伊安娜"),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: watchmodel.isHell,
                        activeColor: Colors.red,
                        onChanged: (b) {
                          readmodel.handleHell(b!);
                        }),
                    Text("地狱难度"),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("炸弹放在骷髅的优先级(越小越好)"),
                      Slider(
                        divisions: 4,
                        value: watchmodel.preferSkull.toDouble(),
                        onChanged: (val) {
                          readmodel.handlePreferSkull(val);
                        },
                        max: 5,
                        min: 1,
                      ),
                    ],
                  ),
                ),
                Text(watchmodel.preferSkull.toString())
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            width: 600,
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                        height: 50,
                        child: Center(
                            child: Text(watchmodel.round < 2
                                ? "请先放置初始炸弹"
                                : "请放置${watchmodel.round - 1}炸弹"))),
                    Container(
                        height: 50,
                        child: Center(
                            child: Text(
                          watchmodel.warnMsg,
                          style: TextStyle(color: Colors.red),
                        ))),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Transform.rotate(
                      angle: pi / 4,
                      child: Container(
                        width: 400,
                        height: 400,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5, //横轴三个子widget
                                  childAspectRatio: 1.0 //宽高比为1时，子widget
                                  ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                readmodel.clickBingo(index ~/ 5, index % 5);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        watchmodel.boxBg(index ~/ 5, index % 5),
                                    image: watchmodel.boxBgImg(
                                        index ~/ 5, index % 5)),
                                margin: EdgeInsets.all(4),
                                child: Center(
                                  child: Transform.rotate(
                                      angle: -pi / 4,
                                      child: Container(
                                        child: Text(
                                          "${index ~/ 5 + 1} -${index % 5 + 1}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                      )),
                                ),
                              ),
                            );
                          },
                          itemCount: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
