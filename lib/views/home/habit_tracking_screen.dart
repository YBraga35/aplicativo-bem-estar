import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class HabitTrackingScreen extends StatelessWidget {
  const HabitTrackingScreen({super.key});

  @override
  State<HabitTrackingScreen> createState() => _HabitTrackingScreenState();
}

class _HabitTrackingScreenState extends State<HabitTrackingScreen> {
  String? _selectedTrack;
  final List<String> _tracks = [
    'Fitness',
    'Sono',
    'Alimentação',
    'Hobbies',
    'Social'
  ];
  List<bool> isCheckedList = List.generate(
      5, (index) => false); // Tamanho da lista = Número de hábitos diários

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
                                    IconButton(
                                        icon: Image.asset(
                                          isCheckedList[index]
                                          ? 'assets/icons/check.png'
                                          : 'assets/icons/uncheck.png', // Altera o ícone com base no estado
                                          ),
                                        onPressed: () {
                                        setState(() {
                                            isCheckedList[index] = !isCheckedList[
                                            index]; // Alterna o estado
                                            });
                                        // Atualizar estado do checkbox
                                        },
                                        ),
                                    }
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
                      items: _tracks.map((String track) {
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
                              ))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione a trilha';
                        }
                        return null;
                      },
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
                                onPressed: () {
                                  Navigator.pop(context);
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
