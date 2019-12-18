import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';

Widget blueBar(context,String text,String asset){
 return Container(
   margin: EdgeInsets.only(top:screenW(0.05, context)),
    padding: EdgeInsets.all(screenW(0.04, context)),
    width: screenW(0.9, context),
    height: screenH(0.08, context),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: blue1,
    ),
    child: Row(
      children: <Widget>[
        Expanded(flex: 5,
          child: Text(text,
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),
          ),
        ),
        Expanded(flex: 1,
          child: fireSvgwidthColor(screenW(0.1, context), '', asset,Colors.white,)
        ),
      ],
    ),
  );
}