import 'package:flutter/material.dart';
import '/views/starting_trails/habits_selection.dart'; // Importar a nova tela de hábitos
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Trilhas extends StatefulWidget {
  const Trilhas({super.key});

  @override
  _TrilhasState createState() => _TrilhasState();
}

class _TrilhasState extends State<Trilhas> {
  List<bool> selectedButtons = List.generate(5, (index) => false);

  bool anyButtonSelected() {
    return selectedButtons.contains(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E6EA),
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
              'Trilhas',
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
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'Raleway',
                  ),
                  children: [
                    TextSpan(text: 'Selecione no mínimo'),
                    TextSpan(
                      text: ' 1 trilha ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'para visualizar tarefas relacionadas.\n\n'),
                    TextSpan(
                      text: 'Não se preocupe',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ', você pode alterar as informações depois.',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  buildTrailSelection('Fitness', Icons.fitness_center, 0),
                  buildTrailSelection('Sono', Icons.bedtime, 1),
                  buildTrailSelection('Alimentação', Icons.restaurant, 2),
                  buildTrailSelection('Hobbies', Icons.music_note, 3),
                  buildTrailSelection('Social', Icons.groups, 4),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (!anyButtonSelected()) {
                  _showPopup(context);
                } else {
                  List<String> selectedTrilhas = [];
                  if (selectedButtons[0]) selectedTrilhas.add('Fitness');
                  if (selectedButtons[1]) selectedTrilhas.add('Sono');
                  if (selectedButtons[2]) selectedTrilhas.add('Alimentação');
                  if (selectedButtons[3]) selectedTrilhas.add('Hobbies');
                  if (selectedButtons[4]) selectedTrilhas.add('Social');
                  
                  try{
                    await saveTracksFirestore(selectedTrilhas);
                  
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HabitsScreen(trails: selectedTrilhas),
                      ),
                    );
                  } catch (e){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao salvar as trilhas: $e')),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF193339),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> saveTracksFirestore(List<String> tracks) async{
    try {
      final String uid = FirebaseAuth.instance.currentUser?.uid ?? "anônimo";
      
      final tracksRef = FirebaseFirestore.instance.collection('tracks').doc(uid);
      final docSnapshot = await tracksRef.get();
      
      if(!docSnapshot.exists) {
        await tracksRef.set({
          'tracks': tracks,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'userId': uid,
      });
      } else {
        await tracksRef.update({
          'tracks': tracks,
          'updatedAt': FieldValue.serverTimestamp(),
          'userId': uid,
        });
      }
      
      print("Dados salvos com sucesso!");
    } catch (e) {
        print("Erro ao salvar dados no Firestore: $e");
    }
  }

  Widget buildTrailSelection(String trailName, IconData icon, int index) {
    bool isSelected = selectedButtons[index];
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        margin: EdgeInsets.only(top: 10), // Aumenta a margem superior
        child: Card(
          color: isSelected ? Color(0xFF193339) : Color(0xFF448D9C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(vertical: 5),
          elevation: 3,
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: isSelected ? Color(0xFF448D9C) : Colors.white,
            ),
            title: Text(
              trailName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // Corrigido para manter a cor consistente
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            trailing: isSelected
                ? Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent,
                  )
                : null,
            onTap: () {
              setState(() {
                selectedButtons[index] = !isSelected;
              });
            },
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione no mínimo 1 trilha.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}