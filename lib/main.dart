import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Make sure you import this
import 'package:get/get.dart';
import 'package:metroappinflutter/ui/presentation/map/maps_cubi_cubit.dart';
import 'package:metroappinflutter/ui/screen/metroo_screen.dart';
import 'di/di.dart'; // Make sure this includes the necessary dependencies
 // Import your Cubit here

void main() {
  setupDependencies(); // Initialize DI
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapsCubit>(
          create: (context) => getIt<MapsCubit>(), // Ensure you are getting the correct instance
        ),
        // Add other providers if needed
      ],
      child: GetMaterialApp(
        home: MetrooScreen(),
      ),
    );
  }
}
