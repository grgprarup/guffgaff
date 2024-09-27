import 'package:flutter/material.dart';
import 'package:guffgaff/src/screens/login_screen.dart';
import 'package:guffgaff/src/screens/signup_screen.dart';
import 'package:guffgaff/src/screens/home_screen.dart';

class NavigationService {
  late GlobalKey<NavigatorState> _navigatorKey;
  final Map<String, Widget Function(BuildContext)> _routes = {
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignUpScreen(),
    '/home': (context) => const HomeScreen(),
  };

  GlobalKey<NavigatorState>? get navigatorKey {
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  NavigationService() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void pushNamed(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }
}
