import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/screens/product_details.dart';
import 'package:mc_jsi/ui/widgets.dart/appbar.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/green_bar.dart';
import 'dart:convert';
import '../../core/constants.dart';
import 'package:http/http.dart' as http;
import 'gel_al.dart';

class ProductList extends StatefulWidget {
  var dataFoods = new List<Foods>();
  String id;
  String search;
  ProductList({Key key,this.dataFoods,this.id,this.search}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState(dataFoods:dataFoods,id:id,search:search);
}

class _ProductListState extends State<ProductList> { 
  var searchText = TextEditingController();
  var dataFoods = new List<Foods>();
  String id;
  String search;
  _ProductListState({this.dataFoods,this.id,this.search});
  var dataList = new List<Foods>();
  _getFoods() {
    Future getFoods() {
      var url = Constants.generalBaseUrl + '/api/food.php?process=getid_foods';
      return http.get(url);
    }
    getFoods().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        dataList = list.map((model) => Foods.fromJson(model)).toList();
        var boddy = json.decode(response.body);
        if (boddy[0]['status'] == 'true') {
         print(Constants.generalBaseUrl+boddy[0]["image"]);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getFoods();
    if (search == null) {
     _getFoodDetails();  
      
    } else {
     _searchFoodDetails();  
    }   
  }
  var data = new List<FoodDetail>();
   _getFoodDetails() {
    Future getFoodDetails() {
      var url = Constants.generalBaseUrl + '/api/food.php?process=getid_foodDetails&foodId='+id;
      return http.get(url);
    }
    getFoodDetails().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        data = list.map((model) => FoodDetail.fromJson(model)).toList();
        var boddy = json.decode(response.body);
        if (boddy[0]['status'] == 'true') {
         print(Constants.generalBaseUrl+boddy[0]["image"]);
        }
      });
    });
  }
   _searchFoodDetails() {
    Future getFoodDetails() {
      var url = Constants.generalBaseUrl + '/api/orders.php?process=search_foods&word='+search;
      return http.get(url);
    }
    getFoodDetails().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        data = list.map((model) => FoodDetail.fromJson(model)).toList();
        var boddy = json.decode(response.body);
        if (boddy[0]['status'] == 'true') {
         //print(Constants.generalBaseUrl+boddy[0]["image"]);
        }
      });
    });
  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  background: appBar(context, true, 'assets/ribbon.svg',searchText)),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: <Widget>[
              greenbar(context),
              search==null?
              Container(
                height: screenH(0.12, context),
                width: screenW(1, context),
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: dataFoods.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                       id= dataFoods[index].id;
                       _getFoodDetails();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: screenH(0.02, context)
                        ),
                        width: screenW(0.22, context), 
                        child: Image.network(Constants.generalBaseUrl+ dataFoods[index].image),
                      )
                    );
                },
                ),
              ):Container(),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    
                    
                    title: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                         builder: (context) => ProductDetails(
                           id:data[index].id,
                           name: data[index].name,
                           image : data[index].image,
                           price: data[index].price,
                           price_small : data[index].price_small,
                           price_big : data[index].price_big,
                         )
                        ));
                      },
                                          child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1,color: Colors.grey)
                          )
                        ),
                        margin: EdgeInsets.only(
                          right: screenW(0.03, context),
                          left: screenW(0.03, context),
                          top: screenW(0.02, context)
                        ), padding: EdgeInsets.only(
                          bottom: screenW(0.03, context),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(flex: 1,
                            child:Icon(
                        Icons.add,
                        color: blue1,
                      ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Image.network(
                                Constants.generalBaseUrl+ data[index].image,
                                  width: 5,
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                                flex: 5,
                                child: Column(
                                  
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(data[index].name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14)),
                                  Text(data[index].description,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200))
                                ])),
                            Expanded(
                              flex: 2,
                              child :Text("€ "+data[index].price,textAlign: TextAlign.right,)
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
             
            ],
          )),
        ),
      ),
    );
  }
}

class FoodDetail {
    String id;
    String foodId;
    String name;
    String description;
    String price;
    String image;
    String price_small;
    String price_big;

    FoodDetail({
        this.id,
        this.foodId,
        this.name,
        this.description,
        this.price,
        this.image,
        this.price_small,
        this.price_big,
    });

    factory FoodDetail.fromJson(Map<String, dynamic> json) => FoodDetail(
        id: json["id"],
        foodId: json["foodId"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
        price_small: json["price_small"],
        price_big: json["price_big"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "foodId": foodId,
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "price_small": price_small,
        "price_big": price_big,
    };
}
