/*
 * @Author: wesion
 * @Date: 2022-09-17 18:00:26
 * @LastEditTime: 2022-09-29 11:39:05
 * @Description: 
 */
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PowerStone extends StatefulWidget {
  const PowerStone({Key? key}) : super(key: key);

  @override
  State<PowerStone> createState() => _PowerStoneState();
}

class _PowerStoneState extends State<PowerStone> {
  @override
  Widget build(BuildContext context) {
    List<List<bool>> bb = [
      [false],
      [false]
    ];

    List a = [];
    a = copyLLBist(bb);
    a[0][0] = true;

    print("${listEquals(a, bb)}");
    return Scaffold(
      body: Container(),
    );
  }
}

List<List<bool>> copyLLBist(List<List<bool>> list) {
  final arr0 = <List<bool>>[];
  for (var vv in list) {
    final arr1 = <bool>[];
    for (var vvv in vv) {
      arr1.add(vvv);
    }
    arr0.add(arr1);
  }
  return arr0;
}
