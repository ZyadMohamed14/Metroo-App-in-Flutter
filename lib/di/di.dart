import 'package:get_it/get_it.dart';
import 'package:metroappinflutter/ui/presentation/map/maps_cubi_cubit.dart';

import '../data/remote/locatio_repo_impl.dart';
import '../data/remote/location_service.dart';


final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Register the LocationService as a singleton
  getIt.registerLazySingleton<LocationWebservices>(() => LocationWebservices());

  // Register the LocationRepoImpl as a singleton
  getIt.registerLazySingleton<MapsRepository>(
        () => MapsRepository(getIt<LocationWebservices>()),
  );

  // Register the LocationCubit as a factory (can create multiple instances)
  getIt.registerFactory<MapsCubit>(
        () => MapsCubit(getIt<MapsRepository>()),
  );
}
