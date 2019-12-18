// styles
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mc_jsi/core/functions.dart';

const thin1 =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w100, fontSize: 12);
const normal =
    TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14);
const thick1 =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 13);

Widget fireSvg(double ht, String label, String path) {
  return new SvgPicture.asset(path, height: ht, semanticsLabel: label);
}
Widget fireSvgwidth(double wt, String label, String path) {
  return new SvgPicture.asset(path, width: wt, semanticsLabel: label);
}
Widget fireSvgwidthColor(double wt, String label, String path,Color color) {
  return new SvgPicture.asset(path, width: wt, semanticsLabel: label,color: color,);
}
Widget hata(String label, String path,context){
  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      fireSvgwidth(screenW(0.5, context), '', path),
                      Container(height: screenH(0.02, context),),
                      Container(
                        padding: EdgeInsets.only(left: screenW(0.1, context),
                        right: screenW(0.1, context),
                        ),
                        child: Text(label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 16,
                          
                        ),
                        )
                      )
                    ],));
}
//exit
Widget exit(context){
  return  AlertDialog(
            title: new Text('Emin misiniz?'),
            content: new Text('Uygulamadan çıkmak istiyor musun?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Hayır'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Evet'),
              ),
            ],
          );
        
}