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