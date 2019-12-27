import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/ui/widgets.dart/appbar.dart';
import 'package:mc_jsi/ui/widgets.dart/blue_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/bottom_menu.dart';
import 'package:mc_jsi/ui/widgets.dart/drawer.dart';
import 'package:mc_jsi/ui/widgets.dart/green_bar.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:date_format/date_format.dart';
class ReservationAdd extends StatefulWidget {
  ReservationAdd({Key key}) : super(key: key);

  @override
  _ReservationAddState createState() => _ReservationAddState();
}

class _ReservationAddState extends State<ReservationAdd> {
   var searchText = TextEditingController();
  var day;
  var mm;
  var yyyy;
  var clock;
  var person;
  bool show;
  DateTime _time;
  DateTime today = DateTime.now();
  Widget timePicker() {
  return new TimePickerSpinner(
    
    is24HourMode: true,
    normalTextStyle: TextStyle(
      fontSize: 24,
    ),
    highlightedTextStyle: TextStyle(
      fontSize: 24,
      color: Colors.blue
    ),
    spacing: 50,
    itemHeight: 80,
    isForce2Digits: true,
    onTimeChange: (time) {
      setState(() {
        clock = formatDate(time, [HH,':',nn]);

      });
    },
  );
}
datePicker2() async{
  DateTime newDateTime = await showRoundedDatePicker(
                            context:context,
                            initialDate: DateTime.now(), 
                            firstDate: DateTime(DateTime.now().year - 1), 
                            lastDate: DateTime(DateTime.now().year + 1), 
                            borderRadius: 16);
  setState(() {
    mm= formatDate(newDateTime, [MM]);
    day = formatDate(newDateTime, [dd]);
    yyyy = formatDate(newDateTime, [yyyy]);
  });
  return newDateTime;
}
  @override
  void initState() {
    super.initState();
    show = false;
    mm= formatDate(today, [MM]);
    day = formatDate(today, [dd]);
    yyyy = formatDate(today, [yyyy]);
    clock = formatDate(today, [HH,':',nn]);

  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
       
       bottomNavigationBar: bottomMenu(context,_scaffoldKey),
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
          child:Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  greenbar(context),
                  blueBar(context, 'Tisch Reservieren', 'assets/calendar.svg'),
                  GestureDetector(
                    onTap: (){
                      datePicker2();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top:screenW(0.02, context)),
                        padding: EdgeInsets.all(screenW(0.04, context)),
                        width: screenW(0.9, context),
                        height: screenH(0.08, context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: green1,width: 1)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                           
                            Expanded(flex: 1,
                              child: Text(day,
                                    textAlign: TextAlign.right,
                              
                              ),
                            ),
                            Expanded(flex: 1,
                              child: Icon(Icons.arrow_drop_down,color: green1,)
                            ),
                            Expanded(flex: 3,
                              child: Text(mm,
                                    textAlign: TextAlign.right,
                              
                              ),
                            ),
                            Expanded(flex: 1,
                              child: Icon(Icons.arrow_drop_down,color: green1,)
                            ),
                            Expanded(flex: 1,
                              child: Text(today.year.toString(),
                                    textAlign: TextAlign.right,)
                            ),
                             Expanded(flex: 1,
                              child: Icon(Icons.arrow_drop_down,color: green1,)
                            ),
                          ],
                        ),
                      ),
                  ) ,
                    Container(
                     padding: EdgeInsets.only(
                       left:screenW(0.05, context),
                       top:screenW(0.02, context)
                       ),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                show=true;
                              });
                            },
                              child: Container(
                              width: screenW(0.425, context),
                              height: screenH(0.08, context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: green1,width: 1),
                                
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(flex: 1,
                                    child: fireSvg(20, '', 'assets/time.svg')
                                  ),
                                  Expanded(flex: 1,
                                    child: Text(clock,
                                    textAlign: TextAlign.right,
                                    
                                    ),
                                  ),
                                  Expanded(flex: 1,
                                    child: Icon(Icons.arrow_drop_down,color: green1,)
                                  ),
                                 
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: screenW(0.05, context)),
                            width: screenW(0.425, context),
                            height: screenH(0.08, context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: green1,width: 1)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(flex: 1,
                                  child: fireSvg(20, '', 'assets/people.svg')
                                ),
                                Expanded(flex: 1,
                                  child: Text('0',
                                  textAlign: TextAlign.right,
                                  
                                  ),
                                ),
                                Expanded(flex: 1,
                                  child: Icon(Icons.arrow_drop_down,color: green1,)
                                ),
                               
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(screenW(0.05, context)),
                      child: TextField(
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: 'Aufzeichnungen',
                          contentPadding: EdgeInsets.all(screenW(0.02, context)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Buchen Sie jetzt',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 18
                            ),),
                        width: screenW(0.9, context),
                        height: screenH(0.08, context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [green1,blue1],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight
                          
                          )
                        ),
                      ),
                    )
                  
                ],
              ),
              show == false ? Container():
              Container(
                color: Colors.black45,
                width: screenW(1, context),
                height: screenH(1, context),
                padding: EdgeInsets.only(
                  bottom: screenH(0.1, context),
                  left: screenW(0.05, context),
                  right: screenW(0.05, context),
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      timePicker(),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            show=false;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Erledigt',
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 18
                              ),),
                          width: screenW(0.5, context),
                          height: screenH(0.08, context),
                          margin: EdgeInsets.only(
                            top: screenH(0.02, context)
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue
                          ),
                        ),
                      ),
                    ],
                  )),
              )
            ],
          )),
       ),
      ),
    
      
    );
  }
}



class Foods {
  final title;
  final asset;
  Foods({this.title,this.asset});
}