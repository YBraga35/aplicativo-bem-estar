import 'package:flutter/material.dart';
import '/routes/routes.dart';

class BoasVindas extends StatelessWidget {
  const BoasVindas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F9),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenHeight = constraints.maxHeight;
          final double screenWidth = constraints.maxWidth;

          return Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container 1: Logo
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.only(top: 50.0),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Container 2: Boas Vindas Text
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: 'Aqui começa sua jornada, em busca de '),
                                  TextSpan(
                                    text: 'uma vida mais saudável',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Container 3: Frutas Image
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0), // Ajuste a margem superior e inferior aqui
                          child: Image.asset(
                            'assets/images/frutas.png',
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
              // Container 4: Button
              Positioned(
                left: 50,
                top: screenHeight * 0.8,
                child: SizedBox(
                  width: 310,
                  height: 66,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.sobre);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 66,
                        vertical: 15,
                      ),
                      backgroundColor: const Color(0xFF448D9C),
                    ),
                    child: const Text(
                      'Vamos começar',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}