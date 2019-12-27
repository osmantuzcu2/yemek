import 'dart:convert';
import 'package:easy_google_maps/easy_google_maps.dart';
import '../../core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/widgets.dart/appbar.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/green_bar.dart';
class Contact extends StatefulWidget {
  Contact({Key key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
   var searchText = TextEditingController();
   var address='';
   var tel='';
   String lat;
   String lng;
  @override
  void initState() {
    super.initState();
    _getContact();
  }

  _getContact() {
    Future getFoods() {
      var url = Constants.generalBaseUrl + '/api/contact.php?process=get_Contact';
      return http.get(url);
    }
    getFoods().then((response) {
      setState(() {
        var boddy = json.decode(response.body);
        if (boddy[0]['status'] == 'true') {
         address =boddy[0]["address"];
         tel =boddy[0]["tel"];
         lat =boddy[0]["lat"];
         lng =boddy[0]["lng"];
        }
      });
    });
  }
  @override
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
              Column(
                children: <Widget>[
                  Container(height: 20,),
                  Text('Adres :'+address,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Container(height: 10,),
                  Text('Telefon :'+tel,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  Container(height: 20,),
                  Container(height: screenH(0.4, context),
                  
                 child: EasyGoogleMaps(
                  apiKey: 'AIzaSyBgchkOfryQJ3oRrXxrwKdkeguuZv8M7gQ',
                  address: 'Potthof 8, 48301 Nottuln, Almanya',
                  title: 'Mc Jsi Restourant',

                  
              )
                  )
                ],
              )
            ],
          )),
       ), 
    ));
  }
}



