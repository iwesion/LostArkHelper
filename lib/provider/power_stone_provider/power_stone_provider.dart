/*
 * @Author: wesion
 * @Date: 2022-09-29 18:25:47
 * @LastEditTime: 2022-10-14 17:23:35
 * @Description: 
 */
import 'dart:math';

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
  int pIndex = 5;
  int pListSucc(p) {
    if (p > 0) {
      p -= 1;
    }
    return p;
  }

  int pListFail(p) {
    if (p < pList.length - 1) {
      p += 1;
    }
    return p;
  }

  num getP(p) {
    if (p < 0) {
      return pList[0];
    }
    return pList[p];
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

  void initView() {
    var pTable = getPTable(stoneGrid, stoneGrid, stoneGrid, pIndex);
  }

  void chg({bool? powerOne, bool? powerTwe, bool? negative}) {
    if (powerOne != null && currentStone.powerOne.length < stoneGrid) {
      currentStone.powerOne.add(powerOne);
      clickList.add(currentStone.copy());
      if (clickList.length > 0) {
        pIndex = powerOne ? pListSucc(pIndex) : pListFail(pIndex);
      } else {
        pIndex = pList.length - 1;
      }
      chgUI();
    }
    if (powerTwe != null && currentStone.powerTwe.length < stoneGrid) {
      currentStone.powerTwe.add(powerTwe);
      clickList.add(currentStone.copy());
      if (clickList.length > 0) {
        pIndex = powerTwe ? pListSucc(pIndex) : pListFail(pIndex);
      } else {
        pIndex = pList.length - 1;
      }
      chgUI();
    }
    if (negative != null && currentStone.negative.length < stoneGrid) {
      currentStone.negative.add(negative);
      clickList.add(currentStone.copy());
      if (clickList.length > 0) {
        pIndex = negative ? pListSucc(pIndex) : pListFail(pIndex);
      } else {
        pIndex = pList.length - 1;
      }
      chgUI();
    }

    var na1 =
        stoneGrid - (clickList.length > 0 ? clickList.last.powerOne.length : 0);
    var na2 =
        stoneGrid - (clickList.length > 0 ? clickList.last.powerTwe.length : 0);
    var nb =
        stoneGrid - (clickList.length > 0 ? clickList.last.negative.length : 0);

    var pTable = getPTable(na1, na2, nb, pIndex);
    print(pTable);
  }

  // 从这里开始演算法
  var EsMap = {};
  var EaMap = {};
  var Ea1Map = {};

  List getPTable(na1, na2, nb, p) {
    var na = na1 + na2;
    var n = na + nb;
    num Es = 0,
        EaA = 0,
        EbA = 0,
        EaB = 0,
        EbB = 0,
        Ea1A1 = 0,
        Ea1A2 = 0,
        Ea2A1 = 0,
        Ea2A2 = 0;
    Es = getEs(n, p);
    print("Es==${Es},n=${n},p=${p}");
    if (na > 0) {
      EaA = calculateEa(na - 1, nb, p, true);
      EbA = Es - EaA; // EbA1 = EbA2 = EbA
    }
    if (nb > 0) {
      EaB = calculateEa(na, nb - 1, p, false);
      EbB = Es - EaB;
    }
    if (na1 > 0) {
      Ea1A1 = calculateEa1(na1 - 1, na2, nb, p, true);
      Ea2A1 = EaA - Ea1A1;
    }
    if (na2 > 0) {
      Ea1A2 = calculateEa1(na1, na2 - 1, nb, p, false);
      Ea2A2 = EaA - Ea1A2;
    }

    return [
      [Ea1A1, Ea2A1, EbA],
      [Ea1A2, Ea2A2, EbA],
      [EaB, EaB, EbB],
      max(EaA, EaB) // 平均
    ]; // 选择A1时分别给出折号
  }

  num getEs(n, p) {
    var k = "${n}_$p";
    if (EsMap.containsKey(k)) {
      print("n=${n},p==${p}");
    } else if (n == 0) {
      EsMap[k] = 0;
    } else {
      EsMap[k] = calculateEs(n - 1, p);
    }
    return EsMap[k];
  }

  num calculateEs(n, p) {
    return calculateE(p, getEs(n, pListSucc(p)), getEs(n, pListFail(p)), true);
  }

  num calculateEa(na, nb, p, same) {
    return calculateE(
        p, getEa(na, nb, pListSucc(p)), getEa(na, nb, pListFail(p)), same);
  }

  num calculateEa1(na1, na2, nb, p, same) {
    return calculateE(p, getEa1(na1, na2, nb, pListSucc(p)),
        getEa1(na1, na2, nb, pListFail(p)), same);
  }

  num calculateE(p, succ, fail, same) {
    var pval = getP(p);

    var v = pval * succ + (1 - pval) * fail;
    if (same) {
      v += pval;
    }
    return v;
  }

  num getEa(na, nb, p) {
    var k = "${na}_${nb}_$p";
    if (EaMap.containsKey(k)) {
    } else if (na == 0) {
      // (0, n)
      EaMap[k] = 0;
    } else if (nb == 0) {
      // (n, 0)
      EaMap[k] = getEs(na, p);
    } else {
      var EaA = calculateEa(na - 1, nb, p, true);
      var EaB = calculateEa(na, nb - 1, p, false);
      EaMap[k] = max(EaA, EaB);
    }
    return EaMap[k];
  }

  num getEa1(na1, na2, nb, p) {
    var k = "${na1}_${na2}_${nb}_$p";
    if (Ea1Map.containsKey(k)) {
    } else if (na1 == 0) {
      // (0, n, m)
      Ea1Map[k] = 0;
    } else if (na2 == 0 && nb == 0) {
      // (n, 0, 0)
      Ea1Map[k] = getEs(na1, p);
    } else if (na2 == 0) {
      // (n, 0, m)
      Ea1Map[k] = getEa(na1, nb, p);
    } else if (nb == 0) {
      // (n, m, 0)
      Ea1Map[k] = getEa(na1, na2, p); // A1을 A2보다 우선시한다고 가정
    } else {
      var Ea1A1 = calculateEa1(na1 - 1, na2, nb, p, true);
      var Ea1A2 = calculateEa1(na1, na2 - 1, nb, p, false);
      Ea1Map[k] = max(Ea1A1, Ea1A2); // A1을 A2보다 우선시한다고 가정
    }
    return Ea1Map[k];
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
