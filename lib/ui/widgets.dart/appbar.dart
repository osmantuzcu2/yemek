import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/screens/product_list.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';

Widget appBar(context, bool back,String background_picture, TextEditingController searchText) {
  return PreferredSize(
    preferredSize: Size(null, screenH(0.3, context)),
    child: Container(
      width: screenW(1, context),
      height: screenH(0.3, context),
      child: Stack(children: [
        Container(
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.navigate_before,
                  size: 40,
                  color: Colors.white,
                ),
                Text(
                  "Foodbar",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Icon(
                  Icons.navigate_before,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        Image.asset('assets/header.jpg',
        width: screenW(1, context),
        fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.only(top: screenH(1, context) >= 812.0 ? 16:0),
            alignment: Alignment.topCenter,
            child: fireSvg(screenH(0.12, context), '', background_picture)),
        Container(
            child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: screenH(0.07, context)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: back ==true? IconButton(
                    
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ):Container(),
                ),
                Expanded(flex: 7, child: Container()),
                Expanded(
                  flex: 3,
                  child: userband(context)
                   ),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(top: screenH(1, context) >= 812.0 ? 16:0),
            alignment: Alignment.topCenter,
            width: screenW(0.5, context),
            child: TextField(
              controller: searchText,
                  onEditingComplete: (){
                    Navigator.push(context, MaterialPageRoute(
                     builder: (context) => ProductList(search: searchText.text)
                    ));
                  },
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                prefixIcon: Icon(Icons.search,color: Colors.grey,),
                hintText: 'Search Food',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200),
                
              ),
              ),
              
          )
        ]))
      ]),
    ),
  );
}
Widget appBar2(context, bool back,String background_picture, TextEditingController searchText) {
  return PreferredSize(
    preferredSize: Size(null, screenH(0.3, context)),
    child: Container(
      width: screenW(1, context),
      height: screenH(0.3, context),
      child: Stack(children: [
        Container(
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.navigate_before,
                  size: 40,
                  color: Colors.white,
                ),
                Text(
                  "Foodbar",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Icon(
                  Icons.navigate_before,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
        Image.asset('assets/header.jpg',
        width: screenW(1, context),
        fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.only(top: screenH(1, context) >= 812.0 ? 16:0),
            alignment: Alignment.topCenter,
            child: fireSvg(screenH(0.12, context), '', background_picture)),
        Container(
            child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: screenH(0.07, context)),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: back ==true? IconButton(
                    
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ):Container(),
                ),
                Expanded(flex: 7, child: Container()),
                Expanded(
                  flex: 3,
                  child: userband(context)
                   ),
              ],
            ),
          ),
          Container(padding: EdgeInsets.only(top: screenH(1, context) >= 812.0 ? 16:0),
            alignment: Alignment.topCenter,
            width: screenW(0.5, context),
            child: TextField(
              controller: searchText,
                  onEditingComplete: (){
                    Navigator.push(context, MaterialPageRoute(
                     builder: (context) => ProductList(search: searchText.text)
                    ));
                  },
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                prefixIcon: Icon(Icons.search,color: Colors.grey,),
                hintText: 'Search Food',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200),
                
              ),
              ),
              
          )
        ]))
      ]),
    ),
  );
}

