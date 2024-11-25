import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:marquee/marquee.dart';
import 'package:zenjourney/routes/routes.dart';
import 'package:zenjourney/string_extension.dart';

class HabitTrackingScreen extends StatefulWidget {
  const HabitTrackingScreen({super.key});

  @override
  State<HabitTrackingScreen> createState() => _HabitTrackingScreenState();
}

class _HabitTrackingScreenState extends State<HabitTrackingScreen> {
  final firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance; 

  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _habitDescriptionController =
      TextEditingController();
  String? _selectedTrack;

  final List<String> _tracksList = [
    'Fitness',
    'Sono',
    'Alimentação',
    'Hobbies',
    'Social'
  ];

  final List<Map<String, dynamic>> _newHabitsList = [];
  final List<bool> _isCheckedList = [];

  @override
  void initState() {
    super.initState();
    fetchHabitsFromFirestore();
  }

  void deletarHabito(String trackName, String habitID, int index) async{
    final userUID = FirebaseAuth.instance.currentUser?.uid;
    if(userUID != null){
      try{
        await FirebaseFirestore.instance
        .collection('users')
        .doc(userUID)
        .collection('tracks')
        .doc(trackName)
        .collection('habits')
        .doc(habitID)
        .delete();

        
        setState(() {
          _newHabitsList.removeAt(index);
        });
      }catch(e){
        print("Erro ao deletar hábito: $e");
      }
    } else {
      setState(() {
        _newHabitsList.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe0e6ea),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Parte Superior
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF448D9C),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, ${FirebaseAuth.instance.currentUser!.displayName}',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Mensagem reflexiva do dia para saúde mental.',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Raleway',
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dias de Streak',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF193339),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '10 dias',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF448D9C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: CarouselSlider.builder(
                          slideBuilder: (index) {
                            return _buildCarouselItem(
                              'Trilha ${index + 1}',
                              _getSubtitle(index),
                            );
                          },
                          unlimitedMode: true,
                          slideTransform: CubeTransform(),
                          slideIndicator: CircularSlideIndicator(
                            padding: EdgeInsets.only(bottom: 16),
                          ),
                          itemCount: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Parte Inferior
            Expanded(
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.calendar_today, color: Color(0xFF193339)),
                        onPressed: () {
                          // Navegar para o calendário
                        },
                      ),
                      Text(
                        'Goals faltantes para hoje: 3',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Raleway',
                          color: Color(0xFF193339),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.filter_list, color: Color(0xFF193339)),
                            onPressed: () {
                              // Filtrar hábitos
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Listagem de Hábitos
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          _newHabitsList.length, // Número de hábitos do dia
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Mostrar pop-up com detalhes do hábito
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Detalhes do Hábito'),
                                  content: Text(
                                      _newHabitsList[index]['description']),
                                  actions: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.editHabit,
                                          arguments: [
                                            _newHabitsList[index]['name'],
                                            _newHabitsList[index]['description'],
                                            _newHabitsList[index]['track'],
                                          ]
                                        );
                                      },
                                      icon: Icon(Icons.edit, color: Color(0xFF193339)),
                                    ),
                                    TextButton(
                                      child: Icon(Icons.close, color: Color(0xFF193339)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),                             
                              color: _isCheckedList[index]
                                  ? Color(0xFFB8FFC7)
                                  : Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      SizedBox(
                                        height: 20,
                                        child : Marquee(
                                          text: _newHabitsList[index]['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF193339),
                                          ),
                                          scrollAxis: Axis.horizontal, // Rolagem horizontal
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          blankSpace: 25.0, // Espaço ao final do texto
                                          velocity: 30.0, // Velocidade da rolagem
                                          pauseAfterRound: Duration(seconds: 4), // Pausa após uma rodada
                                          startPadding: 10.0, // Espaço inicial
                                        ),
                                      ),
                                    const SizedBox(height: 5),
                                    Text(
                                      _newHabitsList[index]['track'].toString().toCapitalized,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Raleway',
                                        color: Color(0xFF193339),
                                      ),
                                    ),
                                  ],
                                ),
                                ),
                                Row(
                                  children: [
                                    IconButton(                                  
                                      icon: Image.asset(
                                        _isCheckedList[index]? 'assets/icons/check.png': 'assets/icons/uncheck.png', // Altera o ícone com base no estado                                   
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isCheckedList[index] = !_isCheckedList[index]; // Alterna o estado
                                        });
                                        // Atualizar estado do checkbox
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Color(0xFF193339)),
                                      onPressed: () {
                                        // Exibir mensagem de confirmação antes de deletar
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Confirmar Deleção"),
                                              content: Text("Você tem certeza que deseja deletar este hábito?"),
                                              actions: [
                                                TextButton(
                                                  child: Text("Cancelar"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("Deletar"),
                                                  onPressed: () {
                                                    final trackName = _newHabitsList[index]['track'];
                                                    final habitID = _newHabitsList[index]['id'];
                                                    deletarHabito(trackName, habitID, index); //deleção de hábtios sugeridos com vinculação firestore
                                                    
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createHabit(context);
          // Adicionar novo hábito
        },
        backgroundColor: const Color(0xFF448D9C),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> fetchHabitsFromFirestore() async {
  try {
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? "anonymous";
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

    // Limpa a lista local antes de carregar os novos dados
    setState(() {
      _newHabitsList.clear();
      _isCheckedList.clear();
    });

    // Para cada trilha, busque os hábitos sugeridos
    final tracksSnapshot = await userDocRef.collection('tracks').get();
    for (var trackDoc in tracksSnapshot.docs) {
      final trackName = trackDoc.id; // Nome da trilha
      final habitsSnapshot = await trackDoc.reference.collection('habits').get();
      for (var habitDoc in habitsSnapshot.docs) {
        final data = habitDoc.data();
        _newHabitsList.add({
          'name': data['name'], // Nome do hábito
          'track': trackName,    // Nome da trilha
          'description': data['description'] ?? 'Sem descrição', // Descrição
          'id': data['id']
        });
        _isCheckedList.add(false); // Adiciona o estado inicial (não concluído)
      }
    }
    setState(() {}); // Atualiza a tela com os dados carregados
  } catch (e) {
    print("Erro ao carregar hábitos do Firestore: $e");
  }
}

  void _createHabit(BuildContext context) {
    setState(() {
      _selectedTrack = null;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Novo Hábito',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF448D9C),
                      ),
                    ),
                    Text(
                      'Crie seus próprios hábitos para ter uma experiência personalizada',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        color: Color(0xFF193339),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Hábito',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18,
                            color: Color(0xFF193339),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        )),
                    TextField(
                      controller: _habitNameController,
                      cursorColor: Color(0xFF193339),
                      inputFormatters: [LengthLimitingTextInputFormatter(45)],
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Nome do Hábito',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF193339), width: 2))),
                    ),
                    SizedBox(height: 15),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Trilha',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18,
                            color: Color(0xFF193339),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        )),
                    DropdownButtonFormField<String>(
                      value: _selectedTrack,
                      hint: const Text('Selecione a trilha'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTrack = newValue;
                        });
                      },
                      items: _tracksList.map((String track) {
                        return DropdownMenuItem<String>(
                          value: track,
                          child: Text(track),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Color(0xFF193339),
                                width: 2,
                              )))
                    ),
                    SizedBox(height: 15),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Descrição',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 18,
                            color: Color(0xFF193339),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        )),
                    TextField(
                      controller: _habitDescriptionController,
                      maxLines: 4,
                      cursorColor: Color(0xFF193339),
                      inputFormatters: [LengthLimitingTextInputFormatter(116)],
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                  color: Color(0xFF193339), width: 2))),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF193339),
                                    fixedSize: Size(125, 50)),
                                child: Text('Voltar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        fontSize: 18)))),
                        Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (await addHabit(
                                      _habitNameController.text,
                                      _selectedTrack,
                                      _habitDescriptionController.text)) {
                                    Navigator.pop(context);
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Campos não preenchidos",
                                      //toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Color(0xFF193339),
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF448D9C),
                                    fixedSize: Size(125, 50)),
                                child: Text('Salvar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        fontSize: 18))))
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  // Validação provisória feita apenas para não fechar o programa
  Future<bool> addHabit(habitName, habitTrack, habitDescription) async {
    String name = habitName.trim();
    String description = habitDescription.trim();

    if (name.isEmpty || habitTrack == null || description.isEmpty) {
      return false;
    }

    User? currentUser = firebaseAuth.currentUser;
    DocumentReference trackRef = firestore.collection('users').doc(currentUser!.uid).collection('tracks').doc(habitTrack.toLowerCase());
    DocumentReference habitDoc = trackRef.collection('habits').doc();
    String habitID = habitDoc.id;

    await habitDoc.set({
      'name':habitName,
      'description':habitDescription,
      'createdAt':Timestamp.now(),
      'updatedAt':Timestamp.now(),
      'id': habitID,
    });
    fetchHabitsFromFirestore();
    _habitNameController.clear();
    _habitDescriptionController.clear();
    return true;
  }

  static Widget _buildCarouselItem(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF448D9C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Raleway',
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  static String _getSubtitle(int index) {
    switch (index) {
      case 0:
        return '80% de Completiude';
      case 1:
        return '90% de Comprometimento';
      case 2:
        return '70% de Completiude';
      default:
        return '';
    }
  }
}
