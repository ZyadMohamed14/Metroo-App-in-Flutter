import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Make sure you import this
import 'package:get/get.dart';
import 'package:metroappinflutter/language/app-locale_contoller.dart';
import 'package:metroappinflutter/language/app_locale.dart';
import 'package:metroappinflutter/ui/presentation/map/maps_cubi_cubit.dart';
import 'package:metroappinflutter/ui/screen/dashboard_screen.dart';
import 'di/di.dart'; // Make sure this includes the necessary dependencies
import'package:shared_preferences/shared_preferences.dart';
late SharedPreferences sharedPref;
void main() async{
  setupDependencies(); // Initialize DI
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance(); // Get instance
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MyLocalContoller contoller=Get.put(MyLocalContoller());
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapsCubit>(
          create: (context) => getIt<MapsCubit>(),
        ),
        // Add other providers if needed
      ],
      child: GetMaterialApp(
        translations: AppTranslations(),
        locale:contoller.initLanguage ,
        home: DashBoardScreen(),
      ),
    );
  }
}
