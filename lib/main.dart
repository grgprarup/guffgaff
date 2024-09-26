import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guffgaff/src/screens/home_screen.dart';
import 'package:guffgaff/src/screens/login_screen.dart';
import 'package:guffgaff/src/services/authentication_service.dart';
import 'package:guffgaff/utils.dart';

void main() async {
  await setup();
  runApp(MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerServices();
}

class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;
  late AuthenticationService _authenticationService;

  MyApp({super.key}) {
    _authenticationService = _getIt.get<AuthenticationService>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guff Gaff',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF19B0E7),
          secondary: Color(0xFF7D7D7D),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: _authenticationService.user != null ? HomeScreen() : LoginScreen(),
    );
  }
}
