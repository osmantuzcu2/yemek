import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/screens/calendar.dart';
import 'package:mc_jsi/ui/screens/calendar2.dart';
import 'package:mc_jsi/ui/screens/contact.dart';
import 'package:mc_jsi/ui/screens/register.dart';
import 'package:mc_jsi/ui/screens/siparis_gecmisi.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';

Widget drawer(context) {
  return SizedBox(
          width: screenW(0.6, context),
          child: Drawer(
              child: Container(
            height: screenH(1, context),
            width: screenW(0.6, context),
            child: Column(
              children: <Widget>[
                Container(
                  height: screenH(0.3, context),
                  decoration: new BoxDecoration(
                    color: Colors.lightBlue,
                    image: new DecorationImage(
                      image: 
                      Cookie.of(context).userAvatarUrl== null?
                      AssetImage('assets/profile.png'):
                      NetworkImage(
                        Constants.generalBaseUrl + Cookie.of(context).userAvatarUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(0.6)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          
                          Container(
               width: screenW(0.25, context),
               height: screenW(0.25, context),
               alignment: Alignment.center,
                  padding: EdgeInsets.only(top: screenH(0.20, context)),
               decoration: new BoxDecoration(
                 color: green1,
                 image: new DecorationImage(
                   image: 
                      Cookie.of(context).userAvatarUrl== null?
                      AssetImage('assets/profile.png'):
                      new NetworkImage(
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
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              Cookie.of(context).userNameLastname==null?'':
                              Cookie.of(context).userNameLastname.toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.star, color: Colors.yellow[700]),
                                Text(
                                  '865 Puan',
                                  style: TextStyle(color: Colors.yellow[700]),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenH(0.62, context),
                  padding: EdgeInsets.only(right: 10, top: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                           builder: (context) => OrderHistory()
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Sipariş Geçmişi',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Icon(Icons.history, color: Colors.grey[700]),
                          ],
                        ),
                      ),
                      
                      Container(height: screenH(0.01, context),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                           builder: (context) => CalendarScreen2()
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Takvim',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Icon(Icons.calendar_today, color: Colors.grey[700]),
                          ],
                        ),
                      ),
                      Container(height: screenH(0.01, context),),
                     GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                           builder: (context) => Contact()
                          ));
                        },
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: <Widget>[
                           Text(
                             'Contact',
                             style: TextStyle(color: Colors.grey[700]),
                           ),
                           Icon(Icons.help, color: Colors.grey[700]),
                         ],
                       ),
                     ),
                    ]
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setUserIdPref(null, null, null);
                    Cookie.of(context).setUserId(null);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Register()), 
                                          (Route<dynamic> route) => false
                                          );
                  },
                  child: Container(
                    color : red1,
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: screenH(0.08, context),
                    child: Text('Çıkış Yap',
                    style: TextStyle(color: Colors.white),
                    
                    ),
                  )
                )
              ],
            ),
          )))
      ;
}
