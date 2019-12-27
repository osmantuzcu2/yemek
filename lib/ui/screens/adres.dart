
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/screens/sepet.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/profile_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
class Address extends StatefulWidget {
  Address({Key key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  List<AddressClass> data = List<AddressClass>();
  var adressInputN = TextEditingController();
  var adressInputA = TextEditingController();
  @override
  void initState() {
    super.initState();
  
  }
  _getAddresses() {
    Future getAddresses() {
      var url = Constants.generalBaseUrl + '/api/address.php';
      return http.post(url, body: {
        "process": "getid_address",
        "user_id": Cookie.of(context).user_id
      });
    }

    getAddresses().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        data =
            list.map((model) => AddressClass.fromJson(model)).toList();
        var boddy = json.decode(response.body);
        if (boddy[0]['status'] == 'true') {
          
          
        }
      });
    });
  }
  _updateAddress(String id) {
    if (Cookie.of(context).user_id != null) {
      Future updateAddress() {
        var url = Constants.generalBaseUrl + '/api/address.php';
        return http.post(url, body: {
          "process": "up_address",
          "id":id,
          "user_id": Cookie.of(context).user_id,
          "name": adressInputN.text,
          "address": adressInputA.text,
        });
      }

      updateAddress().then((response) {
        setState(() {
          var boddy = json.decode(response.body);
          if (boddy[0]['status'] == 'true') {
            setState(() {
              _getAddresses();
            });
            Navigator.pop(context);
          }
        });
      });
    } else {
      toast('no userid');
    }
  }
  @override
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool exp_icon =true;
  Widget build(BuildContext context) {
    _getAddresses();
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
                  background: appBarProfile(context, true,Cookie.of(context).userAvatarUrl)
                  ),
            ),
            
          ];
        },
        
      body: 
    
       SingleChildScrollView(
                child: Center(
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
                          ],),
                        
                          ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      
                      
                      title: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                           Row(
                             children: [
                               Text(data[index].name,style: TextStyle(fontWeight: FontWeight.w700),),
                             FlatButton(
                          onPressed: (){
                            adressInputN.text=data[index].name;
                            adressInputA.text=data[index].address;

                            showModalBottomSheet<void>(
                                                isScrollControlled: true,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Padding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child: Container(
                                                          child: Wrap(
                                                        children: <Widget>[
                                                          Container(
                                                            height: 40,
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: TextField(
                                                                decoration:
                                                                    InputDecoration(
                                                                        hintText:
                                                                            'Adresse Name'),
                                                                controller:
                                                                    adressInputN),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: TextField(
                                                                decoration:
                                                                    InputDecoration(
                                                                        hintText:
                                                                            'Deine Adresse'),
                                                                controller:
                                                                    adressInputA),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: DialogButton(
                                                              child: Text(
                                                                'ERLEDIGT',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              onPressed: () {
                                                                _updateAddress(data[index].id);
                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      )));
                                                },
                                              );
                          },
                          child: Text('Bearbeiten',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                            color: Colors.yellow[800]
                          ),
                          ),
                        ),
                         FlatButton(
                          onPressed: (){},
                          child: Text('löschen',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                            color: Colors.red
                          ),
                          ),
                        ),
                             ]
                           ),
                            Text(data[index].address+data[index].id,
                            style: TextStyle(fontSize: 12),
                            ),
                            

                          ],
                        ),
                      )

                     );
                  },
                ),
                
                        
                        
                        ],
                      ),
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

class Addresses {
  final title;
  final address;
  Addresses({this.title,this.address});
}