import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Tela de Perfil',
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
            child: const Center(child: Text('Informação 1')),
          ),
          const SizedBox(height: 10),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: Text('Informação 2')),
          ),
        ],
      ),
    );
  }
}