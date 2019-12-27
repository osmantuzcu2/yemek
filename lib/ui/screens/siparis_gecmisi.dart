
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
  var iconstate = List<bool>();
  List<OrderStatus> data = List<OrderStatus>();
  List<ExpandedOrder> dataExp = List<ExpandedOrder>();
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
          for (var i = 0; i < boddy.length; i++) {
            iconstate.add(false);

            var foodSplit =  data[i].foodDetailsName.split(",");
            var foodPriceSplit = data[i].foodDetailsPrice.split(",");
            var foodss = List<OrderDetail>();
            var foodPricess = List<OrderDetail>();
            for (var j = 0; j < foodSplit.length; j++) {
              foodss.add(OrderDetail(val: foodSplit[j]));
              foodPricess.add(OrderDetail(val: foodPriceSplit[j]));
            }
            foodss.add(OrderDetail(val: 'Extras'));
            foodPricess.add(OrderDetail(val: data[i].food_sum_extras));
            dataExp.add(ExpandedOrder(foods: foodss,foodsPrices: foodPricess));
             // dataExp[i].foods.add(OrderDetail(foodname: foodAdd,foodPrice: foodPriceAdd));
            
          }
          
        }
      });
    });
  }
  @override
  void initState() {
    super.initState();
    /* var foodss = List<OrderDetail>();
    var foodPricess = List<OrderDetail>();
   for (var i = 0; i < 3; i++) {
     foodss.add(OrderDetail(val: 'test'));
     foodPricess.add(OrderDetail(val: 'test'));
   }
   dataExp.add(ExpandedOrder(foods: foodss,foodsPrices: foodPricess)); */
  }
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => exit(context)
        ) ??
        false;
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
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
                    background: appBarProfile(context, false,Cookie.of(context).userAvatarUrl)
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
                      return ExpansionTile(
                        leading: Icon(
                         iconstate[index] == false ? Icons.add : Icons.close,
                          color: green1,
                        ),
                        onExpansionChanged: (val){
                          if (val==true) {
                            setState(() {
                              iconstate[index] =true;
                            });
                          }else{

                            setState(() {
                              iconstate[index] =false;
                            });
                          }
                        },
                        title: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    data[index].orderDate==null?'':data[index].orderDate,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                               
                                Expanded(
                                    flex: 2,
                                    child: Text(data[index].totalAmount==null?'':"€ "+data[index].totalAmount,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14))),
                                
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Auftragsstatus',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    data[index].orderStatus,
                                    
                                    style: TextStyle(fontSize: 12,
                                    color: data[index].orderStatus == 'fertiggestellt'? green1 : Colors.yellow[700]
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
                                
                               child: ListView.builder(
                                 shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: dataExp[index].foods.length,
                                  itemBuilder: (BuildContext context, int i) {
                                  return 
                                  Row(
                                     children: <Widget>[
                                       Expanded(
                                         flex: 5,
                                         child:
                                         Text(dataExp[index].foods[i].val),
                                       ),
                                       Expanded(
                                         flex: 2,
                                         child:
                                         Text("€" +dataExp[index].foodsPrices[i].val),
                                       )
                                     ],
                                    );
                                 },
                                ),
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
    String foodDetailsName;
    String foodDetailsPrice;
    String food_sum_extras;
    String totalAmount;
    String discountAmount;
    String orderTypeDescription;
    String orderStatus;
    String orderDate;

    OrderStatus({
        this.address,
        this.foodDetailsName,
        this.foodDetailsPrice,
        this.food_sum_extras,
        this.totalAmount,
        this.discountAmount,
        this.orderTypeDescription,
        this.orderStatus,
        this.orderDate,
    });

    factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        address: json["address"],
        foodDetailsName: json["food_details_name"],
        foodDetailsPrice: json["food_details_price"],
        food_sum_extras: json["food_sum_extras"],
        totalAmount: json["totalAmount"],
        discountAmount: json["discount_amount"],
        orderTypeDescription: json["orderType_description"],
        orderStatus: json["order_status"],
        orderDate: json["orderDate"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "food_details_name": foodDetailsName,
        "food_details_price": foodDetailsPrice,
        "food_sum_extras": food_sum_extras,
        "totalAmount": totalAmount,
        "discount_amount": discountAmount,
        "orderType_description": orderTypeDescription,
        "order_status": orderStatus,
        "orderDate": orderDate,
    };
}

class ExpandedOrder{
    List<OrderDetail> foods;
    List<OrderDetail> foodsPrices;

  ExpandedOrder({
        this.foods,
        this.foodsPrices
        });
}

class OrderDetail{
  String val;
  OrderDetail({
    this.val,
  });

}