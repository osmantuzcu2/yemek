
import 'dart:convert';
import 'package:http/http.dart' as http;
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
import '../../core/inh.dart' as inh;
class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var nameText = TextEditingController();
  var lastNameText =TextEditingController();
  var telText = TextEditingController();
  _getUser() {
    Future getUser() {
      var url = Constants.generalBaseUrl + '/api/user.php?process=getid_user&userId='
      +Cookie.of(context).user_id;
      return http.get(url);
    }

    getUser().then((response) {
      setState(() {
        var boddy = json.decode(response.body);
        if (boddy[0]['status'] == 'true') {
            var ret = boddy[0];
            Cookie.of(context).setUserId(ret['id']);
            Cookie.of(context).setUserNameLastname(ret['name']+" "+ret['lastname']);
            Cookie.of(context).setUserName(ret['name']);
            Cookie.of(context).setUserLastname(ret['lastname']);
            Cookie.of(context).setUserAvatar(ret['avatar']);
            nameText.text = ret['name'];
            lastNameText.text = ret['lastname'];
            telText.text = ret['tel'];
            _dateController.text = ret['birthday'];
            
          
        }
      });
    });
  }
  Future<void> update() async {
    if (
      nameText.text == '' ||
      lastNameText.text == '' ||
      telText.text == '' ||
      _dateController.text == '' 
      ) {
       
      
      toast(Constants.EKSIK_BILGI);

    } else {

        
          var url = Constants.generalBaseUrl + '/api/user.php';
          print(url);
          Map<String,String> bdy = {
            "process":"up_User",
            "id":Cookie.of(context).user_id,
            'name':nameText.text,
            'lastname':lastNameText.text,
            'birthday':_dateController.text,
            'tel': telText.text
            };
          print (bdy);
          var data = await http.post(url, body: bdy);
          print(data.body);
          if (data.statusCode == 200) {
            var boddy = json.decode(data.body);
            print('boddy:' + boddy.toString());
            if (!boddy.isEmpty) {
              var ret = boddy[0];
              print(ret);
              if (ret['status'] == 'true') {
                toast('Sie haben sich erfolgreich angemeldet');
                
              } else {
                toast(ret['message']);
              }
            }
          }
          else{
            print("err");
          }
        
    }
  }
  @override
  void initState() {
    super.initState();
   
  }
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  var _dateController = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2020));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateController.text = selectedDate.day.toString() +
            '-' +
            selectedDate.month.toString() +
            '-' +
            selectedDate.year.toString();
      });
  }
 
  Widget build(BuildContext context) {
    _getUser();
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
                  background: appBarProfile(context, true,'')
                  ),
            ),
            
          ];
        },
        
      body: 
    
       Center(
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
                          Text('',style: TextStyle(color: Colors.yellow[700],),)
                        ],),
                      
                       Form(
              key: _formKey,
              child: Container(
                
                child: Column(
                  children: <Widget>[
                    
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: fireSvgwidthColor(screenW(0.06, context),
                                'label', 'assets/name.svg', grey1)),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: nameText,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Adınızı giriniz';
                              }
                              return null;
                            },
                            decoration: input('First Name', 'Adınızı Giriniz'),
                            onSaved: (String value) {
                              print("Value : $value");
                            },
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: fireSvgwidthColor(screenW(0.06, context),
                                'label', 'assets/name.svg', grey1)),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: lastNameText,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Soyadınızı giriniz';
                              }
                              return null;
                            },
                            decoration:
                                input('Last Name ', 'Soyadınızı Giriniz'),
                            onSaved: (String value) {
                              print("Value : $value");
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: screenW(0.02, context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: fireSvgwidthColor(screenW(0.06, context),
                                'label', 'assets/birthday.svg', grey1)),
                        Expanded(
                          flex: 8,
                          child: TextFormField(
                            
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Doğum tarihinizi seçiniz';
                              }
                              return null;
                            },
                            decoration: input(
                                'Doğum Tarihi ', 'Doğum tarihinizi seçiniz'),
                            onSaved: (String value) {
                              print("Value : $value");
                            },
                            controller: _dateController,
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: screenW(0.02, context),
                    ),
                    
                    Container(
                      height: screenW(0.02, context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.phone,
                              color: grey1,
                            )),
                        Expanded(
                          flex: 8,
                          child: TextFormField(
                            controller: telText,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Telefon numaranızı giriniz';
                              }
                              return null;
                            },
                            decoration: input(
                                'Phone Number ', 'Telefon numaranızı giriniz'),
                            onSaved: (String value) {
                              print("Value : $value");
                            },
                          ),
                        ),
                      ],
                    ),
                   
                    
                    
                  ],
                ),
              ),
            ),
            
                      InkWell(
                        onTap: (){
                          update();
                        },
                                              child: Container(
                          width: double.infinity,
                          height: screenH(0.08, context),
                          margin: EdgeInsets.only(
                            top: screenW(0.05, context),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                            10
                            ),
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
                          child: Text('GÜNCELLE',
                          style: TextStyle(color:green1),
                          )),
                      )
                      
                      
                      ],
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

class Foods {
  final title;
  final asset;
  Foods({this.title,this.asset});
}