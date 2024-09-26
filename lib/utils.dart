import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:guffgaff/firebase_options.dart';
import 'package:guffgaff/src/services/authentication_service.dart';

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
}
