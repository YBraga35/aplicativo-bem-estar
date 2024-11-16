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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            // Center the content vertically
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: screenWidth * 0.6,
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Sobre o Zen Journey
              _buildSectionTitle('O Zen Journey'),
              SizedBox(height: 8),
              _buildSectionContent(
                'O Zen Journey é um aplicativo dedicado a ajudar você a alcançar uma vida mais saudável através de pequenas mudanças diárias. Nossa missão é guiar você em uma jornada de autodescoberta e bem-estar, fornecendo ferramentas e recursos para melhorar sua saúde mental, física e emocional.',
              ),
              SizedBox(height: 15),
              // Propósito
              _buildSectionTitle('Propósito'),
              SizedBox(height: 8),
              _buildSectionContent(
                'Acreditamos que pequenas mudanças podem ter um grande impacto ao longo do tempo, e estamos aqui para apoiar você em cada passo dessa jornada.',
              ),
              SizedBox(height: 15,),
              // Botão Criar Conta
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.authenticate);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.25,
                    vertical: 12,
                  ),
                  backgroundColor: Color(0xFF448D9C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Criar Conta',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        )
      ),
    );
  }

  // Widget para o título das seções
  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          color: Color(0xFF193339),
        ),
      ),
    );
  }

  // Widget para o conteúdo das seções com palavras em negrito
  Widget _buildSectionContent(String content) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Raleway',
            color: Color(0xFF193339),
            height: 1.5,
          ),
          children: _buildRichText(content),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  // Função para criar TextSpans com palavras em negrito
  List<TextSpan> _buildRichText(String content) {
    // Lista de palavras a serem destacadas em negrito
    List<String> boldWords = [
      'Zen Journey',
      'aplicativo',
      'missão',
      'autodescoberta',
      'bem-estar',
      'saúde mental',
      'física',
      'emocional',
      'propósito',
      'ambiente',
      'saudável',
      'sustentável',
      'mudanças',
      'impacto',
      'jornada',
    ];

    List<TextSpan> spans = [];
    String remaining = content;

    while (remaining.isNotEmpty) {
      // Encontrar o próximo índice de qualquer palavra em negrito
      int nearestIndex = remaining.length;
      String? nearestWord;
      for (String word in boldWords) {
        int index = remaining.toLowerCase().indexOf(word.toLowerCase());
        if (index != -1 && index < nearestIndex) {
          nearestIndex = index;
          nearestWord = word;
        }
      }

      if (nearestWord == null) {
        // Nenhuma palavra em negrito encontrada, adicionar o restante do texto
        spans.add(TextSpan(text: remaining));
        break;
      }

      if (nearestIndex > 0) {
        // Adicionar o texto antes da palavra em negrito
        spans.add(TextSpan(text: remaining.substring(0, nearestIndex)));
      }

      // Adicionar a palavra em negrito
      int wordLength = nearestWord.length;
      spans.add(
        TextSpan(
          text: remaining.substring(nearestIndex, nearestIndex + wordLength),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      // Atualizar o texto restante
      remaining = remaining.substring(nearestIndex + wordLength);
    }

    return spans;
  }
}