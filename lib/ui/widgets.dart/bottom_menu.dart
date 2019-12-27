import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/screens/home.dart';
import 'package:mc_jsi/ui/screens/register.dart';
import 'package:mc_jsi/ui/screens/search.dart';
import 'package:mc_jsi/ui/screens/sepet.dart';
import 'package:mc_jsi/ui/screens/siparis_gecmisi.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';

Widget bottomMenu(context, GlobalKey<ScaffoldState> _scaffoldKey) {
  return Container(
    width: screenW(1, context),
    height: screenH(0.1, context),
    child: Stack(children: [
      Container(
        padding: EdgeInsets.only(top: screenH(0.03, context)),
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (Cookie.of(context).menuPosition != "0") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                        (Route<dynamic> route) => false);
                    Cookie.of(context).setMenuPosition("0");
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(screenH(0.017, context)),
                  child: fireSvgwidthColor(screenW(0.1, context), 'label',
                      'assets/menu0.svg', Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (Cookie.of(context).menuPosition != "1") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Search()),
                        (Route<dynamic> route) => false);

                    Cookie.of(context).setMenuPosition("1");
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(screenH(0.017, context)),
                  child: fireSvgwidthColor(screenW(0.1, context), 'label',
                      'assets/menu1.svg', Colors.black),
                ),
              ),
              Container(
                width: screenW(0.15, context),
              ),
              GestureDetector(
                onTap: () {
                  if (Cookie.of(context).user_id != null) {
                    if (Cookie.of(context).menuPosition != "3") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => OrderHistory()),
                        (Route<dynamic> route) => false);

                    Cookie.of(context).setMenuPosition("3");
                  }
                  }
                  
                      else{
                        toast("Bitte registrieren Sie sich zuerst");
                        Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Register()), 
                                              (Route<dynamic> route) => false
                                              );
                        });
                      }
                  
                },
                child: Container(
                  padding: EdgeInsets.all(screenH(0.02, context)),
                  child: fireSvgwidthColor(screenW(0.1, context), 'label',
                      'assets/menu3.svg', Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (Cookie.of(context).user_id != null) {
                    
                  _scaffoldKey.currentState.openEndDrawer();
                  }
                  else{
                        toast("Bitte registrieren Sie sich zuerst");
                        Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Register()), 
                                              (Route<dynamic> route) => false
                                              );
                        });
                      }
                  },
                child: Container(
                  padding: EdgeInsets.all(screenH(0.022, context)),
                  child: fireSvgwidthColor(screenW(0.1, context), 'label',
                      'assets/menu4.svg', Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      Align(
          alignment: Alignment.center,
          child: Badge(
              showBadge: Cookie.of(context).showBadge,
              badgeContent: Text(
                Cookie.of(context).orderNumber.toString(),
                style: TextStyle(color: Colors.white),
              ),
              badgeColor: Colors.green,
              animationType: BadgeAnimationType.scale,
              child: Container(
                width: screenW(0.15, context),
                height: screenH(0.1, context),
                child: GestureDetector(
                    onTap: () {
                      if (Cookie.of(context).user_id != null) {
                        if (Cookie.of(context).menuPosition != "2") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Basket()),
                              (Route<dynamic> route) => false);
                          Cookie.of(context).setMenuPosition("2");
                        }
                      }
                      else{
                        toast("Bitte registrieren Sie sich zuerst");
                        Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Register()), 
                                              (Route<dynamic> route) => false
                                              );
                        });
                      }
                    },
                    child: fireSvgwidth(
                        screenW(0.1, context), 'label', 'assets/menu2.svg')),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(
                          1.0, // horizontal, move right 10
                          1.0, // vertical, move down 10
                        ),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
              )))
    ]),
  );
}
