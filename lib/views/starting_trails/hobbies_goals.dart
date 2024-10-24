import 'package:flutter/material.dart';

class HobbiesGoalsScreen extends StatefulWidget {
  const HobbiesGoalsScreen({super.key});

  @override
  _HobbiesGoalsScreenState createState() => _HobbiesGoalsScreenState();
}

class _HobbiesGoalsScreenState extends State<HobbiesGoalsScreen> {
  final List<String> goals = [
    "Ler um livro por mês",
    "Aprender a tocar um instrumento",
    "Desenhar ou pintar semanalmente",
    "Participar de um clube de hobbies"
  ];
  
  List<bool> selectedGoals = List.filled(4, false);

  void saveSelectedGoals() {
    // Lógica para salvar as metas selecionadas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F9),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trilhas', style: _titleStyle()),
            const SizedBox(height: 20),
            Text('Hobbies', style: _subtitleStyle()),
            const SizedBox(height: 10),
            Text('Escolha agora quais metas você deseja se empenhar em cumprir.', style: _detailsStyle()),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return _goalTile(index);
                },
              ),
            ),
            _navigationButtons(context),
          ],
        ),
      ),
    );
  }

  TextStyle _titleStyle() {
    return const TextStyle(fontFamily: 'Tangerine', fontSize: 96, color: Color(0xFF193339));
  }

  TextStyle _subtitleStyle() {
    return const TextStyle(fontFamily: 'Raleway', fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF193339));
  }

  TextStyle _detailsStyle() {
    return const TextStyle(fontFamily: 'Raleway', fontSize: 22, color: Color(0xFF193339));
  }

  Widget _goalTile(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGoals[index] = !selectedGoals[index];
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selectedGoals[index] ? const Color(0xFF49AB8C) : const Color(0xFF448D9C),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(goals[index], style: const TextStyle(fontFamily: 'Raleway', fontSize: 22, color: Colors.white)),
            Icon(selectedGoals[index] ? Icons.check_circle : Icons.radio_button_unchecked, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _navigationButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Voltar')),
        ElevatedButton(
          onPressed: () {
            saveSelectedGoals();
            Navigator.pushNamed(context, '/nextScreen'); // Troque para o próximo nome de tela
          },
          child: const Text('Continuar'),
        ),
      ],
    );
  }
}