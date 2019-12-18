import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key key, this.title}) : super(key: key);
  // always marked "final".

  final String title;

  @override
  _CalendarScreenState createState() => new _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _currentDate = DateTime(2019, 2, 3);
  
 

  EventList<Event> _markedDateMap = new EventList<Event>();

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2019, 2, 25),
        new Event(
          date: new DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: Icon(Icons.restaurant),
        ));

    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(''),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                  ) {
                    
                    /* if (day.day == 15) {
                      return Center(
                        child: Icon(Icons.local_airport),
                      );
                    } else {
                      return null;
                    } */
                  },
                  
                  weekFormat: false,
                  markedDatesMap: _markedDateMap,
                  height: 420.0,
                  selectedDateTime: _currentDate,
                  daysHaveCircularBorder: false,

                ),
              )
              //
            ],
          ),
        ));
  }
}
