import 'package:flutter/material.dart';
import '../views/start/boas_vindas.dart';
import '../views/start/sobre.dart';
import '../views/start/authenticate.dart';
import '../views/start/register.dart';
import '../views/starting_trails/trail_preference.dart';
import '../views/starting_trails/habits_selection.dart';
import '../views/home/home.dart'; // Import the new home screen

class AppRoutes {
  static const String boasVindas = '/';
  static const String sobre = '/sobre';
  static const String authenticate = '/authenticate';
  static const String register = '/register';
  static const String trailPreference = '/trailPreference';
  static const String habitsSelection = '/habitsSelection';
  static const String home = '/home'; // Add the new route

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case boasVindas:
        return _createRoute(const BoasVindas());
      case sobre:
        return _createRoute(const Sobre());
      case authenticate:
        return _createRoute(const Authenticate());
      case register:
        return _createRoute(const Register());
      case trailPreference:
        return _createRoute(const Trilhas());
      case habitsSelection:
        return _createRoute(HabitsScreen(trails: settings.arguments as List<String>));
      case home:
        return _createRoute(const HomeScreen()); // Add the new route case
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Rota não definida para ${settings.name}'),
            ),
          ),
        );
    }
  }

  static PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}