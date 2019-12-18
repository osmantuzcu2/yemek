import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';

Widget greenbar(context){
 return Container(
              color: green1,
              height: screenH(0.06, context),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 1,
                  child: fireSvgwidth(screenW(0.05,context), '', 'assets/ribbon_white.svg'),
                  ),
                  Expanded(flex: 5,
                  child: Container(
                    padding: EdgeInsets.only(
                      right: screenW(0.2, context),
                      left: screenW(0.2, context)),
                    ),
                  ),
                ],
              ),
            );
}