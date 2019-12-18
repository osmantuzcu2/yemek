
import 'package:flutter/widgets.dart';

class Constants {
  static const generalBaseUrl = 'http://yemek.workwork.online';
  //SharedPreferenses
  static const String SHARED_CURRENT_USER = "currentUser";
  static const String SHARED_MUCF_SKIN_COLOR = "mucfskincolor";
  static const String SHARED_MUCF_SKIN_TYPE = "mucfskintype";
  static const String SHARED_MUCF_SKIN_PROBLEM = "mucfskinproblem";
  static const String SHARED_MUCF_NATIONALITY = "mucfnationality";

  //ROUTES
  static const String ROUTE_LANDING_PAGE = "/";
  static const String ROUTE_REGISTER= "/register";
  static const String ROUTE_HOME_PAGE = "/homepage";
  static const String ROUTE_COME_GET = "/comeget";
  static const String ROUTE_HOME_SERVICE = "/homeservice";
  static const String ROUTE_RESERVATION_LIST = "/reservation";
  static const String ROUTE_RESERVATION_ADD = "/reservation_add";
  static const String ROUTE_PRODUCT_LIST = "/product_list";
  static const String ROUTE_PRODUCT_DETAILS = "/product_details";
  static const String ROUTE_PRODUCT_BASKET = "/basket";
  static const String ROUTE_SPLASH1 = "/splash1";
  static const String ROUTE_SPLASH2= "/splash2";
  static const String ROUTE_PROFILE= "/profile";
  static const String ROUTE_PASSWORD= "/password";
  static const String ROUTE_EDIT_PROFILE= "/editprofile";
  static const String ROUTE_ORDER_HISTORY= "/orderhistory";
  static const String ROUTE_ADDRESS= "/address";
  static const String SEARCH= "/search";
  


  //Colors
  final Color green1 = HexColor("#3FA535");

  //Hatalar
  static const String EKSIK_BILGI= "Füllen Sie die Informationen aus";
  static const String PASS_FARKLI= "Passwortabgleich fehlgeschlagen";
  

}
//Colors
final Color green1 = HexColor("#3FA535");
final Color blue1 = HexColor("#245FAA");
final Color red1 = HexColor("#FF4646");
final Color grey1 = HexColor("#979797");

final Color google = HexColor("#FF4646");
final Color facebook = HexColor("#6197FF");
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}




