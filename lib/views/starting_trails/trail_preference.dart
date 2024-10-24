import 'package:flutter/material.dart';
import '/routes/routes.dart';

class Trilhas extends StatelessWidget {
  const Trilhas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E6EA), // Cor de fundo da tela
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Center(
            child: SizedBox(
              width: 300,
              height: 150,
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Título "Trilhas"
          const Text(
            'Trilhas',
            style: TextStyle(
              fontSize: 30,
              color: Color(0xFF448D9C),
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),

          // Texto descritivo
          const Text(
            'Aqui você escolherá qual\nseu progresso ao longo\ndo caminho',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Raleway',
            ),
          ),
          const SizedBox(height: 30), // Espaço entre o texto e os botões

          // Botões de trilhas centralizados
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Wrap(
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
            ),
          ),

          // Botão de Continuar
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                // Ação do botão
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF193339),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Função para construir os botões
Widget buildElevatedButton(IconData icon, String label, void Function() onPressed) {
  return SizedBox(
    width: 120,
    height: 120,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF448D9C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                fontFamily: 'Raleway',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
