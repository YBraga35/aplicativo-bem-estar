import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HabitsScreen extends StatefulWidget {
  final List<String> trails;

  const HabitsScreen({super.key, required this.trails});

  @override
  _HabitsScreenState createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  Map<String, List<Map<String, String>>> habitsByTrail = {
    'Fitness': [
      {
        'name': 'Fazer exercício (30 minutos)',
        'description': 'É indicado que se faça 30min de exercício. São necessários ao menos 30 minutos por vez para que tenhamos os melhores benefícios à saude.'
      },
      {
        'name': 'Tirar pequenos intervalos ao longo do dia',
        'description': "Tirar pequenos intervalos durante o dia ajuda a reduzir o impacto do sedentarismo, melhora a circulação, alivia o estresse e aumenta a produtividade no trabalho ou nos estudos."
      },
      {
        'name': 'Caminhar após o almoço (15 min)',
        'description': 'Caminhar lentamente ou moderadamente logo após refeições pesadas diminui picos de glicemia, o que pode ajudar com manutenção do peso e principalmente no controle de diabetes.'
      },
    ],
    'Sono': [
      {
        'name': 'Dormir entre 7 e 9 horas',
        'description': 'Menos de 1% da população consegue atingir funcionamento cognitivo normal com menos de 7 horas de sono. 1 hora de privação de sono apenas em um dia diminui reflexos e cognição de forma equivalente a estar sob influência de álcool. E a longo prazo, dormir menos de 7 horas está associado com alzheimer e declínio cognitivo precoce.'
      },
      {
        'name': 'Parar de tomar café, chimarrão e chá preto às 14:00 ou 8 horas antes de dormir',
        'description': 'A cafeína pode afetar a sonolência e qualidade do sono de muitas pessoas'
      },
      {
        'name': 'Parar de usar telas com alta luminosidade 2 horas antes de dormir',
        'description': 'A diminuição de luminosidade (principalmente luz azul) ao final do dia sinaliza para o nosso corpo que deve se preparar para uma noite de recuperação, facilitando sentimento de sono. Quando usamos aparelhos com alta luminosidade, isso pode alterar a nossa percepção natural, tornando mais difícil "pegar no sono". Coloque filtro de luz azul no seu celular e evite contato direto com luzes brancas na casa.'
      },
      {
        'name': 'Não ingerir alimentos pesados ao menos 2 horas antes de dormir',
        'description': 'Um estômago cheio pode afetar a qualidade do sono, além de contribuir para refluxo gástrico e indigestão.'
      },
    ],
    'Alimentação': [
      {
        'name': 'Comer 3 tipos de fruta',
        'description': 'A chave para um intestino funcionando e uma microbiota saudável é variedade de frutas e legumes na dieta.'
      },
      {
        'name': 'Comer 3 tipos de legume ou salada',
        'description': 'A chave para um intestino funcionando e uma microbiota saudável é variedade de frutas e legumes na dieta.'
      },
      {
        'name': 'Tomar 1.5L de água',
        'description': 'Hidratação é bom de todas as formas. Mas é importante incluir água nesta lista, principalmente em dias quentes.'
      },
      {
        'name': 'Trocar o refrigerante por água com gás',
        'description': 'Que tal trocar o açúcar na bebida por uma opção e refrescante e mais saudável? Cuidado com sucos. Eles devem manter a fibra da fruta para termos benefícios. Prefira smoothies a outros tipos de suco natural.'
      },
    ],
    'Hobbies': [
      {
        'name':'Tirar 30 minutos para um hobby '
      },
    ],
    'Social': [
      {
        'name':'Conversar com um amigo ou colega',
      },
    ],
  };

  Map<String, Set<Map<String, String>>> selectedHabits = {};

  @override
  void initState() {
    super.initState();
    _checkUserHabits();
  }

  Future<void> _checkUserHabits() async {
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? "anonimo";
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

    DocumentSnapshot userDoc = await userDocRef.get();
    Map<String, dynamic> userDocData = userDoc.data() as Map<String, dynamic>;
    if (userDocData.containsKey('habitsSelected') && userDoc['habitsSelected'] == true) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      for (var trail in widget.trails) {
        selectedHabits[trail] = {};
      }
    }
  }

  Future<void> saveSelectedHabitsToFirestore(Map<String, Set<Map<String, String>>> selectedHabits) async {
    try {
      final String uid = FirebaseAuth.instance.currentUser?.uid ?? "anonimo";
      final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

      for (var trail in selectedHabits.keys) {
        final trackDocRef = userDocRef.collection('tracks').doc(trail.toLowerCase());

        for (var habitData in selectedHabits[trail]!) {
          final newHabitDocRef = await trackDocRef.collection('habits').add({
            'name': habitData['name'],
            'description': habitData['description'],
            'createdAt': FieldValue.serverTimestamp(),
            'isCompleted': false
          });

          await newHabitDocRef.update({
            'id': newHabitDocRef.id,
          });
        }
      }

      // Marcar que o usuário já selecionou os hábitos
      await userDocRef.set({'habitsSelected': true}, SetOptions(merge: true));
    } catch (e) {
      print("Erro ao salvar hábitos no Firestore: $e");
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
            SizedBox(height: 30),
            Text(
              'Habitus',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF193339),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
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
                  onPressed: () async {
                    await saveSelectedHabitsToFirestore(selectedHabits);
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
        children: (habitsByTrail[trail] ?? []).map((habit) {
          String habitName = habit['name'] ?? 'Hábito não definido';
          String description = habit['description'] ?? 'Hábito simples, sem descrição adicional.';
          bool isSelected = false;
          if(selectedHabits.isNotEmpty) {
            isSelected =
                selectedHabits[trail]!.any((h) => h['name'] == habitName);
          }
          return ListTile(
            tileColor: isSelected ? Color(0xFF193339) : Color(0xFF448D9C),
            title: Text(
              habitName,
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
                    selectedHabits[trail]!.removeWhere((h) => h['name'] == habitName);
                  } else {
                    selectedHabits[trail]!.add({'name': habitName, 'description': description});
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