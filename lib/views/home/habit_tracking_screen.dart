import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HabitTrackingScreen extends StatelessWidget {
  const HabitTrackingScreen({super.key});

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
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 120,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 1.0,
                          ),
                          items: [
                            _buildCarouselItem('Trilha 1', '80% de Completiude'),
                            _buildCarouselItem('Trilha 2', '90% de Comprometimento'),
                            _buildCarouselItem('Trilha 3', '70% de Completiude'),
                          ],
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
                      itemCount: 5, // Número de hábitos do dia
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Mostrar pop-up com detalhes do hábito
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Detalhes do Hábito'),
                                  content: Text('Descrição e detalhes do hábito.'),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Título do Hábito',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF193339),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Trilha do Hábito',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Raleway',
                                        color: Color(0xFF193339),
                                      ),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  value: false, // Estado do checkbox
                                  onChanged: (bool? value) {
                                    // Atualizar estado do checkbox
                                  },
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
}