import 'package:flutter/cupertino.dart';
import 'package:flutter_task/services/rest_api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import 'connectivity_service.dart';
import 'secure_storage_service.dart';

final locator = GetIt.instance;
bool configured = false;

Future<void> setupDependencies() async {
  if (!configured) {
    await GetStorage.init();
    WidgetsFlutterBinding.ensureInitialized();

    // Secure local data storage Service initialization
    var secureStorageService = await SecureStorageService.getInstance();
    await secureStorageService.initialise();
    locator.registerSingleton<SecureStorageService>(secureStorageService);

   //Internet connectivity
    var connectivityService = await ConnectivityService.getInstance();
    await connectivityService.initialise();
    locator.registerSingleton(connectivityService);

    //Api Calling
    var restApiService = await RestApiService.getInstance();
    await restApiService.initialise(connectivityService);
    locator.registerSingleton(restApiService);

    // stores:--------------------------------------------------------------------
    // locator.registerSingleton(LanguageStore());
  }
}
