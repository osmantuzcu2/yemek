import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';

class Splash1 extends StatefulWidget {
  Splash1({Key key}) : super(key: key);

  @override
  _Splash1State createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  void initState() { 
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, Constants.ROUTE_SPLASH2);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: screenW(1, context),
        height: screenH(1, context),
        padding: EdgeInsets.only(
          left: screenW(0.25, context),
          right:screenW(0.25, context)
        ),
        color: Colors.white,
         child: GestureDetector(
           onTap: (){
             Navigator.pushNamed(context, Constants.ROUTE_SPLASH2);
           },
           child: Hero(
             tag: 'logo',
             child: fireSvgwidth(screenW(0.5, context), 'label', 'assets/logo.svg')))
      ),
    );
  }
}