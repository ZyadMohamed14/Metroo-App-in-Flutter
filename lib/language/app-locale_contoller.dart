import 'dart:ui';

import 'package:get/get.dart';
import 'package:metroappinflutter/main.dart';

import 'package:shared_preferences/shared_preferences.dart';
class MyLocalContoller extends GetxController{
  Locale? initLanguage = sharedPref.getString('lang')==null?Get.deviceLocale:Locale('lang');

  void changeLang(String languageCode)async{

    final  local  =Locale(languageCode);
    sharedPref.setString('lang',languageCode);
    Get.updateLocale(local);
  }
}