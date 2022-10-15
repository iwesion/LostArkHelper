/*
 * @Author: wesion
 * @Date: 2022-10-15 16:40:29
 * @LastEditTime: 2022-10-15 18:21:09
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../power_stone/view/drop_down_dialog.dart';

class SuccubusPage extends StatefulWidget {
  const SuccubusPage({Key? key}) : super(key: key);

  @override
  State<SuccubusPage> createState() => _SuccubusPageState();
}

class _SuccubusPageState extends State<SuccubusPage> {
  List<String> list = ["P1拉球", "p2翅膀", "P3分身"];
  List imgList = [
    "images/meimo/meimo_p1.png",
    [
      "images/meimo/chibang0.png",
      "images/meimo/chibang1.png",
      "images/meimo/chibang2.png"
    ],
    "images/meimo/meimo_p2.png"
  ];
  int titleIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: titleIndex == 0
                    ? RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            children: [
                            TextSpan(
                                text: "红-",
                                style: TextStyle(color: Colors.red)),
                            TextSpan(
                                text: "蓝-",
                                style: TextStyle(color: Colors.blue)),
                            TextSpan(
                                text: "绿-",
                                style: TextStyle(color: Colors.green)),
                            TextSpan(
                                text: "白-",
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                                text: "黑",
                                style: TextStyle(color: Colors.black)),
                          ]))
                    : Text(
                        titleIndex == 1
                            ? "紫色标记\n3个紫色则影子顺序为012\n2个紫色影子顺序为210"
                            : "3(连)+2(分)选3连中间\n3(连)+2(连)选靠近水平线4、9\n4连在5、7\n2+2+1在23(看脸)",
                        style: TextStyle(
                            color: titleIndex == 1 ? Colors.purple : Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: titleIndex != 1
                    ? Image.asset(
                        imgList[titleIndex],
                        fit: BoxFit.contain,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: RichText(
                                    text: const TextSpan(
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                      TextSpan(text: "0 "),
                                      TextSpan(
                                        text: "翅膀",
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ])),
                              ),
                              Image.asset(
                                imgList[titleIndex][0],
                                fit: BoxFit.contain,
                              ),
                            ]),
                          ),
                          Container(
                            height: 150,
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: RichText(
                                    text: const TextSpan(
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                      TextSpan(text: "1 "),
                                      TextSpan(
                                        text: "翅膀",
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ])),
                              ),
                              Image.asset(
                                imgList[titleIndex][1],
                                fit: BoxFit.contain,
                              ),
                            ]),
                          ),
                          Container(
                            height: 150,
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: RichText(
                                    text: const TextSpan(
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                      TextSpan(text: "2 "),
                                      TextSpan(
                                        text: "翅膀",
                                        style: TextStyle(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ])),
                              ),
                              Image.asset(
                                imgList[titleIndex][2],
                                fit: BoxFit.contain,
                              ),
                            ]),
                          )
                        ],
                      ),
              ),
            ],
          ),
          Positioned(
              left: 20,
              top: 20,
              child: Material(
                borderRadius: BorderRadius.circular(8),
                child: Builder(builder: (contexxt) {
                  return InkWell(
                    onTap: () {
                      SmartDialog.showAttach(
                          targetContext: contexxt,
                          alignment: Alignment.bottomCenter,
                          // animationType: SmartAnimationType.scale,
                          scalePointBuilder: (selfSize) =>
                              Offset(selfSize.width, 0),
                          builder: (_) {
                            return DropDownDialog(
                              width: 100,
                              list: list,
                              onPressed: (indexx) {
                                setState(() {
                                  titleIndex = indexx;
                                });
                              },
                            );
                          });
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.menu),
                          Text(
                            list[titleIndex],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              )),
        ],
      ),
    );
  }
}
