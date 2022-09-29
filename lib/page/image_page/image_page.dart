/*
 * @Author: wesion
 * @Date: 2022-09-29 16:36:37
 * @LastEditTime: 2022-09-29 16:56:10
 * @Description: 
 */
import 'dart:ui';

import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  String img;
  ImagePage({Key? key, required this.img}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Image.asset(widget.img)),
    );
  }
}
