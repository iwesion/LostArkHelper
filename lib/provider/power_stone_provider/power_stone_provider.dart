/*
 * @Author: wesion
 * @Date: 2022-09-29 18:25:47
 * @LastEditTime: 2022-10-11 12:15:27
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
    return Stone(negative: [], powerOne: [], powerTwe: []);
  }

  Stone copy() {
    Stone s = Stone.init();
    s.powerOne = List.from(powerOne);
    s.powerTwe = List.from(powerTwe);
    s.negative = List.from(negative);
    return s;
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
    currentStone.negative = [];
    currentStone.powerOne = [];
    currentStone.powerTwe = [];
    clickList.clear();
    notifyListeners();
  }

  void chg({bool? powerOne, bool? powerTwe, bool? negative}) {
    if (powerOne != null && currentStone.powerOne.length < stoneGrid) {
      currentStone.powerOne.add(powerOne);
      clickList.add(currentStone.copy());
      chgUI();
    }
    if (powerTwe != null && currentStone.powerTwe.length < stoneGrid) {
      currentStone.powerTwe.add(powerTwe);
      clickList.add(currentStone.copy());
      chgUI();
    }
    if (negative != null && currentStone.negative.length < stoneGrid) {
      currentStone.negative.add(negative);
      clickList.add(currentStone.copy());
      chgUI();
    }
  }

  void reset() {
    chgStoneGrid(stoneGrid);
    chgUI();
  }

  void rollback() {
    if (clickList.isNotEmpty) {
      clickList.removeLast();
      currentStone =
          clickList.isNotEmpty ? clickList.last.copy() : Stone.init();
      chgUI();
    }
  }
}
