import 'package:flutter/foundation.dart';
enum ViewState{Idle,Busy}
 class LoginModel extends ChangeNotifier{
   ViewState _state = ViewState.Idle;
   ViewState get state => _state;
   void setState(ViewState viewState){
     _state = viewState;
     notifyListeners();
   }
 }