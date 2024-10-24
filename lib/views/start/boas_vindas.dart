import 'package:flutter/material.dart';
import '/routes/routes.dart';

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
                  margin: EdgeInsets.only(top: 100.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 412,
                    height: 135,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Boas Vindas',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF448D9C),
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 21,
                      color: Color(0xFF193339),
                      fontFamily: 'Raleway', // Ajuste para a família de fontes correta
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Aqui começa sua jornada, onde a cada passo te aproxima de seu objetivo: '),
                      TextSpan(
                        text: 'uma vida melhor',
                        style: TextStyle(fontWeight: FontWeight.bold), // Aplica o negrito aqui
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center, // Alinhamento do texto
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
                    Navigator.pushNamed(context, AppRoutes.sobre);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: 15,
                    ),
                    backgroundColor: const Color(0xFF448D9C),
                  ),
                  child: const Text(
                    'Vamos começar',
                    style: TextStyle(
                      fontFamily: 'Raleway', // Definindo a fonte para Raleway
                      fontSize: 22,          // Alterando o tamanho da fonte
                      fontWeight: FontWeight.bold, // Definindo o estilo como negrito
                      color: Colors.white,   // Cor do texto, se necessário
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}