import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '/routes/routes.dart';

class BoasVindas extends StatelessWidget {
  const BoasVindas({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F9),
      body: Stack(
        children: [
          // Title with margin-top 80
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: _buildAppName(),
          ),

          // Centralized Welcome Text and Logo
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildWelcomeText(),
                const SizedBox(height: 30),
                _buildLogo(screenWidth, screenHeight),
              ],
            ),
          ),

          // Start Button at approximately Y = 700
          Positioned(
            bottom: 50, // Slight margin-bottom for better spacing
            left: 0,
            right: 0,
            child: Center(
              child: _buildStartButton(context, screenWidth),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget: App Name (Title)
  Widget _buildAppName() {
    return Text(
      'Habitus',
      style: GoogleFonts.raleway(
        textStyle: const TextStyle(
          fontSize: 58,
          fontWeight: FontWeight.w700,
          color: Color(0xFF20434a),
        ),
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Widget: Welcome Text (Subheading)
  Widget _buildWelcomeText() {
    return Column(
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
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 21,
              color: Color(0xFF193339),
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(text: 'Aqui começa sua jornada, em busca de '),
              TextSpan(
                text: 'uma vida mais saudável',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Widget: Logo
  Widget _buildLogo(double screenWidth, double screenHeight) {
    return SvgPicture.asset(
      'assets/icons/logo_3.svg',
      width: screenWidth * 0.5,
      height: screenHeight * 0.20,
      fit: BoxFit.contain,
      semanticsLabel: 'Logo Habitus',
      placeholderBuilder: (BuildContext context) =>
      const CircularProgressIndicator(),
    );
  }

  /// Widget: Start Button
  Widget _buildStartButton(BuildContext context, double screenWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.sobre);
      },
      child: SvgPicture.asset(
        'assets/icons/start_button.svg',
        width: screenWidth * 0.18,
        height: 100,
        fit: BoxFit.contain,
        semanticsLabel: 'Iniciar Jornada',
        placeholderBuilder: (BuildContext context) =>
        const CircularProgressIndicator(),
      ),
    );
  }
}
