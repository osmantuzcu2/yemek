import 'package:get_it/get_it.dart';
import 'core/models/login_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(()=>LoginModel());
}