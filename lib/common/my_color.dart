/*
 * @Author: wesion
 * @Date: 2022-09-19 15:43:49
 * @LastEditTime: 2022-09-23 11:19:27
 * @Description: 
 */
import 'dart:math';

import 'package:flutter/material.dart';

class MyColor {
  Color randomColor = Color.fromRGBO(
      Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.8);
  //负面

  static Color negativeColor() {
    return Colors.red;
  }
}
