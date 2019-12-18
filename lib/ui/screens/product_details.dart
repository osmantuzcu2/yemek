
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/dbHelper.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/widgets.dart/appbar.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/green_bar.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {
  final String id;
  final String name;
  final String image;
final String price;
  ProductDetails({Key key,this.id,this.name,this.image,this.price}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState(
    id: id,
    name:name,
    image:image,
    price:price
    );
}
List<ProductProperties> data = List<ProductProperties>();
class _ProductDetailsState extends State<ProductDetails> {
final String id;
final String name;
final String image;
final String price;
int amount=1;
bool _isChecked=false;

_ProductDetailsState({this.id,this.name,this.image,this.price});
   var searchText = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getExtras();
   DbHelper().getFoods().then((data){
   
    }); 
          
  }
  void _amountPicker() {
      showDialog<int>(
          context: context,
          builder: (BuildContext context) {
            return new NumberPickerDialog.integer(
              minValue: 0,
              maxValue: 20,
              title: new Text("Adet seçiniz"),
              initialIntegerValue: 1,
            );
          }).then((int value) {
        if (value != null) {
          setState(() {
            amount = value;
          });
        }
      });
    }
  var data = new List<Extras>();
   _getExtras() {
    Future getExtras() {
      var url = Constants.generalBaseUrl + '/api/food.php?process=getid_foodExtras&foodDetailId='+id;
      return http.get(url);
    }
    getExtras().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        data = list.map((model) => Extras.fromJson(model)).toList();
        
      });
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
              Container(
                padding: EdgeInsets.all(
                  screenW(0.01, context),
                ),
                child: Text(name ==null ? '' : name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
                )
              ),
              Container(
                padding: EdgeInsets.all(
                  screenW(0.01, context),
                ),
                child: Container(
                  width: screenW(0.4, context),
                  child: Image.network(Constants.generalBaseUrl+ image,),
                ),
              ),
              Container(
                padding: EdgeInsets.all(
                  screenW(0.01, context),
                ),
                child: GestureDetector(
                  onTap: (){
                    _amountPicker();
                  },
                  child: Container(
                    width: screenW(0.3, context),
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add,size: 32,color: Colors.green,),
                        Text(amount.toString()+' Adet')
                      ]
                    )
                  )
                )
              ),
              Container(
                padding: EdgeInsets.only(
                  left:screenW(0.1, context),
                  right:screenW(0.1, context)
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: blue1
                        )
                      )
                    ),
                    child: Row(children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Text(data[index].name),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('+ €'+data[index].price,style: prefix0.TextStyle(color: Colors.red),),
                      ),
                      Expanded(
                        flex: 1,
                        child: Checkbox(
                          value: data[index].isChecked==null ? false:data[index].isChecked, 
                          onChanged: (bool value) {
                            setState(() {
                              data[index].isChecked = value;
                              if(value == true){
                                DbHelper().initDB();
                                DbHelper().insertExtras(
                                  id, data[index].name, data[index].id,double.parse(data[index].price));
                                DbHelper().getExtras().then((data){
                                for (var item in data) {
                                  print(item["name"]);
                                }
                                });
                              }
                              else{
                                 DbHelper().initDB();
                                 DbHelper().deleteExtras(data[index].id).then((data){
                                   print(data);
                                });
                                DbHelper().getExtras().then((data){
                                for (var item in data) {
                                  print(item);
                                }
                                });

                              }
                             
                            });
                          },
                        ),
                      )
                    ],),
                  );
                 },
                ),
              ),
             InkWell(
               onTap: (){
                 DbHelper().initDB();
                 DbHelper().insertFood(id,name,amount,double.parse(price),image);
                 DbHelper().getFoods().then((data){
                    for (var item in data) {
                      print(item);
                    }
                    Cookie.of(context).incOrderNumber(1);
                    Navigator.pop(context);
                  });  
                  
               },
               child: Card(
                 shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10.0),
                       ),
                  margin: EdgeInsets.all(screenW(0.1, context)),
                 child: Container(
                   padding: EdgeInsets.only(
                     left:screenW(0.1, context),
                     right:screenW(0.1, context),
                     top:screenW(0.05, context),
                     bottom:screenW(0.05, context),
                     ),
                   child: Row(
                     children: <Widget>[
                       Expanded(
                         flex: 4,
                         child: Text('Sepete Ekle',
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.w400
                         ),
                         ),
                       ),
                       Expanded(
                         flex: 1,
                         child: Text("€ ",
                         textAlign: TextAlign.right,
                         style: TextStyle(
                           color: green1,
                           fontSize: 18,
                           fontWeight: FontWeight.w400
                         ),
                         ),
                       ),
                        Expanded(
                         flex: 2,
                         child: Text('19.00',
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold
                         ),
                         ),
                       )
                     ],
                   ),
                 ),
               )
               
             )],
          )),
        ),
      ),
    );
  }
}
class ProductProperties{
  final id;
  final propertyName;
  final propertyPrice;
  ProductProperties(
      {this.id,
      this.propertyName,
      this.propertyPrice});
}
class Extras {
    String id;
    String foodDetailId;
    String name;
    String price;
    bool isChecked;

    Extras({
        this.id,
        this.foodDetailId,
        this.name,
        this.price,
        this.isChecked,
    });

    factory Extras.fromJson(Map<String, dynamic> json) => Extras(
        id: json["id"],
        foodDetailId: json["foodDetailId"],
        name: json["name"],
        price: json["price"],
        isChecked: json["isChecked"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "foodDetailId": foodDetailId,
        "name": name,
        "price": price,
        "isChecked": isChecked,
    };
}

