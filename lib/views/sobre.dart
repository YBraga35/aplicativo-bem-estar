import 'package:flutter/material.dart';
import 'authenticate.dart';

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SOBRE TESTE'),
        backgroundColor: const Color(0xFF448D9C),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05),

              Center(
                child: const Text(
                  'Zen Journey',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF193339),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'O Zen Journey é um aplicativo dedicado a ajudar você a alcançar uma vida melhor através de pequenas mudanças diárias. Nossa missão é guiá-lo em uma jornada de autodescoberta e bem-estar, fornecendo ferramentas e recursos para melhorar sua saúde mental, física e emocional.',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF193339),
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: screenHeight * 0.05),

              Center(
                child: const Text(
                  'Propósito',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF193339),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                'Nosso propósito é criar um ambiente onde você possa crescer e se desenvolver de maneira saudável e sustentável. Acreditamos que pequenas mudanças podem ter um grande impacto ao longo do tempo, e estamos aqui para apoiar você em cada passo dessa jornada.',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF193339),
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: screenHeight * 0.05),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Authenticate()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: 15,
                    ),
                    backgroundColor: const Color(0xFF448D9C),
                  ),
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
