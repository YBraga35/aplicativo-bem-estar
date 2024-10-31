import 'package:flutter/material.dart';

class HabitosScreen extends StatelessWidget {
  final List<String> trilhas;

  HabitosScreen({required this.trilhas});

  @override
  Widget build(BuildContext context) {
    // Lista de sugestões de hábitos por trilha
    final Map<String, List<String>> habitosPorTrilha = {
      'Fitness': [
        'Caminhar 20 minutos por dia',
        'Fazer 10 abdominais',
      ],
      'Sono': [
        'Dormir mais de 6 horas',
        'Não mexer em telas 1h antes de dormir',
      ],
      'Alimentação': [
        'Comer frutas todos os dias',
        'Beber 2 litros de água por dia',
      ],
      'Hobbies': [
        'Tocar um instrumento por 15 minutos',
        'Desenhar ou pintar uma vez por semana',
      ],
      'Social': [
        'Ligar para um amigo',
        'Participar de um grupo de interesse',
      ],
    };

    return Scaffold(
      backgroundColor: Color(0xFFE0E6EA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo e título
              Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 80,
              ),
              SizedBox(height: 10),
              Text(
                'Escolha Seus Hábitos',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF448D9C),
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Selecione os hábitos de acordo com seus objetivos pessoais. '
                'Esses hábitos ajudarão você a manter suas metas nas trilhas que escolheu.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: 'Raleway',
                ),
              ),
              SizedBox(height: 30),

              // Exibir os hábitos para cada trilha selecionada
              ...trilhas.map((trilha) => buildHabitosSection(trilha, habitosPorTrilha[trilha] ?? [])),
              SizedBox(height: 30),

              // Botão Continuar
              ElevatedButton(
                onPressed: () {
                  // Navegar para próxima tela ou realizar ação desejada
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProximaTela(), // Substitua pela próxima tela
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF193339),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Continuar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }

  // Widget para construir a seção de hábitos de cada trilha
  Widget buildHabitosSection(String trilha, List<String> habitos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trilha,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF448D9C),
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
        SizedBox(height: 10),
        // Botões para cada hábito
        ...habitos.map((habito) => buildHabitoButton(habito)).toList(),
        SizedBox(height: 20),
      ],
    );
  }

  // Widget para cada botão de hábito
  Widget buildHabitoButton(String habito) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          // Ação de adicionar ou remover hábito
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF193339),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                habito,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'Raleway',
                ),
              ),
              SizedBox(width: 10,),
              Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
            ],
        ),
        )
      ),
    );
  }
}

// Substitua pela próxima tela para onde o usuário será redirecionado
class ProximaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Próxima Tela')),
      body: Center(child: Text('Conteúdo da próxima tela')),
    );
  }
}
