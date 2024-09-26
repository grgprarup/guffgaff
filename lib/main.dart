import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guffgaff/src/screens/login_screen.dart';

void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: LoginScreen(),
    );
  }
}
