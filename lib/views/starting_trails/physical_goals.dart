import 'package:flutter/material.dart';

class PhysicalGoalsScreen extends StatefulWidget {
  const PhysicalGoalsScreen({super.key});

  @override
  _PhysicalGoalsScreenState createState() => _PhysicalGoalsScreenState();
}

class _PhysicalGoalsScreenState extends State<PhysicalGoalsScreen> {
  final List<String> goals = [
    "Exercitar-se 3x por semana",
    "Beber 2L de água diariamente",
    "Fazer alongamentos diariamente",
    "Participar de uma atividade física em grupo"
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
            Text('Físico', style: _subtitleStyle()),
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