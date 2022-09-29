/*
 * @Author: wesion
 * @Date: 2022-09-17 16:59:39
 * @LastEditTime: 2022-09-29 16:55:35
 * @Description: 
 */
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:lost_ark/common/my_drawer.dart';
import 'package:lost_ark/page/clown_bingo/clown_bingo_page.dart';
import 'package:lost_ark/page/image_page/image_page.dart';
import 'package:lost_ark/page/power_stone/power_stone.dart';
import 'package:provider/provider.dart';

import 'page/engraved/engraved_page.dart';
import 'provider/menuCounter.dart';

class PageModel {
  String title;
  Widget page;
  PageModel({required this.title, required this.page});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<PageModel> titleArr = [
      PageModel(title: "配铭刻", page: EngravedPage()),
      PageModel(title: "敲石头", page: PowerStone()),
      PageModel(title: "小丑bingo", page: ClownBingoPage()),
      PageModel(title: "魅魔", page: ImagePage(img: "images/meimo/meimo_p1.png")),
      PageModel(
          title: "小丑",
          page: ImagePage(img: "images/xiaochou/xiaochou_game4.png"))
    ];
    return Scaffold(
      appBar: PreferredSize(
          child: MoveWindow(
            child: Container(
              color: Colors.red,
              child: Center(child: Text("lostark")),
            ),
          ),
          preferredSize: Size(500, 50)),
      drawer: MyDrawer(
        titleArr: titleArr,
      ),
      body: titleArr[context.watch<MenuCounter>().pageNum].page,
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: '菜单',
          child: const Icon(Icons.menu),
        );
      }),
    );
  }
}
