/*
 * @Author: wesion
 * @Date: 2022-09-23 17:12:26
 * @LastEditTime: 2022-09-24 17:37:36
 * @Description: 
 */
import 'dart:math';

import 'package:flutter/material.dart';

class ClownBingoPage extends StatefulWidget {
  const ClownBingoPage({Key? key}) : super(key: key);

  @override
  State<ClownBingoPage> createState() => _ClownBingoPageState();
}

class _ClownBingoPageState extends State<ClownBingoPage> {
  @override
  Widget build(BuildContext context) {
    print([1, 3, 4, 4].map((e) => e > 2));
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
                      TextButton(onPressed: () {}, child: Text("重置")),
                      TextButton(onPressed: () {}, child: Text("前进")),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: false,
                          activeColor: Colors.red,
                          onChanged: (b) {}),
                      Text("使用伊安娜"),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: false,
                        activeColor: Colors.red,
                        onChanged: (b) {}),
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
                        value: 3,
                        onChanged: (val) {},
                        max: 5,
                        min: 1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            width: 600,
            child: Column(
              children: [
                Container(height: 100, child: Center(child: Text("请放置xx炸弹"))),
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
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                    opacity: 0.8,
                                    image: AssetImage('images/bingo/skull.png'),
                                  )),
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
