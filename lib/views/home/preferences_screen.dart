import 'package:flutter/material.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Tela de Preferências',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Color(0xFF193339),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: Text('Configuração 1')),
          ),
          const SizedBox(height: 10),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: Text('Configuração 2')),
          ),
        ],
      ),
    );
  }
}