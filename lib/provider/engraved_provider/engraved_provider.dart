/*
 * @Author: wesion
 * @Date: 2022-09-19 16:00:11
 * @LastEditTime: 2022-09-23 11:43:07
 * @Description: 
 */
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lost_ark/common/my_color.dart';
import 'package:lost_ark/provider/engraved_provider/model/engraved_model.dart';

class EngravedModel with ChangeNotifier, DiagnosticableTreeMixin {
  ///当前职业铭刻数组
  Profession currentProfession = Profession(engraved: []);

  List<TargetModel> targetModelList = [];

  List<EquipmentModel> equipmentList = [
    EquipmentModel(name: "项链")..initEngravedNum(),
    EquipmentModel(name: "耳环1")..initEngravedNum(),
    EquipmentModel(name: "耳环2")..initEngravedNum(),
    EquipmentModel(name: "戒指1")..initEngravedNum(),
    EquipmentModel(name: "戒指2")..initEngravedNum(),
    EquipmentModel(name: "能力石")..initEngravedNum(),
    EquipmentModel(name: "额外附魔")..initEngravedNum(),
  ];
  Map negativeEngrave = {
    "攻击力减少": 0,
    "防御力减少": 0,
    "攻击速度减少": 0,
    "移动速度减少": 0,
  };
  void reset() {
    currentProfession = Profession(engraved: []);
    targetModelList = [];
    equipmentList = [
      EquipmentModel(name: "项链")..initEngravedNum(),
      EquipmentModel(name: "耳环1")..initEngravedNum(),
      EquipmentModel(name: "耳环2")..initEngravedNum(),
      EquipmentModel(name: "戒指1")..initEngravedNum(),
      EquipmentModel(name: "戒指2")..initEngravedNum(),
      EquipmentModel(name: "能力石")..initEngravedNum(),
      EquipmentModel(name: "额外附魔")..initEngravedNum(),
    ];
    negativeEngrave = {
      "攻击力减少": 0,
      "防御力减少": 0,
      "攻击速度减少": 0,
      "移动速度减少": 0,
    };
    notifyListeners();
  }

  //选择职业
  void chgProfession(Profession currentProfession) {
    this.currentProfession = currentProfession;
    notifyListeners();
  }

  ///添加
  void add(String engrave) {
    TargetModel m = TargetModel(
        engrave: engrave,
        engraveEnergy: 15,
        gap: -15,
        color: MyColor().randomColor);
    targetModelList.add(m);
    notifyListeners();
  }

  void delect(int index) {
    targetModelList.removeAt(index);
    notifyListeners();
  }

  ///修改铭刻类型
  void chgEngrave(String engrave, int index) {
    targetModelList[index].engrave = engrave;
    chgEngraveExpect(15, index);
    notifyListeners();
  }

  ///修改铭刻期望值
  void chgEngraveExpect(int engraveExpect, int index) {
    targetModelList[index].engraveEnergy = engraveExpect;
    targetModelList[index].gap = engraveExpect * -1;
    sumEnergyByleft(targetModelList[index]);
    notifyListeners();
  }

  //左边目标铭刻修改，遍历首饰计算期望差
  void sumEnergyByleft(TargetModel model) {
    for (var element in equipmentList) {
      if (element.engraved1 == model.engrave) {
        model.gap = model.gap! + element.engravedNum1!;
      }
      if (element.engraved2 == model.engrave) {
        model.gap = model.gap! + element.engravedNum2!;
      }
    }
  }

  ///统计负面
  void sumNegative() {
    negativeEngrave.clear();
    negativeEngrave = {
      "攻击力减少": 0,
      "防御力减少": 0,
      "攻击速度减少": 0,
      "移动速度减少": 0,
    };
    for (var element in equipmentList) {
      if (element.negativeEngrave != null) {
        negativeEngrave[element.negativeEngrave] += element.negativeEngraveNum;
      }
    }
  }

  ///修改首饰、能力石、附魔
  void chgEquipmentModel() {
    Map engraveMap = {};
    equipmentList.forEach((element) {
      if (element.engraved1 != null) {
        if (engraveMap[element.engraved1] == null) {
          engraveMap[element.engraved1] = element.engravedNum1;
        } else {
          engraveMap[element.engraved1] += element.engravedNum1;
        }
      }
      if (element.engraved2 != null) {
        if (engraveMap[element.engraved2] == null) {
          engraveMap[element.engraved2] = element.engravedNum2;
        } else {
          engraveMap[element.engraved2] += element.engravedNum2;
        }
      }
    });
    targetModelList.forEach((element) {
      if (engraveMap[element.engrave] != null) {
        element.gap = engraveMap[element.engrave] - element.engraveEnergy;
      }
    });
    sumNegative();
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IntProperty('pageNum', pageNum));
  // }
}
