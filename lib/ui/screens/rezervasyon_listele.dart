import 'dart:convert';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/widgets.dart/appbar.dart';
import 'package:mc_jsi/ui/widgets.dart/blue_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/green_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';
import 'package:http/http.dart' as http;

class ReservationList extends StatefulWidget {
  ReservationList({Key key}) : super(key: key);

  @override
  _ReservationListState createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
   var searchText = TextEditingController();
  List<Reservations> data = List<Reservations>();
  _getdata() {
    Future getdata() {
      var url = Constants.generalBaseUrl + '/api/reservation.php';
      return http.post(url, body: {'process': 'getall_reservation'});
    }

    getdata().then((response) {
      setState(() {
        List list = json.decode(response.body);
        for (var i = 0; i < list.length; i++) {
          data.add(Reservations(
            id: list[i]['id'],
            date: DateTime.parse(list[i]['date']),
            note: list[i]['note'],
            person: list[i]['person'],
            status: list[i]['status'],
          ));
        }
      });
    });
  }
  Future<void> delete({
    String id,
    }) async {
    
      var url = Constants.generalBaseUrl + '/api/reservation.php';
      print(url);
      var data = await http.post(url, body: {
        'process': 'del_reservation', 
        'id': id,
        'user_id' : ''  
        //TODO : MIB den alcaz
        });
      print(data.body);
      if (data.statusCode == 200) {
        var boddy = json.decode(data.body);
        print('boddy:' + boddy.toString());
        if (!boddy.isEmpty) {
          var ret = boddy[0];
          print(ret);
          if (ret['status'] == 'true') {
            toast(ret['message']);
          } else {
            toast(ret['message']);
          }
        }
      }
    
  }
  String ddmmyy(DateTime date) {
    var str = formatDate(date, [dd, '-', mm, '-', yyyy]);
    return str;
  }

  String time(DateTime date) {
    var str = formatDate(date, [HH, ':', nn]);
    return str;
  }

  @override
  void initState() {
    super.initState();
    _getdata();
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
              blueBar(context, 'ReservationList', 'assets/calendar.svg'),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    leading: Icon(
                      Icons.add,
                      color: green1,
                    ),
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Text(
                            ddmmyy(data[index].date),
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.access_time,
                              color: Colors.grey,
                              size: 17,
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(time(data[index].date),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14))),
                        Expanded(
                            flex: 1,
                            child: fireSvgwidthColor(screenW(0.04, context), '',
                                'assets/people.svg', Colors.grey)),
                        Expanded(
                            flex: 2,
                            child: Text(data[index].person,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14))),
                      ],
                    ),
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          child: Column(
                            children: <Widget>[
                              Text(
                                data[index].note,
                                style: TextStyle(fontSize: 15),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(flex: 8, child: Container()),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      onPressed: () {

                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      onPressed: () {
                                        delete(id:data[index].id);
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
                  );
                },
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, Constants.ROUTE_RESERVATION_ADD);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Buchen Sie jetzt',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    width: screenW(0.9, context),
                    height: screenH(0.08, context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [green1, blue1],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)),
                  ))
            ],
          )),
        ),
      ),
    );
  }
}

class Reservations {
  String id;
  DateTime date;
  String person;
  String note;
  String userId;
  String status;

  Reservations({
    this.id,
    this.date,
    this.person,
    this.note,
    this.userId,
    this.status,
  });
}
