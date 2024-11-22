import 'package:flutter/material.dart';

class HabitsScreen extends StatefulWidget {
  final List<String> trails;

  const HabitsScreen({super.key, required this.trails});

  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  Map<String, List<String>> habitsByTrail = {
    'Fitness': [
      'Fazer exercício aeróbico (caminhar,bicicleta) 30 minutos, 5 dias por semana',
      'Levantar e caminhar por 2 minutos a cada hora',
      'Fazer 3 treinos de força por semana',
      'Fazer 3 treinos de equilíbrio por semana',
      'Fazer uma caminhada após às refeições principais'
    ],
    'Sono': [
      'Dormir entre 7 e 9 horas',
      'Parar de tomar café, chimarrão e chá preto às 14:00 ou 8 horas antes de dormir',
      'Não beber álcool durante a semana',
      'Parar de usar telas com alta luminosidade 2 horas antes de dormir',
      'Não ingerir alimentos pesados ao menos 2 horas antes de dormir'
    ],
    'Alimentação': [
      'Comer 3 tipos de fruta',
      'Comer 3 tipos de legume/salada',
      'Tomar 1.5L de água pura por dia',
      'Trocar o refrigerante por água com gás'
    ],
    'Hobbies': [
      'Estudar violão uma vez por semana',
      'Estudar piano uma vez por semana',
      'Cantar uma vez por semana',
      'Ler um livro durante uma hora por semana',
      'Jogar futebol uma vez por semana',
      'Jogar vôlei uma vez por semana'
    ],
    'Social': [
      'Jogar futebol uma vez por semana',
      'Jogar vôlei uma vez por semana',
      'Ligar para um amigo no final de semana',
      'Tomar um café com colegas pelo menos uma vez na semana'
    ],
  };

  Map<String, Set<String>> selectedHabits = {};

  @override
  void initState() {
    super.initState();
    for (var trail in widget.trails) {
      selectedHabits[trail] = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe0e6ea),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/images/logo.png',
              width: 150,
              height: 60,
            ),
            SizedBox(height: 10),
            Text(
              'Hábitos Sugeridos',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF448D9C),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: 'Raleway',
                  ),
                  children: [
                    TextSpan(text: 'Selecione os hábitos de acordo com seus '),
                    TextSpan(
                      text: 'objetivos pessoais',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            '. Esses hábitos ajudarão você a manter suas metas nas trilhas que escolheu.'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  ...widget.trails.map((trail) => buildExpansionTile(trail)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF193339),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Voltar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF193339),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildExpansionTile(String trail) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 3,
      child: ExpansionTile(
        title: Text(
          trail,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF448D9C),
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),
        ),
        children: habitsByTrail[trail]!.map((habit) {
          bool isSelected = selectedHabits[trail]!.contains(habit);
          return ListTile(
            tileColor: isSelected ? Color(0xFF193339) : Color(0xFF448D9C),
            title: Text(
              habit,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.white,
                fontFamily: 'Raleway',
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                isSelected ? Icons.check_circle : Icons.add_circle_outline,
                color: isSelected ? Colors.greenAccent : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (isSelected) {
                    selectedHabits[trail]!.remove(habit);
                  } else {
                    selectedHabits[trail]!.add(habit);
                  }
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}