/*
 * @Author: wesion
 * @Date: 2022-09-17 18:00:26
 * @LastEditTime: 2022-09-27 10:14:29
 * @Description: 
 */
import 'dart:convert';

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
    a = json.decode(json.encode(bb));
    a[0][0] = true;

    print("2------------${bb[0][0]}");
    return Scaffold(
      body: Container(),
    );
  }
}
