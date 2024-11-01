import 'package:flutter/material.dart';
import '/routes/routes.dart';

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFE0E6EA),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        width: screenWidth,
        height: screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: screenWidth * 0.6,
              height: screenHeight * 0.15,
            ),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Raleway',
                  color: Color(0xFF193339),
                ),
                children: [
                  TextSpan(text: 'O '),
                  TextSpan(
                    text: 'Zen Journey',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' é um '),
                  TextSpan(
                    text: 'aplicativo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          ' dedicado a ajudar você a alcançar uma '),
                  TextSpan(
                    text: 'vida melhor',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' através de '),
                  TextSpan(
                    text: 'pequenas mudanças diárias',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '. Nossa '),
                  TextSpan(
                    text: 'missão',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' é guiá-lo em uma '),
                  TextSpan(
                    text: 'jornada',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' de '),
                  TextSpan(
                    text: 'autodescoberta',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' e '),
                  TextSpan(
                    text: 'bem-estar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ', fornecendo '),
                  TextSpan(
                    text: 'ferramentas',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' e '),
                  TextSpan(
                    text: 'recursos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' para melhorar sua '),
                  TextSpan(
                    text: 'saúde mental, física e emocional',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '.'),
                ],
              ),
            ),
            Text(
              'Propósito',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: Color(0xFF193339),
              ),
              textAlign: TextAlign.center,
            ),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Raleway',
                  color: Color(0xFF193339),
                ),
                children: [
                  TextSpan(text: 'Nosso '),
                  TextSpan(
                    text: 'propósito',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          ' é criar um ambiente onde você possa crescer e se desenvolver de maneira '),
                  TextSpan(
                    text: 'saudável',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' e '),
                  TextSpan(
                    text: 'sustentável',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          '. Acreditamos que '),
                  TextSpan(
                    text: 'pequenas mudanças',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          ' podem ter um grande impacto ao longo do tempo, e estamos aqui para apoiar você em cada passo dessa '),
                  TextSpan(
                    text: 'jornada',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '.'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.authenticate);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.2,
                  vertical: 15,
                ),
                backgroundColor: const Color(0xFF448D9C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Criar Conta',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}