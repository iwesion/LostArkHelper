/*
 * @Author: wesion
 * @Date: 2022-09-29 18:25:47
 * @LastEditTime: 2022-09-29 18:30:23
 * @Description: 
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PowerStoneProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ///能力石孔数
  int stoneGrid = 10;
}
