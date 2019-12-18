import 'dart:convert';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/widgets.dart/appbar.dart';
import 'package:mc_jsi/ui/widgets.dart/blue_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/green_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';
import 'package:http/http.dart' as http;

class CalendarScreen2 extends StatefulWidget {
  CalendarScreen2({Key key}) : super(key: key);

  @override
  _CalendarScreen2State createState() => _CalendarScreen2State();
}

class _CalendarScreen2State extends State<CalendarScreen2> {
 var searchText = TextEditingController();
  DateTime _currentDate =DateTime.now();
  List<Reservations> data = List<Reservations>();
  EventList<Event> _markedDateMap = new EventList<Event>();
  _getdata() {
    Future getdata() {
      var url = Constants.generalBaseUrl + '/api/reservation.php';
      return http.post(url, body: {'process': 'getall_reservation'});
    }

    getdata().then((response) {
      setState(() {
        List list = json.decode(response.body);
        for (var i = 0; i < list.length; i++) {
          DateTime dat = DateTime.parse(list[i]['date']);
          data.add(Reservations(
            id: list[i]['id'],
            date: dat,
            note: list[i]['note'],
            person: list[i]['person'],
            status: list[i]['status'],
          ));
          _markedDateMap.add(
              dat,
              new Event(
                date: dat,
                title: 'Reservation',
                icon: Icon(Icons.restaurant),
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
      'user_id': ''
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: CalendarCarousel<Event>(
                  locale: 'de',
                  onDayPressed: (DateTime date, List<Event> events) {
                    this.setState(() => _currentDate = date);
                    events.forEach((event) => print(event.title));
                  },
                  weekendTextStyle: TextStyle(
                    color: Colors.red,
                  ),
                  thisMonthDayBorderColor: Colors.grey,
                  customDayBuilder: (
                    /// you can provide your own build function to make custom day containers
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                  ) {},
                  weekFormat: false,
                  markedDatesMap: _markedDateMap,
                  height: 440.0,
                  selectedDateTime: _currentDate,
                  daysHaveCircularBorder: false,
                ),
              )
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
