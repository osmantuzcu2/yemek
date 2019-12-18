import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';


Future<void> pushAndDeleteLast(context,Object page) async {
    final current = ModalRoute.of(context);
   Navigator.push(context, MaterialPageRoute(
    builder: (context) => page
   ));
    await Future.delayed(Duration(milliseconds: 1));
    Navigator.removeRoute(context, current);
  }

double screenW(double wwidth, context) {
  return MediaQuery.of(context).size.width * wwidth;
}

double screenH(double hheight, context) {
  return MediaQuery.of(context).size.height * hheight;
}

//User save SP
Future<void> setUserIdPref(
    String userId, String avatar, String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userid', userId);
  prefs.setString('avatar', avatar);
  prefs.setString('name', name);
}

//Get users id from SP
Future<String> getUserIdPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  return userid;
}

toast(String message){
  return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
}
String subb(String s,int start,int end){
  if (s.length<end) {
    return s;
  }
  else
  return s.substring(start,end);
}
Widget userband(context){
  return Container(
                          padding: EdgeInsets.only(left: 5),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex:2,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Constants.ROUTE_PROFILE);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          subb(
                                              Cookie.of(context)
                                                  .userLastname
                                                  .toUpperCase(),
                                              0,
                                              8),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 12)),
                                      Text(
                                        subb(
                                            Cookie.of(context)
                                                .userName
                                                .toUpperCase(),
                                            0,
                                            8),
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Cookie.of(context).userAvatarUrl == null
                                  ? fireSvg(screenH(0.06, context), '',
                                      'assets/profile.svg')
                                  : Expanded(
                                    flex:1,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            screenH(0.04, context)),
                                        child: new Container(
                                          width: screenW(0.07, context),
                                          height: screenW(0.07, context),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              top: 3,
                                              bottom: 3,
                                              right: 3
                                              ),
                                          decoration: new BoxDecoration(
                                            color: green1,
                                            image: new DecorationImage(
                                              image: new NetworkImage(
                                                  Constants.generalBaseUrl +
                                                      Cookie.of(context)
                                                          .userAvatarUrl),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(50.0)),
                                            
                                          ),
                                        ))
                                  )
                            ],
                          ),
                        );
}
