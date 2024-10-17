import 'package:flutter/material.dart';
import 'sobre.dart';

class BoasVindas extends StatelessWidget {
  const BoasVindas({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F9),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: screenHeight * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Boas Vindas',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF448D9C),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Aqui começa sua jornada, onde a cada passo te aproxima de seu objetivo: uma vida melhor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF193339),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/frutas.png',
                  height: screenHeight * 0.25,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Sobre()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: 15,
                    ),
                    backgroundColor: const Color(0xFF49AB8C),
                  ),
                  child: const Text('Vamos começar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}