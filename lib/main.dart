/*
 * @Author: wesion
 * @Date: 2022-09-17 16:30:23
 * @LastEditTime: 2022-09-22 18:02:13
 * @Description: 
 */

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lost_ark/home_page.dart';
import 'package:lost_ark/provider/engraved_provider/engraved_provider.dart';
import 'package:provider/provider.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'provider/menuCounter.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MenuCounter()),
    ChangeNotifierProvider(create: (context) => EngravedModel())
  ], child: MyApp()));
  doWhenWindowReady(() {
    const initialSize = Size(900, 800);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      // here
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(),
    );
  }
}
