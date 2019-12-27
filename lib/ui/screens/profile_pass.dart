
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/widgets.dart/appbar.dart';
import 'package:mc_jsi/ui/widgets.dart/blue_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/green_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/profile_appbar.dart';
import 'package:http/http.dart' as http;
class Password extends StatefulWidget {
  Password({Key key}) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  var mevcutText = TextEditingController();
  var yeniText = TextEditingController();
  var yeniText2 = TextEditingController();
  Future<void> change_password() async {
    if (mevcutText.text == "" || yeniText.text==""||yeniText2.text=="") {
     
      toast('EKSIK_BILGI');
    } else {
       var url = Constants.generalBaseUrl + '/api/user.php';
      print(url);
      var data = await http.post(url, body: {
        "process":"up_Password",
        "id":Cookie.of(context).user_id,
        "oldPassword":mevcutText.text,
        "password":yeniText.text,
        "newPassword":yeniText2.text,
                
        });
      print(data.body);
      if (data.statusCode == 200) {
        var boddy = json.decode(data.body);
        print('boddy:' + boddy.toString());
        if (!boddy.isEmpty) {
          var ret = boddy[0];
          print(ret);
          if (ret['status'] == 'true') {
            toast(ret['message']);
          } else {
            toast(ret['message']);
          }
        }
      }
    }
  }
  @override
  void initState() {
    super.initState();
   
  }
  @override
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomMenu(context,_scaffoldKey),
      backgroundColor: Colors.white,
      key:_scaffoldKey,
      endDrawer: drawer(context),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                new Container(),
              ],
              leading: Container(),
              brightness: Brightness.dark,
              expandedHeight: screenH(0.3, context),
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(0),
                  background: appBarProfile(context, true,'https://tinyfac.es/data/avatars/475605E3-69C5-4D2B-8727-61B7BB8C4699-500w.jpeg')
                  ),
            ),
            
          ];
        },
        
      body: 
    
       Center(
        child:Container(
          padding: EdgeInsets.only(
            left: screenW(0.05, context),
            right: screenW(0.05, context),
          ),
          child: Column(
            children: <Widget>[
                        
                        Text(Cookie.of(context).userNameLastname.toUpperCase()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Icon(Icons.star,color: Colors.yellow[700],),
                          Text('865 Puan',style: TextStyle(color: Colors.yellow[700],),)
                        ],),
                      
                        Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.vpn_key,
                                color: grey1,
                              )),
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                              controller: mevcutText,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Mevcut Parola';
                                }
                                return null;
                              },
                              decoration: input('Mevcut Parola ', 'Parola giriniz'),
                              onSaved: (String value) {
                                print("Value : $value");
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.vpn_key,
                                color: grey1,
                              )),
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                              controller: yeniText,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Yeni Parola';
                                }
                                return null;
                              },
                              decoration: input('Yeni Parola ', 'Yeni Parola giriniz'),
                              onSaved: (String value) {
                                print("Value : $value");
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.vpn_key,
                                color: grey1,
                              )),
                          Expanded(
                            flex: 8,
                            child: TextFormField(
                              controller: yeniText2,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Yeni Parola';
                                }
                                return null;
                              },
                              decoration: input('Yeni Parola ', 'Yeni Parola giriniz'),
                              onSaved: (String value) {
                                print("Value : $value");
                              },
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          change_password();
                        },
                                              child: Container(
                          width: double.infinity,
                          height: screenH(0.08, context),
                          margin: EdgeInsets.only(
                            top: screenW(0.05, context),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                            10
                            ),
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300],
                                  blurRadius: 10.0, 

                                  offset: Offset(
                                    1.0, // horizontal, move right 10
                                    1.0, // vertical, move down 10
                                  ),
                                ),
                              ],
                          ),
                          child: Text('GÜNCELLE',
                          style: TextStyle(color:green1),
                          )),
                      )
                      
                      
                      ],
                    ),
        ),
                
              )
            
         
    )
    );
  }
}

InputDecoration input(label, hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(2),
    labelText: label,
    labelStyle: TextStyle(
      color: grey1,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    hintStyle: TextStyle(
      color: grey1,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    hintText: hint,
    focusedBorder: new UnderlineInputBorder(
      borderSide: new BorderSide(color: blue1),
    ),
    fillColor: Colors.white,
  );
}

class Foods {
  final title;
  final asset;
  Foods({this.title,this.asset});
}