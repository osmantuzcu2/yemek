import 'dart:convert';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:mc_jsi/core/constants.dart';
import 'package:mc_jsi/core/functions.dart';
import 'package:mc_jsi/core/inh.dart';
import 'package:mc_jsi/ui/widgets.dart/widget_helpers.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}
bool progress=false;
final _formKey = GlobalKey<FormState>();
final _formKeyLogin = GlobalKey<FormState>();

class _RegisterState extends State<Register> {
  var _dateController = new TextEditingController();
  var signInemailCont = TextEditingController();
  var signInPasswordCont = TextEditingController();
  var signUpname = TextEditingController();
  var signUpsurname = TextEditingController();
  var signUpemailR = TextEditingController();
  var signUpphone = TextEditingController();
  var signUppassR = TextEditingController();
  var signUppassRC = TextEditingController();
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

  Future<void> login({
    String email,
    String pass,
  }) async {
    if (!email.isEmpty && !pass.isEmpty) {
      var url = Constants.generalBaseUrl + '/api/login.php';
      print(url);
      var data = await http.post(url, body: {'email': email, 'password': pass});
      print(data.body);
      if (data.statusCode == 200) {
        var boddy = json.decode(data.body);
        print('boddy:' + boddy.toString());
        if (!boddy.isEmpty) {
          var ret = boddy[0];
          print(ret);
          if (ret['status'] == 'true') {
            //setUserIdPref(ret['id'], ret['profile_photo'], ret['username']);
            setUserIdPref( ret['id'],ret['avatar'],ret['name']);
            Cookie.of(context).setUserId(ret['id']);
            Cookie.of(context).setUserNameLastname(ret['name']+" "+ret['lastname']);
            Cookie.of(context).setUserName(ret['name']);
            Cookie.of(context).setUserLastname(ret['lastname']);
            Cookie.of(context).setUserAvatar(ret['avatar']);
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
              progress = false;
            });
              Navigator.pushNamed(context, Constants.ROUTE_HOME_PAGE);
            });
          } else {
            toast(ret['message']);
          }
        }
      }
    } else {
      toast(Constants.EKSIK_BILGI);
    }
  }
    Future<void> register({
      String name,
      String surname,
      String birthday,
      String emailR,
      String phone,
      String passR,
      String passRC,
    }) async {
    if (
      !name.isEmpty && 
      !surname.isEmpty && 
      !birthday.isEmpty && 
      !emailR.isEmpty && 
      !phone.isEmpty && 
      !passR.isEmpty && 
      !passRC.isEmpty 
      ) {
        if (passR == passRC) {
          var url = Constants.generalBaseUrl + '/api/register.php';
          print(url);
          var data = await http.post(url, body: {
            'email':emailR,
            'password':passR,
            'name':name,
            'lastname':surname,
            'birthday':birthday,
            'tel': phone
            });
          print(data.body);
          if (data.statusCode == 200) {
            var boddy = json.decode(data.body);
            print('boddy:' + boddy.toString());
            if (!boddy.isEmpty) {
              var ret = boddy[0];
              print(ret);
              if (ret['status'] == 'true') {
                //setUserIdPref(ret['id'], ret['profile_photo'], ret['username']);
                toast('Sie haben sich erfolgreich angemeldet');
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.pushNamed(context, Constants.ROUTE_HOME_PAGE);
                });
              } else {
                toast(ret['message']);
              }
            }
          }
        }
        else{
          toast(Constants.PASS_FARKLI);
        }
      

    } else {
      toast(Constants.EKSIK_BILGI);
    }
  }
   Future<void> forgot_password({
    String email,
  }) async {
    if (!email.isEmpty) {
      var url = Constants.generalBaseUrl + '/api/forgot_password.php';
      print(url);
      var data = await http.post(url, body: {'email': email, 'id': '1'});
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
    } else {
      toast('Constants.EKSIK_BILGI');
    }
  }
  @override
  void initState() { 
    super.initState();
   //signInemailCont.text = 'osmantuzcu@gmail.com';
   //signInPasswordCont.text = '1234567';
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(
                  left: screenW(0.05, context),
                  right: screenW(0.05, context),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                        height: screenH(0.18, context),
                        margin: EdgeInsets.only(
                          bottom: screenH(0.02, context),
                        ),
                        child: Hero(
                            tag: 'logo',
                            child: Image.asset('assets/logo2.png'))),
                    Container(
                        child: TabBar(
                      indicatorColor: green1,
                      tabs: <Widget>[
                        Tab(
                          child: Text('Registrieren'),
                        ),
                        Tab(
                          child: Text('Einloggen'),
                        ),
                      ],
                    )),
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
                            controller: signUpname,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Geben Sie Ihren Vorname ein';
                              }
                              return null;
                            },
                            decoration: input('Vorname', 'Geben Sie Ihren Vorname ein'),
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
                            controller: signUpsurname,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Geben Sie Ihren Nachnamen ein';
                              }
                              return null;
                            },
                            decoration:
                                input('Nachname ', 'Geben Sie Ihren Nachnamen ein'),
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
                            controller: _dateController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Wähle deinen Geburtstag aus';
                              }
                              return null;
                            },
                            decoration: input(
                                'Geburtsdatum ', 'Wähle deinen Geburtstag aus'),
                            onSaved: (String value) {
                              print("Value : $value");
                            },
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                return 
                              DatePickerWidget(
                                onConfirm: (date,index){
                                  _dateController.text = date.day.toString() +" - "+ 
                                  date.month.toString() +" - "+ date.year.toString();
                                },
                              );
                              },
                                
                              );
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
                            child: Icon(
                              Icons.email,
                              color: grey1,
                            )),
                        Expanded(
                          flex: 8,
                          child: TextFormField(
                            controller: signUpemailR,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Geben Sie Ihre E-Mail-Adresse ein';
                              }
                              return null;
                            },
                            decoration:
                                input('E-mail ', 'Geben Sie Ihre E-Mail-Adresse ein'),
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
                            child: Icon(
                              Icons.phone,
                              color: grey1,
                            )),
                        Expanded(
                          flex: 8,
                          child: TextFormField(
                            controller: signUpphone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Geben Sie Ihre Telefonnummer ein';
                              }
                              return null;
                            },
                            decoration: input(
                                'Telefonnummer', 'Geben Sie Ihre Telefonnummer ein'),
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
                            child: Icon(
                              Icons.vpn_key,
                              color: grey1,
                            )),
                        Expanded(
                          flex: 8,
                          child: TextFormField(
                            obscureText: true,
                            controller: signUppassR,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Passwort';
                              }
                              return null;
                            },
                            decoration: input('Passwort ', 'Geben Sie Ihr  Passwort ein'),
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
                            child: Icon(
                              Icons.vpn_key,
                              color: grey1,
                            )),
                        Expanded(
                          flex: 8,
                          child: TextFormField(
                            controller: signUppassRC,
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'CKennwort bestätigen';
                              }
                              return null;
                            },
                            decoration:
                                input('Kennwort bestätigen ', 'Kennwort bestätigen'),
                            onSaved: (String value) {
                              print("Value : $value");
                            },
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        register(
                          name: signUpname.text,
                          surname: signUpsurname.text,
                          birthday: _dateController.text,
                          emailR: signUpemailR.text,
                          passR: signUppassR.text,
                          passRC: signUppassRC.text,
                          phone: signUpphone.text,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: screenW(0.05, context)),
                        padding: EdgeInsets.all(screenW(0.04, context)),
                        width: screenW(0.9, context),
                        height: screenH(0.08, context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: green1,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Registrieren',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Text('Get in without Register',
                      style: TextStyle(
                        decoration: TextDecoration.underline
                      ),
                      ),
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), 
                                              (Route<dynamic> route) => false
                                              );
                      },
                    )
                  ],
                ),
              ),
            ),
            //Sign In Form
            Stack(
              children: [
                Container(
                  child: Form(
                    key: _formKeyLogin,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: screenW(0.05, context),
                        right: screenW(0.05, context),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: screenH(0.18, context),
                              margin: EdgeInsets.only(
                                bottom: screenH(0.02, context),
                              ),
                              child: Image.asset('assets/logo2.png')),
                          Container(
                              child: TabBar(
                            indicatorColor: green1,
                            tabs: <Widget>[
                              Tab(
                                child: Text('Registrieren'),
                              ),
                              Tab(
                                child: Text('Einloggen'),
                              ),
                            ],
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.email,
                                    color: grey1,
                                  )),
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  controller: signInemailCont,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Geben Sie Ihre E-Mail-Adresse ein';
                                    }
                                    return null;
                                  },
                                  decoration:
                                      input('Email ', 'Geben Sie Ihre E-Mail-Adresse ein'),
                                  onSaved: (String value) {
                                    print("Value : ");
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
                                  child: Icon(
                                    Icons.vpn_key,
                                    color: grey1,
                                  )),
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  obscureText: true,
                                  controller: signInPasswordCont,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Passwort';
                                    }
                                    return null;
                                  },
                                  decoration:
                                      input('Passwort ', 'Geben Sie Ihr  Passwort ein'),
                                  onSaved: (String value) {
                                    print("Value : ");
                                  },
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: screenW(0.02, context),
                          ),
                          Container(
                            height: screenH(0.08, context),
                            alignment: Alignment.bottomRight,
                            child: FlatButton(
                              onPressed: () {
                                forgot_password(email: signInemailCont.text);
                              },
                              child: Text(
                                'Passwort vergessen',
                                style:
                                    TextStyle(decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                progress = true;
                              });
                              login(
                                  email: signInemailCont.text,
                                  pass: signInPasswordCont.text);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: screenW(0.05, context)),
                              padding: EdgeInsets.all(screenW(0.04, context)),
                              width: screenW(0.9, context),
                              height: screenH(0.08, context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: blue1,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Einloggen',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          /* Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(top: screenW(0.05, context)),
                                  padding: EdgeInsets.all(screenW(0.04, context)),
                                  width: screenW(0.4, context),
                                  height: screenH(0.08, context),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: google,
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: <Widget>[
                                      fireSvgwidthColor(
                                          screenW(0.08, context),
                                          'google',
                                          'assets/google.svg',
                                          Colors.white),
                                      Container(width: screenW(0.05, context)),
                                      Text(
                                        'Google',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: screenW(0.1, context),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(top: screenW(0.05, context)),
                                padding: EdgeInsets.all(screenW(0.04, context)),
                                width: screenW(0.4, context),
                                height: screenH(0.08, context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: facebook,
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  children: <Widget>[
                                    fireSvgwidthColor(
                                        screenW(0.03, context),
                                        'google',
                                        'assets/facebook.svg',
                                        Colors.white),
                                    Container(width: screenW(0.05, context)),
                                    Text(
                                      'Facebook',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                           */Container(
                            height: screenH(0.08, context),
                            alignment: Alignment.center,
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Passwort vergessen',
                                style:
                                    TextStyle(decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
               progress ==false?Container(): Container(
                  color: Colors.black45,
                  width: screenW(1, context),
                  height: screenH(1, context),
                  child: Center(child: CircularProgressIndicator()),
                )
                      
              ]
            )],
        ),
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
