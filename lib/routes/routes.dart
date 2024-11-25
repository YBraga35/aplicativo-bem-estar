import 'package:flutter/material.dart';
import '../views/home/edit_habit.dart';
import '../views/start/boas_vindas.dart';
import '../views/start/sobre.dart';
import '../views/start/authenticate.dart';
import '../views/start/register.dart';
import '../views/starting_trails/trail_preference.dart';
import '../views/starting_trails/habits_selection.dart';
import '../views/home/home.dart';

class AppRoutes {
  static const String boasVindas = '/';
  static const String sobre = '/sobre';
  static const String authenticate = '/authenticate';
  static const String register = '/register';
  static const String trailPreference = '/trailPreference';
  static const String habitsSelection = '/habitsSelection';
  static const String home = '/home';
  static const String editHabit = '/editHabit/:id';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case boasVindas:
        return _createRoute(
          const BoasVindas(),
          duration: const Duration(milliseconds: 800),
        );
      case sobre:
        return _createRoute(
          const Sobre(),
          duration: const Duration(milliseconds: 800),
        );
      case authenticate:
        return _createRoute(
          const Authenticate(),
          duration: const Duration(milliseconds: 800),
        );
      case register:
        return _createRoute(
          const Register(),
          duration: const Duration(milliseconds: 600),
        );
      case trailPreference:
        return _createRoute(
          const Trilhas(),
          duration: const Duration(milliseconds: 600),
        );
      case habitsSelection:
        return _createRoute(
          HabitsScreen(trails: settings.arguments as List<String>),
          duration: const Duration(milliseconds: 600),
        );
      case editHabit:
        return _createRoute(
          EditHabitView(
          habitName: (settings.arguments as List)[0] as String,
          habitDescription: (settings.arguments as List)[1] as String,
          habitTrack: (settings.arguments as List)[2] as String,
        ));
      case home:
        return _createRoute(
          const HomeScreen(),
          duration: const Duration(milliseconds: 600),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'Rota não definida para ${settings.name}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        );
    }
  }

  static PageRouteBuilder _createRoute(Widget page, {Duration? duration}) {
    return PageRouteBuilder(
      transitionDuration: duration ?? const Duration(milliseconds: 500),
      reverseTransitionDuration: duration ?? const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Fade animation with smooth easing
        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ).drive(Tween<double>(begin: 0.0, end: 1.0));

        // Slide animation with cubic easing
        final slideAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutCubic,
        ).drive(
          Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ),
        );

        // Combined animations
        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
      maintainState: true,
    );
  }
}
