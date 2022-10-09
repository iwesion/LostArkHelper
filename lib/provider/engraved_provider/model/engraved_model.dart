/*
 * @Author: wesion
 * @Date: 2022-09-19 11:54:27
 * @LastEditTime: 2022-10-09 10:26:47
 * @Description: 
 */

import 'package:flutter/material.dart';

class Profession {
  ///职业
  String? name;

  ///职业铭刻数组
  List<String> engraved;

  ///当前选中的职业铭刻
  String? presentEngraved;

  ///单铭刻or双铭刻
  int? markNum;

  Profession(
      {this.name, required this.engraved, this.presentEngraved, this.markNum});
}

///目标
class TargetModel {
  ///铭刻
  String? engrave;

  ///期望铭刻等级
  int? engraveEnergy;

  ///距离期望铭刻差距
  int? gap;

  ///背景色
  Color? color;

  Object? key;

  TargetModel({
    this.engrave,
    this.engraveEnergy,
    this.gap,
    this.color,
  });
}

//装备
class EquipmentModel {
  ///首饰名称
  String name;

  ///铭刻1
  String? engraved1;

  ///铭刻2
  String? engraved2;

  ///铭刻1颜色
  Color? engravedColor1;

  ///铭刻2颜色
  Color? engravedColor2;

  ///铭刻活力1
  int? engravedNum1;

  ///铭刻活力2
  int? engravedNum2;

  ///负面
  String? negativeEngrave;

  ///负面活力
  int? negativeEngraveNum;

  EquipmentModel(
      {required this.name,
      this.engraved1,
      this.engraved2,
      this.engravedNum1,
      this.engravedNum2,
      this.negativeEngrave,
      this.negativeEngraveNum,
      this.engravedColor1,
      this.engravedColor2});
  void initEngravedNum() {
    engravedNum1 = 0;
    engravedNum2 = 0;
    negativeEngraveNum = 0;
  }
}

class EngravedPageModel {
  ///职业铭刻
  List<Profession> professionList = [
    Profession(name: "狂战", engraved: [
      "狂气",
      "狂战士的杀手锏",
    ]),
    Profession(name: "侦查", engraved: [
      "进化的遗产",
      "阿尔泰因科技",
    ]),
    Profession(name: "大锤", engraved: [
      "愤怒重锤",
      "重力修炼",
    ]),
    Profession(name: "审判", engraved: [
      "审判者",
      "祝福光环",
    ]),
    Profession(name: "督军", engraved: [
      "战斗姿态",
      "孤独的骑士",
    ]),
    Profession(name: "卡牌", engraved: [
      "皇后的恩典",
      "皇帝的敕令",
    ]),
    Profession(name: "召唤", engraved: [
      "上级召唤师",
      "溢出的交感",
    ]),
    Profession(name: "奶妈", engraved: [
      "真实的英勇",
      "迫切的救赎",
    ]),
    Profession(name: "格斗", engraved: [
      "赤子之心",
      "奥义强化",
    ]),
    Profession(name: "散打", engraved: [
      "粉碎之拳",
      "极限:武术",
    ]),
    Profession(name: "气功", engraved: [
      "打通三脉",
      "逆天之体",
    ]),
    Profession(name: "枪术", engraved: [
      "绝顶",
      "节制",
    ]),
    Profession(name: "刀锋", engraved: [
      "刀刃残影",
      "刀锋迸裂",
    ]),
    Profession(name: "半魔", engraved: [
      "完美抑制",
      "难抑冲动",
    ]),
    Profession(name: "死神", engraved: [
      "饥渴",
      "月声",
    ]),
    Profession(name: "鹰眼", engraved: [
      "第二同伴",
      "死亡袭击",
    ]),
    Profession(name: "男枪", engraved: [
      "武器强化",
      "手枪专家",
    ]),
    Profession(name: "枪炮（大枪）", engraved: [
      "炮击强化",
      "连续炮击",
    ]),
    Profession(name: "女枪", engraved: [
      "和平缔造者",
      "狩猎时间",
    ]),
    Profession(name: "散打（男）", engraved: [
      "一击必杀!",
      "奥义乱舞",
    ]),
    Profession(name: "女巫", engraved: [
      "点火",
      "回流",
    ])
  ];

  /// 负面铭刻
  List<String> negativeEngraved = [
    "攻击力减少",
    "防御力减少",
    "攻击速度减少",
    "移动速度减少",
  ];

  ///通用铭刻
  List<String> commonEngraved = [
    "怨恨",
    "巫毒娃娃",
    "肾上腺素",
    "锋利的钝器",
    "突击队长",
    "拦路虎",
    "质量增加",
    "稳操胜算",
    "重型铠甲",
    "超级蓄力",
    "侧击大师",
    "速战速决",
    "以太生成",
    "专业医生",
    "化险为夷",
    "觉醒",
    "精气吸收",
    "霸凌弱者",
    "以太捕食者",
    "攻击要害",
    "最大魔力增加",
    "魔力效率增加",
    "起身大师",
    "头击大师",
    "不屈",
    "护盾穿透",
    "冲击修炼",
    "潜能激发",
    "女神的庇佑",
    "坚定意志",
    "爆破大师",
    "护盾强化",
    "招魂术",
    "先发制人",
    "断骨",
    "雷霆万钧",
    "胜负师",
    "偷袭大师",
    "魔力流动",
    "推进力",
    "引人注目",
    "紧急救援",
    "精密短刀"
  ];

  ///铭刻期望值
  List<int> engraveExpect = [5, 10, 15];
}
