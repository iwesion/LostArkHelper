/*
 * @Author: wesion
 * @Date: 2022-09-17 17:11:45
 * @LastEditTime: 2022-09-23 15:20:56
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';
import '../provider/menuCounter.dart';

class MyDrawer extends StatefulWidget {
  List<PageModel> titleArr;
  MyDrawer({
    Key? key,
    required this.titleArr,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView.builder(
      padding: EdgeInsets.only(top: 100),
      itemBuilder: (context, index) {
        return ListTile(
            leading: const Icon(Icons.message),
            title: Text(widget.titleArr[index].title),
            onTap: () {
              Scaffold.of(context).openEndDrawer();
              context.read<MenuCounter>().chgPageNum(index);
            });
      },
      itemCount: widget.titleArr.length,
    ));
  }
}
