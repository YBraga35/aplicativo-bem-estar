import 'package:flutter/material.dart';
import '/routes/routes.dart';

class Trilhas extends StatelessWidget {
  const Trilhas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E6EA), // Cor de fundo da tela
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 400,
                height: 100,
              ),
              const SizedBox(height: 10),
              const Text(
                'Trilhas',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF448D9C),
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Aqui você escolherá qual\nseu progresso ao longo\ndo caminho',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Raleway'
                ),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 20.0,
                runSpacing: 14.0,
                alignment: WrapAlignment.center,
                children: [
                  buildElevatedButton(Icons.fitness_center, 'Físico', () {
                    Navigator.pushNamed(context, AppRoutes.physicalGoals);
                  }),
                  buildElevatedButton(Icons.bedtime, 'Sono', () {
                    // Ação específica
                  }),
                  buildElevatedButton(Icons.restaurant, 'Nutrição', () {
                    // Ação específica
                  }),
                  buildElevatedButton(Icons.music_note, 'Hobbies', () {
                    // Ação específica
                  }),
                  buildElevatedButton(Icons.groups, 'Social', () {
                    // Ação específica
                  }),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Passar para próxima tela
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF193339), // Cor do botão
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Continuar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } 
}

Widget buildElevatedButton(IconData icon, String label, void Function() onPressed) {
  return SizedBox(
    width: 102,
    height: 109,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF448D9C),
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: const Color.fromARGB(255, 5, 54, 48),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontFamily: 'Raleway'
            ),
          ),
        ],
      ),
    ),
  );
}