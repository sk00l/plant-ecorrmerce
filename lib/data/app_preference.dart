import 'package:plant_ecommerce/configs/locator/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference{
  SharedPreferences sharedPreferences = getIt.get<SharedPreferences>();


  save(){
  sharedPreferences.setString(key, value)
 }
}