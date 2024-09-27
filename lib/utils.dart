import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:guffgaff/firebase_options.dart';
import 'package:guffgaff/src/services/authentication_service.dart';
import 'package:guffgaff/src/services/media_service.dart';
import 'package:guffgaff/src/services/navigation_service.dart';
import 'package:guffgaff/src/services/storage_service.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthenticationService>(
    AuthenticationService(),
  );
  getIt.registerSingleton<MediaService>(
    MediaService(),
  );
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  getIt.registerSingleton<StorageService>(
    StorageService(),
  );
}
