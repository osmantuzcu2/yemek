import 'dart:convert';
import '../../core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/screens/product_list.dart';
import 'package:mc_jsi/ui/widgets.dart/appbar.dart';
import 'package:mc_jsi/ui/widgets.dart/blue_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/green_bar.dart';

import 'gel_al.dart';
class HomeService extends StatefulWidget {
  HomeService({Key key}) : super(key: key);

  @override
  _HomeServiceState createState() => _HomeServiceState();
}

class _HomeServiceState extends State<HomeService> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
   var searchText = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getFoods();
  }
    var data = new List<Foods>();
  _getFoods() {
    Future getFoods() {
      var url = Constants.generalBaseUrl + '/api/food.php?process=getid_foods';
      return http.get(url);
    }
    getFoods().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        data = list.map((model) => Foods.fromJson(model)).toList();
        var boddy = json.decode(response.body);
        if (boddy[0]['status'] == 'true') {
         print(Constants.generalBaseUrl+boddy[0]["image"]);
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: bottomMenu(context,_scaffoldKey),
      endDrawer: drawer(context),
      body:  NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                new Container(),
              ],
              leading: Container(),
              brightness: Brightness.dark,
              expandedHeight: 180.0,
              backgroundColor: green1,
              flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(0),
                  background: appBar(context, true, 'assets/ribbon.svg',searchText)),
            ),
          ];
        },
        body: 
       SingleChildScrollView(
                child: Center(
          child:Column(
            children: <Widget>[
              greenbar(context),
              blueBar(context, 'Liefern', 'assets/service.svg'),
                Container(
                  padding:EdgeInsets.only(
                        right:screenW(0.05, context),
                        left:screenW(0.05, context)
                        ) ,
                  child: GridView.builder(
                    shrinkWrap: true,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: data.length,
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.only(
                        top:screenW(0.03, context),
                        left:screenW(0.01, context)
                        ),
                      height: 300,
                      child: InkWell(
                         onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                         builder: (context) => ProductList(id: data[index].id,dataFoods: data,search: null,)
                        ));
                      },
                        child: Column(
                          children: <Widget>[
                           Image.network(Constants.generalBaseUrl + data[index].image,
                            width: screenW(0.23, context),
                            ),
                            Text(data[index].name == null?'':data[index].name,
                            style: TextStyle(
                              fontSize: 12
                            ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                            )
                )
              
            ],
          )),
       ), 
    ));
  }
}



