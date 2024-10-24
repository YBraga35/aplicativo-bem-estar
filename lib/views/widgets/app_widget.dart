import 'package:flutter/material.dart';
import '/routes/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZenJourney',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.boasVindas,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}