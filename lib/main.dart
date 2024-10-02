import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Make sure you import this
import 'package:get/get.dart';
import 'package:metroappinflutter/ui/presentation/map/maps_cubi_cubit.dart';
import 'package:metroappinflutter/ui/screen/dashboard_screen.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen/metroo_screen.dart';
import 'di/di.dart'; // Make sure this includes the necessary dependencies
import 'package:workmanager/workmanager.dart';


void main() {
  setupDependencies(); // Initialize DI
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapsCubit>(
          create: (context) => getIt<MapsCubit>(),
        ),
        // Add other providers if needed
      ],
      child: GetMaterialApp(
        home: DashBoardScreen(),
      ),
    );
  }
}
