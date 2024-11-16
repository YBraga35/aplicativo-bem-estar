import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class HabitTrackingScreen extends StatefulWidget {
  const HabitTrackingScreen({super.key});

  @override
  _HabitTrackingScreenState createState() => _HabitTrackingScreenState();
}

class _HabitTrackingScreenState extends State<HabitTrackingScreen> {
  // Lista local de hábitos (simulação)
  List<Map<String, String>> listaDeHabitos = [
    {'titulo': 'Hábito 1', 'trilha': 'Trilha do Hábito'},
    {'titulo': 'Hábito 2', 'trilha': 'Trilha do Hábito'},
    {'titulo': 'Hábito 3', 'trilha': 'Trilha do Hábito'},
    {'titulo': 'Hábito 4', 'trilha': 'Trilha do Hábito'},
    {'titulo': 'Hábito 5', 'trilha': 'Trilha do Hábito'},
  ];

  void deletarHabito(int index) {
    setState(() {
      listaDeHabitos.removeAt(index);
    });
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
                        'Olá, @usuario',
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
                        icon: Icon(Icons.calendar_today,
                            color: Color(0xFF193339)),
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
                            icon: Icon(Icons.filter_list,
                                color: Color(0xFF193339)),
                            onPressed: () {
                              // Filtrar hábitos
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Color(0xFF193339)),
                            onPressed: () {
                              // Adicionar hábito
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
                      itemCount: listaDeHabitos.length, // Número de hábitos do dia
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Mostrar pop-up com detalhes do hábito
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Detalhes do Hábito'),
                                  content:
                                      Text('Descrição e detalhes do hábito.'),
                                  actions: [
                                    TextButton(
                                      child: Text('Fechar'),
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
                              color: isCheckedList[index]
                                  ? Color(0xFFB8FFC7)
                                  : Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      listaDeHabitos[index]['titulo']!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF193339),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      listaDeHabitos[index]['trilha']!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Raleway',
                                        color: Color(0xFF193339),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(                                  
                                      icon: Image.asset(
                                        isCheckedList[index]? 'assets/icons/check.png': 'assets/icons/uncheck.png', // Altera o ícone com base no estado                                   
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isCheckedList[index] = !isCheckedList[index]; // Alterna o estado
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
                                                    deletarHabito(index);
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
          // Adicionar novo hábito
        },
        backgroundColor: const Color(0xFF448D9C),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
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
