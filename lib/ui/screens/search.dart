import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/screens/product_details.dart';
import 'package:mc_jsi/ui/screens/product_list.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/white_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}
class _SearchState extends State<Search> {
var searchText = TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => exit(context)
        ) ??
        false;
  }
  @override
  Widget build(BuildContext context) {
    return 
        WillPopScope(
      onWillPop: _onWillPop,
                  child: Scaffold(
            key: _scaffoldKey,
           endDrawer: drawer(context),
           body: Stack(
             children: <Widget>[
               Container(
                    width: screenW(1, context),
                    height: screenH(1, context),
                   decoration: new BoxDecoration(
                      color: Colors.black,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                        image: new AssetImage(
                          'assets/background.jpg',
                        ),
                      ),
                   ),
                   child: Stack(children: [
          
          
          Container(
            padding: EdgeInsets.only(top: screenH(1, context) >= 812.0 ? 16:0),
                  alignment: Alignment.topCenter,
                  child: fireSvg(screenH(0.12, context), '', 'assets/ribbon.svg')),
          Container(
                  child: Column(children: [
                Container(
                  width: screenW(1, context),
                  padding: EdgeInsets.only(top: screenH(0.07, context)),
                  alignment: Alignment.centerRight,
                  child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(flex: 7, child: Container()),
                        Expanded(
                          flex: 3,
                          child: userband(context),
                        ),
                      ],
                    ),
                   ),
                Container(
                  height: screenH(0.2, context),
                ),
                Container(
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
                    
                ),

       
          ])),
      ]),
                    
                ),
             Align(
               alignment: Alignment.bottomCenter,
               child: bottomMenu(context,_scaffoldKey)
             )
             ],
           ),
          ),
        );
  }
}