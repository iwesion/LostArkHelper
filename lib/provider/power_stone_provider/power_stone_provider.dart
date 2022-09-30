/*
 * @Author: wesion
 * @Date: 2022-09-29 18:25:47
 * @LastEditTime: 2022-09-30 15:56:24
 * @Description: 
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Stone {
  List<bool> powerOne = [];
  List<bool> powerTwe = [];
  List<bool> negative = [];
  Stone(
      {required this.negative, required this.powerOne, required this.powerTwe});
  static Stone init() {
    return Stone(
        negative: List.filled(10, false),
        powerOne: List.filled(10, false),
        powerTwe: List.filled(10, false));
  }
}

class PowerStoneProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ///概率组
  List pList = [0.25, 0.35, 0.45, 0.55, 0.65, 0.75];

  ///显示的概率(概率组的下标)
  double p = 5;
  void pListSucc(pIndex) {
    if (pIndex > 0) {
      pIndex -= 1;
    }
    p = pList[pIndex];
  }

  void pListFail(pIndex) {
    if (pIndex < pList.length - 1) {
      pIndex += 1;
    }
    p = pList[pIndex];
  }

  ///能力石孔数
  int stoneGrid = 10;
  int expectPower1 = 7;
  int expectPower2 = 7;
  int expectEegative = 0;

  void chgUI() {
    notifyListeners();
  }

  ///保存用户输入的变量操作
  List<Stone> clickList = [];

  ///当前石头的状态
  Stone currentStone = Stone.init();

  ///变更石头的孔数
  void chgStoneGrid(int n) {
    stoneGrid = n;
    currentStone.negative = List.filled(n, false);
    currentStone.powerOne = List.filled(n, false);
    currentStone.powerTwe = List.filled(n, false);
    clickList.clear();
    notifyListeners();
  }

  void reset() {
    chgStoneGrid(stoneGrid);
  }

  void back() {
    clickList.removeLast();
  }
}
