import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';

Widget appBarProfile(context, bool back, String background) {
  return PreferredSize(
    preferredSize: Size(null, screenH(0.2, context)),
    child: Container(
      height: screenH(0.2, context),
      child: Stack(children: [
        //Fotos
        Stack(
          children: <Widget>[
            Container(
              width: screenW(1, context),
              height: screenH(0.25, context),
              decoration: new BoxDecoration(
                color: Colors.lightBlue,
                image: new DecorationImage(
                  image: NetworkImage(
                    Constants.generalBaseUrl+Cookie.of(context).userAvatarUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: new Container(
                  decoration:
                      new BoxDecoration(color: Colors.black.withOpacity(0.7)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
                          child: new Container(
               width: screenW(0.25, context),
               height: screenW(0.25, context),
               alignment: Alignment.center,
                  padding: EdgeInsets.only(top: screenH(0.20, context)),
               decoration: new BoxDecoration(
                 color: green1,
                 image: new DecorationImage(
                   image: new NetworkImage(
                    Constants.generalBaseUrl+Cookie.of(context).userAvatarUrl),
                   fit: BoxFit.cover,
                 ),
                 borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                 border: new Border.all(
                   color: green1,
                   width: 2.0,
                 ),
               ),
           ),
            ),
          ],
        ),
        //ribbon
        Container(padding: EdgeInsets.only(top: screenH(1, context) >= 812.0 ? 16:0),
            alignment: Alignment.topCenter,
            child: fireSvg(screenH(0.12, context), '', 'assets/ribbon.svg')),
        //person
        Container(
            child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: screenH(0.07, context)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: back == true
                      ? IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : Container(),
                ),
                Expanded(flex: 7, child: Container()),
                Expanded(
                  flex: 3,
                  child: userband(context)),
              ],
            ),
          ),
        ]))
      ]),
    ),
  );
}
