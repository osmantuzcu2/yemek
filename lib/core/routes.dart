
import 'package:mc_jsi/ui/screens/adres.dart';
import 'package:mc_jsi/ui/screens/eve_servis.dart';
import 'package:mc_jsi/ui/screens/gel_al.dart';
import 'package:mc_jsi/ui/screens/home.dart';
import 'package:mc_jsi/ui/screens/product_details.dart';
import 'package:mc_jsi/ui/screens/product_list.dart';
import 'package:mc_jsi/ui/screens/profil_duzenle.dart';
import 'package:mc_jsi/ui/screens/profile.dart';
import 'package:mc_jsi/ui/screens/profile_pass.dart';
import 'package:mc_jsi/ui/screens/register.dart';
import 'package:mc_jsi/ui/screens/rezervasyon.dart';
import 'package:mc_jsi/ui/screens/rezervasyon_listele.dart';
import 'package:mc_jsi/ui/screens/search.dart';
import 'package:mc_jsi/ui/screens/sepet.dart';
import 'package:mc_jsi/ui/screens/siparis_gecmisi.dart';
import 'package:mc_jsi/ui/screens/splash.dart';
import 'package:mc_jsi/ui/screens/splash2.dart';
import 'constants.dart';
import 'package:flutter/material.dart';

class Routes {
  static final routes = <String, WidgetBuilder> {
    Constants.ROUTE_LANDING_PAGE : (BuildContext context) => Home(),
    Constants.ROUTE_HOME_PAGE : (BuildContext context) => Home(),
    Constants.ROUTE_REGISTER : (BuildContext context) => Register(),
    Constants.ROUTE_SPLASH1 : (context)=> Splash1(),
    Constants.ROUTE_SPLASH2 : (context)=> Splash2(),
    Constants.ROUTE_COME_GET : (context)=> ComeGet(),
    Constants.ROUTE_HOME_SERVICE : (context)=> HomeService(),
    Constants.ROUTE_RESERVATION_LIST : (context)=> ReservationList(),
    Constants.ROUTE_RESERVATION_ADD : (context)=> ReservationAdd(),
    Constants.ROUTE_PRODUCT_LIST : (context)=> ProductList(),
    Constants.ROUTE_PRODUCT_DETAILS : (context)=> ProductDetails(),
    Constants.ROUTE_PRODUCT_BASKET : (context)=> Basket(),
    Constants.ROUTE_PROFILE : (context)=> Profile(),
    Constants.ROUTE_PASSWORD : (context)=> Password(),
    Constants.ROUTE_EDIT_PROFILE : (context)=> EditProfile(),
    Constants.ROUTE_ORDER_HISTORY : (context)=> OrderHistory(),
    Constants.ROUTE_ADDRESS : (context)=> Address(),
    Constants.SEARCH : (context)=> Search(),
    
  };
}