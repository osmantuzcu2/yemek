import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/dbHelper.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/widgets.dart/appbar.dart';
import 'package:mc_jsi/ui/widgets.dart/blue_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/green_bar.dart';
import 'package:http/http.dart' as http;
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Basket extends StatefulWidget {
  Basket({Key key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
   var searchText = TextEditingController();
  double totalPrice = 0;
  List<Orders> data = List<Orders>();
  List<JsonFood> food = List<JsonFood>();
  var adressInputN = TextEditingController();
  var adressInputA = TextEditingController();
  var promoCode = TextEditingController();
  var dataAddress = new List<AddressClass>();
  var widgetAdress = List<Widget>();
  var active = false;
  String addressName = '';
  String addressId;
  String addressAddress;
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
        dataAddress =
            list.map((model) => AddressClass.fromJson(model)).toList();
        var boddy = json.decode(response.body);
        if (boddy[0]['status'] == 'true') {
          widgetAdress.clear();
          for (var i = 0; i < dataAddress.length; i++) {
            widgetAdress.add(Text(boddy[i]['name']));
          }
        }
      });
    });
  }

  _addAddress() {
    if (Cookie.of(context).user_id != null) {
      Future addAddress() {
        var url = Constants.generalBaseUrl + '/api/address.php';
        return http.post(url, body: {
          "process": "add_address",
          "user_id": Cookie.of(context).user_id,
          "name": adressInputN.text,
          "address": adressInputA.text,
        });
      }

      addAddress().then((response) {
        setState(() {
          var boddy = json.decode(response.body);
          if (boddy[0]['status'] == 'true') {
            setState(() {
              addressId = boddy[0]['id'];
              addressName = adressInputN.text;
              addressAddress = adressInputN.text;
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
  getfoodsFromDB(){
    data.clear();
    food.clear();
    DbHelper().initDB();
    DbHelper().getFoods().then((d) {
      for (var i in d) {
        var list = List<FoodExtra>();
        var ext = List<JsonExtra>();
        double totalExtraPrice = 0;
        DbHelper().getExtrasByFoodId(i["foodId"]).then((v) {
          for (var item in v) {
            ext.add(JsonExtra(foodExtraId: item["extraId"]));
            list.add(
                FoodExtra(foodExtraId: item["extraId"], name: item["name"]));

            totalExtraPrice = totalExtraPrice + item["price"];
          }
          print(i["name"] + ' Extralar : ' + totalExtraPrice.toString());
          print('Ürün : ' + i["price"].toString());
          food.add(JsonFood(
              foodDetailId: i["foodId"],
              price: i["price"].toString(),
              foodExtra: ext));
          data.add(Orders(
              foodId: i["foodId"],
              name: i["name"],
              amount: i["amount"],
              price: i["price"] + totalExtraPrice,
              image: i["image"],
              foodExtra: list));
          totalPrice = totalPrice + i["price"] + totalExtraPrice;
        });
      }
      setState(() {
        data = data;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getfoodsFromDB();
  }

  _senOrder(String orderJson) {
    if (addressAddress != ''){
    Future senOrder() {
      var url = Constants.generalBaseUrl + '/api/orders.php';
      var user_id = Cookie.of(context).user_id;
      var orderType = Cookie.of(context).orderType;
      var promo = promoCode.text;
      return http.post(url, body: {
        "process": "add_orders",
        "userJson":
            '[{"userId": "$user_id","address": "$addressAddress","orderType": "$orderType","promoCodes": "$promo"}]',
        "orderJson": orderJson
      });
    }

    senOrder().then((response) {
      setState(() {
        var boddy = json.decode(response.body);
        if (boddy[0]["status"] == "true") {
          print(boddy);
          DbHelper().initDB();
          DbHelper().deleteAllFoods();
          DbHelper().deleteAllExtras();
          Cookie.of(context).zeroOrderNumber();
          active = true;
          Alert(
            context: context,
            title: '',
            desc:
                "Siparişinizi aldık. Gelişmeleri sipariş durumlarından izleyebilirsiniz.",
            buttons: [
              DialogButton(
                onPressed: () {
                  Cookie.of(context).setMenuPosition('3');
                  Navigator.pushNamed(context, Constants.ROUTE_ORDER_HISTORY);
                },
                color: Colors.blue,
                child: Text('Okey'),
              ),
            ],
          ).show();
        } else
          toast(boddy[0]["message"]);
      });
    });
  }
  else toast('Adres seçmediniz');
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => exit(context)
        ) ??
        false;
  }
  @override
  Widget build(BuildContext context) {
    if (dataAddress.isEmpty) {
      _getAddresses();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
          child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: bottomMenu(context, _scaffoldKey),
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
                expandedHeight: 180.0,
                backgroundColor: green1,
                flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.all(0),
                    background: appBar(context, false, 'assets/ribbon.svg',searchText)),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Center(
                child: Column(
              children: <Widget>[
                Container(
                  color: green1,
                  height: screenH(
                  screenH(1, context) > 800 ? 0.04 : 0.06
                    , context),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {},
                          child: fireSvgwidth(screenW(0.05, context), '',
                              'assets/ribbon_white.svg'),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builder) {
                                return Container(
                                  height: screenH(0.4, context),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                              height: screenH(0.3, context),
                                              color: Colors.white,
                                              child: CupertinoPicker(
                                                backgroundColor: Colors.white,
                                                itemExtent: 30,
                                                children: widgetAdress,
                                                onSelectedItemChanged: (int val) {
                                                  /* setState(() {
                                                          viechle = dataCars[val]
                                                              .plateNumber;
                                                          carId = dataCars[val].id;
                                                        }); */
                                                },
                                              )),
                                          Container(
                                            alignment: Alignment.topRight,
                                            child: FloatingActionButton(
                                              heroTag: 'viechle',
                                              onPressed: () {
                                                Navigator.pop(context);

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
                                                                              'Adress Name'),
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
                                                                              'Your Adress'),
                                                                  controller:
                                                                      adressInputA),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      10),
                                                              child: DialogButton(
                                                                child: Text(
                                                                  'DONE',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                onPressed: () {
                                                                  _addAddress();
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        )));
                                                  },
                                                );
                                              },
                                              child: Icon(Icons.add),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.all(10),
                                        child: DialogButton(
                                          onPressed: () {
                                            if (addressName == '') {
                                              setState(() {
                                                addressName = dataAddress[0].name;
                                                addressId = dataAddress[0].id;
                                                addressAddress = dataAddress[0].address;
                                              });
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'DONE',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  right: screenW(0.2, context),
                                  left: screenW(0.2, context)),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    addressName == ''
                                        ? 'Select Address'
                                        : addressName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
               
                  Cookie.of(context).orderType =="1"?
                  blueBar(context, 'Gel Al', 'assets/comeget.svg'):
                  Cookie.of(context).orderType =="2"?
                  blueBar(context, 'Eve Servis', 'assets/service.svg'):Container(),
                 
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        key: Key(data[index].foodId),
                        onDismissed: (direction) {
                          DbHelper().initDB();
                          DbHelper().deleteFood(data[index].foodId);
                          DbHelper().deleteExtras(data[index].foodId);
                          Cookie.of(context).zeroOrderNumber();
                          setState(() {
                            data.removeAt(index);
                            getfoodsFromDB();
                          });
                        },
                        child: ListTile(
                          title: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey))),
                            margin: EdgeInsets.only(
                                right: screenW(0.03, context),
                                left: screenW(0.03, context),
                                top: screenW(0.02, context)),
                            padding: EdgeInsets.only(
                              bottom: screenW(0.03, context),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Image.network(
                                      Constants.generalBaseUrl +
                                          data[index].image,
                                      width: 5,
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data[index].name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14)),
                                          //ekistra
                                          Container(
                                            width: double.infinity,
                                            height: screenH(0.03, context),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                primary: false,
                                                physics: ClampingScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                itemCount:
                                                    data[index].foodExtra.length,
                                                itemBuilder: (context, i) {
                                                  return Text(
                                                      data[index]
                                                              .foodExtra
                                                              .isEmpty
                                                          ? ''
                                                          : data[index]
                                                                  .foodExtra[i]
                                                                  .name +
                                                              " , ",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 12));
                                                }),
                                          ),
                                          //Text(data[index].foodExtra.isEmpty?'':data[index].foodExtra[0].name.toString()),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                "€ ",
                                                style: TextStyle(color: green1),
                                              ),
                                              Text(data[index].price.toString()),
                                            ],
                                          )
                                        ])),
                                Expanded(
                                  flex: 4,
                                  child: Text(data[index].amount.toString()),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      DbHelper().initDB();
                                      DbHelper().deleteFood(data[index].foodId);
                                      DbHelper().deleteExtras(data[index].foodId);
                                      Cookie.of(context).zeroOrderNumber();
                                      setState(() {
                                        data.removeAt(index);
                                      getfoodsFromDB();
                                      });
                                    },
                                    color: Colors.orange,
                                    icon: Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 10.0,
                        offset: Offset(
                          1.0, // horizontal, move right 10
                          1.0, // vertical, move down 10
                        ),
                      ),
                    ],
                  ),
                  width: screenW(0.9, context),
                  height: screenH(0.14, context),
                  margin: EdgeInsets.only(top: screenH(0.02, context)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: screenH(0.05, context),
                          padding: EdgeInsets.only(
                            top: screenW(0.03, context),
                            left: screenW(0.03, context),
                          ),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 0.2))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Text('Total Price'),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("€ " + totalPrice.toString()),
                              )
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.only(
                            left: screenW(0.03, context),
                            top: screenW(0.03, context)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Have Promo Code',
                                style: TextStyle(color: green1),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  padding: EdgeInsets.only(right: 20),
                                  child: TextField(
                                    controller: promoCode,
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                AbsorbPointer(
                  absorbing: active,
                  child: InkWell(
                      onTap: () {
                        String foodsToJson(List<JsonFood> data) => json.encode(
                            List<dynamic>.from(data.map((x) => x.toJson())));
                        var jsonn = foodsToJson(food);
                        _senOrder(jsonn);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: screenH(0.02, context)),
                        decoration: BoxDecoration(
                          color: green1,
                          borderRadius:
                              BorderRadius.circular(screenH(0.2, context)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 10.0,
                              offset: Offset(
                                1.0, // horizontal, move right 10
                                1.0, // vertical, move down 10
                              ),
                            ),
                          ],
                        ),
                        width: screenW(0.9, context),
                        height: screenH(0.07, context),
                        alignment: Alignment.center,
                        child: Text(
                          'Proceed Confirm Order',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      )),
                ),
                Container(
                  height: screenH(0.07, context),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class Orders {
  int amount;
  String foodId;
  String name;
  String description;
  double price;
  String image;
  List<FoodExtra> foodExtra;

  Orders(
      {this.amount,
      this.foodId,
      this.name,
      this.description,
      this.price,
      this.image,
      this.foodExtra});

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        amount: json["amount"],
        foodId: json["foodId"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
        foodExtra: List<FoodExtra>.from(
            json["foodExtra"].map((x) => FoodExtra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": amount,
        "foodId": foodId,
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "foodExtra": List<dynamic>.from(foodExtra.map((x) => x.toJson())),
      };
}

class FoodExtra {
  String foodExtraId;
  String name;

  FoodExtra({
    this.foodExtraId,
    this.name,
  });

  factory FoodExtra.fromJson(Map<String, dynamic> json) => FoodExtra(
        foodExtraId: json["foodExtraId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "foodExtraId": foodExtraId,
        "name": name,
      };
}

class JsonFood {
  String foodDetailId;
  String price;
  List<JsonExtra> foodExtra;

  JsonFood({
    this.foodDetailId,
    this.price,
    this.foodExtra,
  });

  factory JsonFood.fromJson(Map<String, dynamic> json) => JsonFood(
        foodDetailId: json["foodDetailId"],
        price: json["price"],
        foodExtra: List<JsonExtra>.from(
            json["foodExtra"].map((x) => JsonExtra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foodDetailId": foodDetailId,
        "price": price,
        "foodExtra": List<dynamic>.from(foodExtra.map((x) => x.toJson())),
      };
}

class JsonExtra {
  String foodExtraId;

  JsonExtra({
    this.foodExtraId,
  });

  factory JsonExtra.fromJson(Map<String, dynamic> json) => JsonExtra(
        foodExtraId: json["foodExtraId"],
      );

  Map<String, dynamic> toJson() => {
        "foodExtraId": foodExtraId,
      };
}

class AddressClass {
  String id;
  String name;
  String address;

  AddressClass({
    this.id,
    this.name,
    this.address,
  });

  factory AddressClass.fromJson(Map<String, dynamic> json) => AddressClass(
        id: json["id"],
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
      };
}
