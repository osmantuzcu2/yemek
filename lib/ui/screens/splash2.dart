import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/screens/home.dart';
import 'package:mc_jsi/ui/screens/register.dart';
import 'package:mc_jsi/ui/screens/splash.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';
import 'package:mc_jsi/core/inh.dart';
import 'package:http/http.dart' as http;

class Splash2 extends StatefulWidget {
  Splash2({Key key}) : super(key: key);

  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  _getUser(String user_id) {
    Future getUser() {
      var url = Constants.generalBaseUrl + '/api/user.php?process=getid_user&userId='+user_id;
      return http.get(url);
    }

    getUser().then((response) {
      setState(() {
        var boddy = json.decode(response.body);
        if (boddy[0]['status'] == 'true') {
            var ret = boddy[0];
            Cookie.of(context).setUserId(ret['id']);
            Cookie.of(context).setUserNameLastname(ret['name']+" "+ret['lastname']);
            Cookie.of(context).setUserName(ret['name']);
            Cookie.of(context).setUserLastname(ret['lastname']);
            Cookie.of(context).setUserAvatar(ret['avatar']);
            Future.delayed(const Duration(seconds: 2), () {
               Navigator.pushAndRemoveUntil(context, 
               MaterialPageRoute(builder: (context)=>Home()), 
                            (Route<dynamic> route) => false
                            );
    });
          
        }
      });
    });
  }
  Future isuserLoggedin(context) async {
  var val = await getUserIdPref();
  if (val == null) {
    
    Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Register()), 
                            (Route<dynamic> route) => false
                            );
    });
  } else {
    _getUser(val);
  }
}

Future<bool> checkConnection(context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
     
      isuserLoggedin(context);
    } else {
      
    }
  } on SocketException catch (_) {
    
    Alert(
      context: context,
      title: "CONNECTION PROBLEM",
      desc: "Please check your internet connection",
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Splash1()));
          },
          color: Colors.blue,
          child: Text('Check Again'),
        ),
      ],
    ).show();
  }
}
  @override
  void initState() { 
    super.initState();
    checkConnection(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       width: screenW(1, context),
        height: screenH(1, context),
        padding: EdgeInsets.only(
          left: screenW(0.25, context),
          right:screenW(0.25, context)
        ),
        color: Colors.white,
       child: GestureDetector(
         onTap: (){
           Navigator.pushNamed(context, Constants.ROUTE_REGISTER);
         },
         child: Hero(
           tag: 'logo',
           child: Image.asset('assets/logo2.png')))
    );
  }
}