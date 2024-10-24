import 'package:flutter/material.dart';
import '../views/start/boas_vindas.dart';
import '../views/start/sobre.dart';
import '../views/start/authenticate.dart';
import '../views/start/register.dart';
import '../views/starting_trails/trail_preference.dart';
import '../views/starting_trails/physical_goals.dart';
import '../views/starting_trails/hobbies_goals.dart';
import '../views/starting_trails/nutrition_goals.dart';
import '../views/starting_trails/sleep_goals.dart';
import '../views/starting_trails/social_goals.dart';
// Importe outras telas conforme necessário

class AppRoutes {
  static const String boasVindas = '/';
  static const String sobre = '/sobre';
  static const String authenticate = '/authenticate';
  static const String register = '/register';
  static const String trailPreference = '/trailPreference';
  static const String physicalGoals = '/physicalGoals';
  static const String hobbiesGoals = '/hobbiesGoals';
  static const String nutritionGoals = '/nutritionGoals';
  static const String sleepGoals = '/sleepGoals';
  static const String socialGoals = '/socialGoals';
  // Adicione outras rotas conforme necessário

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case boasVindas:
        return MaterialPageRoute(builder: (_) => const BoasVindas());
      case sobre:
        return MaterialPageRoute(builder: (_) => const Sobre());
      case authenticate:
        return MaterialPageRoute(builder: (_) => const Authenticate());
      case register:
        return MaterialPageRoute(builder: (_) => const Register());
      case trailPreference:
        return MaterialPageRoute(builder: (_) => const Trilhas());
      case physicalGoals:
        return MaterialPageRoute(builder: (_) => const PhysicalGoalsScreen());
      case hobbiesGoals:
        return MaterialPageRoute(builder: (_) => const HobbiesGoalsScreen());
      case nutritionGoals:
        return MaterialPageRoute(builder: (_) => const NutritionGoalsScreen());
      case sleepGoals:
        return MaterialPageRoute(builder: (_) => const SleepGoalsScreen());
      case socialGoals:
        return MaterialPageRoute(builder: (_) => const SocialGoalsScreen());
      // Adicione outras rotas conforme necessário
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
}