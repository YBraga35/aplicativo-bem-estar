import 'package:bem_estar_app/views/boas_vindas.dart'; // Ensure this import matches the file where BoasVindas is defined
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Boas-Vindas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Definindo a tela de boas-vindas como a tela inicial
      home: const BoasVindas(),
    );
  }
}