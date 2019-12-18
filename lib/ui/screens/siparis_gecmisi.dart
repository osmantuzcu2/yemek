
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
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';
import 'package:http/http.dart' as http;
class OrderHistory extends StatefulWidget {
  OrderHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<OrderStatus> data = List<OrderStatus>();
  _getOrderHistory() {
    Future getOrderHistory() {
      var url = Constants.generalBaseUrl + '/api/orders.php?process=getid_orderstatus&userId='+Cookie.of(context).user_id;
      return http.get(url);
    }

    getOrderHistory().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        data =
            list.map((model) => OrderStatus.fromJson(model)).toList();
        var boddy = json.decode(response.body);
        if (boddy[0]['status'] == 'true') {
          
          
        }
      });
    });
  }
  @override
  void initState() {
    super.initState();
   
  }
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => exit(context)
        ) ??
        false;
  }
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool exp_icon =true;
  Widget build(BuildContext context) {
    _getOrderHistory();
    return WillPopScope(
      onWillPop: _onWillPop,
          child: Scaffold(
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
                    background: appBarProfile(context, false,'https://tinyfac.es/data/avatars/475605E3-69C5-4D2B-8727-61B7BB8C4699-500w.jpeg')
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
                              Text('865 Puan',style: TextStyle(color: Colors.yellow[700],),)
                            ],),
                          
                            ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        leading: Icon(
                         exp_icon == true ? Icons.add : Icons.close,
                          color: green1,
                        ),
                        onExpansionChanged: (val){
                          if (val==true) {
                            setState(() {
                              this.exp_icon =false;
                            });
                          }else{

                            setState(() {
                              this.exp_icon =true;
                            });
                          }
                        },
                        title: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    data[index].orderDate==null?'':data[index].orderDate,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                               
                                Expanded(
                                    flex: 1,
                                    child: Text("€ "+data[index].totalAmount==null?'':data[index].totalAmount,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14))),
                                
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Sipariş Durumu',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    data[index].orderStatus,
                                    
                                    style: TextStyle(fontSize: 12,
                                    color: data[index].orderStatus == 'Tamamlandı'? green1 : Colors.yellow[700]
                                    ),
                                  ),
                                ),
                                 Expanded(
                                    flex: 1,
                                    child: Icon(Icons.star,color: Colors.yellow[700],size: 16,),
                                  ),
                                Expanded(
                                    flex: 2,
                                    child: Text('',
                                        style: TextStyle( fontSize: 14,color: Colors.yellow[700]))),
                                
                              ],
                            ),
                          ],
                        ),

                        trailing: Text(''),
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                              left: screenW(0.1, context), 
                              right: screenW(0.05, context), 
                              bottom: 5,

                              ),
                              child: Container(
                                child:Column(
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Expanded(flex:4,
                                      child: Text('- Chicken Menu'),
                                      ),
                                      Expanded(flex: 1,
                                      child: Text('€ 11'),
                                      )
                                    ],),
                                    Row(children: <Widget>[
                                      Expanded(flex:4,
                                      child: Text('- Chicken Menu'),
                                      ),
                                      Expanded(flex: 1,
                                      child: Text('€ 11'),
                                      )
                                    ],),
                                    Row(children: <Widget>[
                                      Expanded(flex:4,
                                      child: Text('- Chicken Menu'),
                                      ),
                                      Expanded(flex: 1,
                                      child: Text('€ 11'),
                                      )
                                    ],),
                                    Row(children: <Widget>[
                                      Expanded(flex:4,
                                      child: Text('- Chicken Menu'),
                                      ),
                                      Expanded(flex: 1,
                                      child: Text('€ 11'),
                                      )
                                    ],),
                                  ],
                                )
                              )
                              
                              )
                        ],
                      );
                    },
                  ),
                  
                          
                          
                          ],
                        ),
            ),
                    
                  ),
         )
              
           
      )
      ),
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


class OrderStatus {
    String address;
    String foodDetailName;
    String foodDetailAmount;
    String sumExtras;
    String totalAmount;
    String discountAmount;
    String orderTypeDescription;
    String orderStatus;
    String orderDate;

    OrderStatus({
        this.address,
        this.foodDetailName,
        this.foodDetailAmount,
        this.sumExtras,
        this.totalAmount,
        this.discountAmount,
        this.orderTypeDescription,
        this.orderStatus,
        this.orderDate,
    });

    factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        address: json["address"],
        foodDetailName: json["food_detail_name"],
        foodDetailAmount: json["food_detail_amount"],
        sumExtras: json["sum_extras"],
        totalAmount: json["totalAmount"],
        discountAmount: json["discount_amount"],
        orderTypeDescription: json["orderType_description"],
        orderStatus: json["order_status"],
        orderDate: json["orderDate"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "food_detail_name": foodDetailName,
        "food_detail_amount": foodDetailAmount,
        "sum_extras": sumExtras,
        "totalAmount": totalAmount,
        "discount_amount": discountAmount,
        "orderType_description": orderTypeDescription,
        "order_status": orderStatus,
        "orderDate": orderDate,
    };
}
