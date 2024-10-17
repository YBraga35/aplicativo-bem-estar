import 'package:flutter/material.dart';
import '../boas_vindas.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZenJourney',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BoasVindas(),
    );
  }
}