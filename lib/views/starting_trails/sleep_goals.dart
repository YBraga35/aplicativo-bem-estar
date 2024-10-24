import 'package:flutter/material.dart';

class SleepGoalsScreen extends StatefulWidget {
  const SleepGoalsScreen({super.key});

  @override
  _SleepGoalsScreenState createState() => _SleepGoalsScreenState();
}

class _SleepGoalsScreenState extends State<SleepGoalsScreen> {
  final List<String> goals = [
    "Dormir 8 horas por noite",
    "Manter um horário de sono regular",
    "Evitar telas antes de dormir",
    "Criar uma rotina relaxante antes de dormir"
  ];

  List<bool> selectedGoals = List.filled(4, false);

  void saveSelectedGoals() {
    // Lógica para salvar as metas selecionadas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/logo.png', height: 100),
            ),
            const SizedBox(height: 20),
            Text('Trilhas', style: _subtitleStyle()),
            const SizedBox(height: 20),
            Text('Sono', style: _subtitleStyle()),
            const SizedBox(height: 10),
            Text('Escolha agora quais metas você deseja se empenhar em cumprir.', style: _detailsStyle()),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: goals.length,
              itemBuilder: (context, index) {
                return _goalTile(index);
              },
            ),
            const SizedBox(height: 20),
            _navigationButtons(context),
          ],
        ),
      ),
    );
  }

  TextStyle _subtitleStyle() {
    return const TextStyle(fontFamily: 'Raleway', fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF193339));
  }

  TextStyle _detailsStyle() {
    return const TextStyle(fontFamily: 'Raleway', fontSize: 22, color: Color(0xFF193339));
  }

  Widget _goalTile(int index) {
    return CheckboxListTile(
      title: Text(goals[index], style: const TextStyle(fontFamily: 'Raleway', fontSize: 22, color: Color(0xFF193339))),
      value: selectedGoals[index],
      onChanged: (bool? value) {
        setState(() {
          selectedGoals[index] = value ?? false;
        });
      },
      activeColor: const Color(0xFF49AB8C),
      checkColor: Colors.white,
      controlAffinity: ListTileControlAffinity.leading,
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