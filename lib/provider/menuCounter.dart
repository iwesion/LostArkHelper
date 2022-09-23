/*
 * @Author: wesion
 * @Date: 2022-09-19 15:26:50
 * @LastEditTime: 2022-09-19 16:59:58
 * @Description: 
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MenuCounter with ChangeNotifier, DiagnosticableTreeMixin {
  int _pageNum = 0;

  int get pageNum => _pageNum;

  void chgPageNum(int num) {
    _pageNum = num;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('pageNum', pageNum));
  }
}
