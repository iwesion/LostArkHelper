/*
 * @Author: wesion
 * @Date: 2022-09-23 18:13:07
 * @LastEditTime: 2022-09-26 16:46:11
 * @Description: 
 */

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Xy {
  List<bool> col;
  List<bool> row;
  bool diS;
  bool diD;
  Xy(
      {required this.row,
      required this.col,
      required this.diD,
      required this.diS});
}

class Score {
  num x;
  num y;
  num score;
  Score({required this.x, required this.y, required this.score});
}

class BingoProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int round = 0;
  List<List<List<bool>>> bingo = [
    [
      [false, false, false, false, false],
      [false, false, false, false, false],
      [false, false, false, false, false],
      [false, false, false, false, false],
      [false, false, false, false, false],
    ]
  ];

  ///是否使用伊安娜
  bool isInanna = false;

  ///是否地狱模式
  bool isHell = false;

  ///回退
  List hellPos = [-1, -1];

  ///错误提醒
  String warnMsg = "";

  ///是否保持语言识别
  bool stillListening = false;

  ///炸弹放置在骷髅上的优先级
  num preferSkull = 2;

  ///分数的重量
  List scoreWeight = [1e10, 2e9, 1e7, 5e4, 5e4 * 10 * 2 + 1e4, 100, 1];

  List<List<bool>> transM(List<List<bool>> a) {
    return a[0]
        .asMap()
        .entries
        .map((e) => a.map((el) => el[e.key]).toList())
        .toList();
  }

  List<List<bool>> check = [
    [false, false, false, false, false],
    [false, true, false, false, false],
    [false, false, false, false, false],
    [false, false, false, false, false],
    [false, false, false, false, false],
  ];
  List isc = [
    [2, 2, 2, 2, 0.5],
    [2, 20, 10, 2, 0.5],
    [2, 10, 7, 2, 0.5],
    [2, 2, 2, 2, 0.5],
    [0.5, 0.5, 0.5, 0.5, 0.5],
  ];

  ///检查bingo（Xy）
  Xy checkBingo(List<List<bool>> a) {
    return Xy(
        row: a
            .map((x) => x.reduce((value, element) => value && element))
            .toList(),
        col: transM(a)
            .map((e) => e.reduce((value, element) => value && element))
            .toList(),
        diD: false,
        diS: false);
  }

  ///判断是否为红色炸弹
  bool isRed(Xy checkRes, int x, int y) {
    if (checkRes.row[x] || checkRes.col[y]) {
      return true;
    } else if (x == y && checkRes.diS) {
      return true;
    } else if (x + y == 4 && checkRes.diD) {
      return true;
    }
    return false;
  }

  ///判断是否为炸弹
  bool isSkull(List<List<bool>> b, int x, int y) {
    if (x < 0 || y < 0 || x > 4 || y > 4) {
      return true;
    }
    if (isHell && x == hellPos[0] && y == hellPos[1]) {
      return true;
    }
    if (b[x][y]) {
      return true;
    }
    return false;
  }

  num isIsolate(List<List<bool>> b, num x, num y) {
    num isSk(tx, ty) {
      if (isSkull(b, tx, ty)) return 1;
      return 0;
    }

    isSk(x, y);
    return isSk(x + 1, y + 1) +
        isSk(x + 1, y) +
        isSk(x + 1, y - 1) +
        isSk(x, y + 1) +
        isSk(x, y - 1) +
        isSk(x - 1, y + 1) +
        isSk(x - 1, y) +
        isSk(x - 1, y - 1);
  }

  ///判断是否为地狱模式
  bool isHellOver(b) {
    if (!isHell) return false;
    if (hellPos[0] < 0 || hellPos[1] < 0) return false;
    return b[hellPos[0]][hellPos[1]];
  }

  ///bingo的位置
  List<List<bool>> placeBingo(List<List<bool>> b, List<List<int>> al) {
    Xy nowBingo;
    List<List<bool>> res = List.from(b);
    for (var a in al) {
      nowBingo = checkBingo(res);
      for (var d in [
        [0, 0],
        [0, 1],
        [0, -1],
        [1, 0],
        [-1, 0]
      ]) {
        var tx = a[0] + d[0];
        var ty = a[1] + d[1];
        if (0 <= tx && tx < 5 && 0 <= ty && ty < 5) {
          if (!isRed(nowBingo, tx, ty)) {
            res[tx][ty] = !res[tx][ty];
          }
        }
      }
    }
    return res;
  }

  List<num> scorePlace(b, List<List<int>> bfsq) {
    List<num> res = [0, 0, 0, 0];
    Xy nowBingo = checkBingo(b);
    for (var s = 0; s < bfsq.length; s++) {
      int tx = bfsq[s][0];
      int ty = bfsq[s][1];
      if (!isRed(nowBingo, tx, ty)) res[0] += 1;
      if (!isSkull(b, tx, ty)) {
        res[1] = res[1] + isc[tx][ty];
      }
      ;
      if (!isRed(nowBingo, tx, ty)) {
        for (var d in [
          [1, 0],
          [-1, 0],
          [0, 1],
          [0, -1]
        ]) {
          int nx = (tx + d[0]).toInt();
          int ny = ty + d[1];
          if (0 <= nx && nx < 5 && 0 <= ny && ny < 5) {
            if ((!check[nx][ny]) && (!isRed(nowBingo, nx, ny))) {
              check[nx][ny] = true;
              List<List<int>> newBfsq = bfsq;
              newBfsq.add([nx, ny]);
              scorePlace(b, newBfsq);
            }
          }
        }
      }
    }
    for (var i in [0, 1, 2, 3, 4]) {
      for (var j in [0, 1, 2, 3, 4]) {
        if (!isRed(nowBingo, i, j)) res[2] += 1;
        if (!isSkull(b, i, j)) res[3] += isc[i][j];
      }
    }
    return res;
  }

  List<Score> scoreThird(al) {
    List<Score> res = [];
    // 3빙고, 빨강, 가용, 빈가용, 해골, 총, 총빈
    List<List<bool>> nowPlace = placeBingo(bingo[round.toInt()], al);
    Xy nowBingo = checkBingo(nowPlace);
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        List<num> score = [0, 0, 0, 0, 0, 0, 0];
        List<List<bool>> testPlace = placeBingo(nowPlace, [
          [i, j]
        ]);
        Xy testBingo = checkBingo(testPlace);
        if (!isHellOver(testPlace)) {
          if (nowBingo.toString() != testBingo.toString()) score[0] = 1;
          if (!isRed(nowBingo, i, j)) score[1] = 1;
          if (!isSkull(nowPlace, i, j)) score[4] = 1;
          if (isIsolate(nowPlace, i, j) == 8) score[4] = 0;
          List<num> sp = scorePlace(testPlace, [
            [1, 1]
          ]);
          score[2] = sp[0];
          score[3] = sp[1];
          score[5] = sp[2];
          score[6] = sp[3];
        }
        num sc = 0;
        for (var k = 0; k < 7; k++) sc += score[k] * scoreWeight[k];
        res.add(Score(score: sc, x: i, y: j));
      }
    }
    return res;
  }

  List<Score> scoreSecond(List<List<int>> al) {
    List<Score> res = [];
    List<List<bool>> nowPlace = placeBingo(bingo[round], al);
    Xy nowBingo = checkBingo(nowPlace);
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        List<num> score = [0, 0, 0, 0, 0, 0, 0];

        List<List<bool>> testPlace = placeBingo(nowPlace, [
          [i, j]
        ]);
        // if (!isHellOver(testPlace)) {
        //   if (!isRed(nowBingo, i, j)) score[0] = 1;
        //   if (!isSkull(nowPlace, i, j)) score[3] = 1;
        //   if (isIsolate(nowPlace, i, j) == 8) score[3] = 0;
        //   List<num> sp = scorePlace(testPlace);
        //   score[1] = sp[0];
        //   score[2] = sp[1];
        //   score[4] = sp[2];
        //   score[5] = sp[3];
        // }
        // num sc = 0;
        // for (var k = 0; k < 7; k++) sc += score[k] * scoreWeight[k];

        // num maxScore = 0;
        // scoreThird([
        //   ...al,
        //   [i, j]
        // ]).forEach((element) {
        //   max(element.score, maxScore);
        // });
        // num scThird = isHellOver(testPlace) ? 0 : maxScore;
        // res.add(Score(x: i, y: j, score: sc + scThird));
      }
    }
    return res;
  }

  List<Score> scoreFirst() {
    List<Score> res = [];
    // 빨강, 가용, 빈가용, 해골, 총, 총빈
    List<List<bool>> nowPlace = bingo[round];
    Xy nowBingo = checkBingo(nowPlace);
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        List<num> score = [0, 0, 0, 0, 0, 0, 0];
        List<List<bool>> testPlace = placeBingo(nowPlace, [
          [i, j]
        ]);
        if (!isHellOver(testPlace)) {
          if (!isRed(nowBingo, i, j)) score[0] = 1;
          if (!isSkull(nowPlace, i, j)) score[3] = 1;
          if (isIsolate(nowPlace, i, j) == 8) score[3] = 0;
          List<num> sp = scorePlace(testPlace, [
            [1, 1]
          ]);
          score[1] = sp[0];
          score[2] = sp[1];
          score[4] = sp[2];
          score[5] = sp[3];
        }
        num sc = 0;
        for (var k = 0; k < 6; k++) sc += score[k] * scoreWeight[k + 1];
        num scSecond = 0;
        scoreThird([
          [i, j]
        ]).forEach((element) {
          max(element.score, scSecond);
        });

        res.add(Score(x: i, y: j, score: sc + scSecond));
      }
    }

    return res;
  }

  ///候选炸弹位置
  List<List<num>> candidateList() {
    List<List<num>> res = [];
    List<Score> score = [];

    if (round % 3 == 2) {
      // score = scoreFirst();
    } else if (round % 3 == 0) {
      // score = scoreSecond([]);
    } else {
      // score = scoreThird([]);
    }
    // if (!isInanna) {
    //   score = score.where((element) => element.score > 1e10).toList();
    // }

    // if (isInanna) {
    //   score.sort(((x, y) => ((y.score % 1e10) - (x.score % 1e10)).toInt()));
    // } else {
    //   score.sort((x, y) => (y.score - x.score).toInt());
    // }

    // if (score.isNotEmpty) res.add([score[0].x, score[0].y]);
    // if (score.length > 1) res.add([score[1].x, score[1].y]);

    // if (score.length > 2) {
    //   if (isSkull(bingo[round], score[0].x.toInt(), score[0].y.toInt()) &&
    //       isSkull(bingo[round], score[1].x.toInt(), score[1].y.toInt())) {
    //     List<Score> empt = score
    //         .where((element) =>
    //             !isSkull(bingo[round], element.x.toInt(), element.y.toInt()))
    //         .toList();
    //     if (empt.isNotEmpty) {
    //       res.add([empt[0].x, empt[0].y]);
    //     } else {
    //       res.add([score[2].x, score[2].y]);
    //     }
    //   } else {
    //     res.add([score[2].x, score[2].y]);
    //   }
    // }
    return res;
  }

  Color? boxBg(i, j) {
    List<List<num>> candi = candidateList();

    if (round > 1) {
      if (candi.isNotEmpty && i == candi[0][0] && j == candi[0][1])
        Color(0x0000FF);
      else if (candi.length > 1 && i == candi[1][0] && j == candi[1][1])
        Color(0x8888FF);
      else if (candi.length > 2 && i == candi[2][0] && j == candi[2][1])
        Color(0xCCCCFF);
    }
    return Colors.white;
  }

  DecorationImage? boxBgImg(i, j) {
    Xy nowBingo = checkBingo(bingo[round]);
    if (round != 0 && i == hellPos[0] && j == hellPos[1]) {
      return DecorationImage(
        fit: BoxFit.fill,
        alignment: Alignment.center,
        opacity: 0.8,
        image: AssetImage('images/bingo/hellskull.png'),
      );
    } else if (isRed(nowBingo, i, j) == true) {
      return DecorationImage(
        fit: BoxFit.fill,
        alignment: Alignment.center,
        opacity: 0.8,
        image: AssetImage('images/bingo/redskull.png'),
      );
    } else if (bingo[round][i][j]) {
      return DecorationImage(
        fit: BoxFit.fill,
        alignment: Alignment.center,
        opacity: 0.8,
        image: AssetImage('images/bingo/skull.png'),
      );
    }
    return null;
  }

  ///func
  void handleInanna(bool e) {
    isInanna = e;
    notifyListeners();
  }

  void handleHell(bool e) {
    isHell = e;
    notifyListeners();
  }

  void handlePreferSkull(num e) {
    preferSkull = e;
    scoreWeight = [1e10, 2e9, 1e7, 5e4, 5e4 * 10 * e + 1e4, 100, 1];
    notifyListeners();
  }

  int transNum(x) {
    return x;
  }

  void transDoubleNum(x) {
    if (x.length < 2) return;
    if (x.length == 2)
      return clickBingo(transNum(x[0]) - 1, transNum(x[1]) - 1);
    if (x.split("십").length == 2)
      return clickBingo(
          transNum(x.split("십")[0]) - 1, transNum(x.split("십")[1]) - 1);
    if (transNum(x[0]) > 0)
      return clickBingo(transNum(x[0]) - 1, transNum(x.slice(1, x.length)) - 1);
    if (transNum(x.slice(0, 2)) > 0)
      return clickBingo(
          transNum(x.slice(0, 2)) - 1, transNum(x.slice(2, x.length)) - 1);
    return;
  }

  ///放置炸弹
  void clickBingo(x, y) {
    if (x < 0 || x >= 5 || y < 0 || y >= 5) return;
    if (isHell && round == 0) {
      List<List<List<bool>>> res = bingo.sublist(0, round + 1);
      res.add(bingo[round]);
      hellPos = [x, y];
      bingo = res;
      round += 1;
    } else if (round < 2) {
      List<List<List<bool>>> res = bingo.sublist(0, round + 1);
      if (isSkull(res[round], x, y)) {
        warnMsg = "不能把头骨放在那里";
      } else {
        res.add(bingo[round]);
        res[round + 1][x][y] = true;
        bingo = res;
        round += 1;
        if (warnMsg != "") warnMsg = "";
      }
    } else {
      if (round % 3 == 1 && isInanna) isInanna = false;
      List<List<List<bool>>> res = bingo.sublist(0, round + 1);
      res.add(placeBingo(bingo[round], [
        [x, y]
      ]));
      bingo = res;
      round += 1;
      if (warnMsg != "") warnMsg = "";
    }
    notifyListeners();
  }

  ///重置
  void resetBingo() {
    if (warnMsg != "") warnMsg = "";
    round = 0;
    bingo = [
      [
        [false, false, false, false, false],
        [false, false, false, false, false],
        [false, false, false, false, false],
        [false, false, false, false, false],
        [false, false, false, false, false],
      ]
    ];
    isInanna = false;
    hellPos = [-1, -1];
    notifyListeners();
  }

  ///后退
  void cancleBingo() {
    if (warnMsg != "") warnMsg = "";
    if (round > 0) round -= 1;
    notifyListeners();
  }
}
