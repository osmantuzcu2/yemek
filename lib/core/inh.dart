
import 'dart:io';
import 'package:flutter/material.dart';

class _MyInherited extends InheritedWidget {
  _MyInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final CookieState data;
  
  
  @override
  bool updateShouldNotify(_MyInherited oldWidget) {
    return true;
  }
}

class Cookie extends StatefulWidget {
  Cookie({
    Key key,
    this.child,
  }): super(key: key);

  final Widget child;

  @override
  CookieState createState() => new CookieState();

  static CookieState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(_MyInherited) as _MyInherited).data;
  }
}

class CookieState extends State<Cookie> with TickerProviderStateMixin{


  
  bool showBadge=false;
  int orderNumber=0; 
  String addressId;
  String addressName;
  String user_id;
  String userNameLastname;
  String userName="";
  String userLastname="";
  String userAvatarUrl;
  String orderType; //1 gelal 2 eve servis
  String menuPosition;

  incOrderNumber(int variable){
    setState(() {
      orderNumber = orderNumber+variable;
      if (orderNumber == 0) {
        showBadge=false;
      }
      else showBadge = true;
    });
  }
  decOrderNumber(int variable){
    setState(() {
      orderNumber = orderNumber-variable;
      if (orderNumber == 0) {
        showBadge=false;
      }
      else showBadge = true;
    });
  }
  zeroOrderNumber(){
    setState(() {
      orderNumber = 0;
       showBadge = false;
    });
  }
  setAddressId(String val){
    setState(() {
      addressId=val;
    });
  }
  setAddressName(String val){
    setState(() {
      addressName=val;
    });
  }
  setUserId(String val){
    setState(() {
      user_id=val;
    });
  }
  setUserNameLastname(String val){
    setState(() {
      userNameLastname=val;
    });
  }
  setUserName(String val){
    setState(() {
      userName=val;
    });
  }
  setUserLastname(String val){
    setState(() {
      userLastname=val;
    });
  }
  
  setUserAvatar(String val){
    setState(() {
      userAvatarUrl= val;
    });
  }
  setOrderType(String val){
    setState(() {
      orderType=val;
    });
  }
  setMenuPosition(String val){
    setState(() {
      menuPosition=val;
    });
  }
  
 
  @override
  void initState() { 
    super.initState();
    
  }
  @override
  Widget build(BuildContext context){
    return new _MyInherited(
      data: this,
      child: widget.child,
    );
  }
}

