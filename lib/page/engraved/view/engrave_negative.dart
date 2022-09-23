/*
 * @Author: wesion
 * @Date: 2022-09-21 10:47:43
 * @LastEditTime: 2022-09-23 11:23:46
 * @Description: 
 */
import 'package:flutter/material.dart';
import 'package:lost_ark/common/my_color.dart';
import 'package:lost_ark/provider/engraved_provider/model/engraved_model.dart';
import 'package:provider/provider.dart';

import '../../../provider/engraved_provider/engraved_provider.dart';

class EngraveNegative extends StatefulWidget {
  const EngraveNegative({Key? key}) : super(key: key);

  @override
  State<EngraveNegative> createState() => _EngraveNegativeState();
}

class _EngraveNegativeState extends State<EngraveNegative> {
  EngravedPageModel comModel = EngravedPageModel();

  @override
  Widget build(BuildContext context) {
    EngravedModel model = context.read<EngravedModel>();

    return Container(
      height: 200,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[300],
            height: 50,
            child: Row(
              children: [
                Container(
                    width: 200,
                    child:
                        Center(child: Text(comModel.negativeEngraved[index]))),
                Container(
                    width: 100,
                    child: Center(
                        child: Text(
                      model.negativeEngrave[comModel.negativeEngraved[index]]
                          .toString(),
                      style: TextStyle(
                          color: model.negativeEngrave[
                                      comModel.negativeEngraved[index]] >
                                  0
                              ? MyColor.negativeColor()
                              : Colors.grey),
                    )))
              ],
            ),
          );
        },
        itemCount: comModel.negativeEngraved.length,
      ),
    );
  }
}
