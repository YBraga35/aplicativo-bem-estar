// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditHabitView extends StatefulWidget {
  final String habitName;
  final String habitDescription;
  final String habitTrack;

  const EditHabitView(
      {super.key,
      required this.habitName,
      required this.habitDescription,
      required this.habitTrack
      }
      );

  @override
  EditHabitViewState createState() => EditHabitViewState();
}

class EditHabitViewState extends State<EditHabitView> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _trackController;
  String? _selectedTrack;
  final firestore = FirebaseFirestore.instance;
  final List<String> _tracksList = [
    'Fitness',
    'Sono',
    'Alimentação',
    'Hobbies',
    'Social'
  ];
  
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.habitName);
    _descriptionController = TextEditingController(text: widget.habitDescription);
    _trackController = TextEditingController(text: widget.habitTrack);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _trackController.dispose();
    super.dispose();
  }

  void _saveHabit(String habitName, String habitTrack, String habitDescription) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await firestore
            .collection('users')
            .doc(user.uid)
            .collection('habits')
            .doc(widget.habitName)
            .update({
          'name': _nameController.text.trim(),
          'track': _selectedTrack,
          'description': _descriptionController.text.trim(),
        });
        Fluttertoast.showToast(
          msg: "Hábito atualizado com sucesso",
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Color(0xFF193339),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
      msg: "Erro ao atualizar hábito: $e",
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Color(0xFF193339),
      textColor: Colors.white,
      fontSize: 16.0,
      );
    }

    print('Hábito salvo: ${_nameController.text}, ${_descriptionController.text}, ${_selectedTrack}');
    Navigator.pop(context);
  }

  @override

  Widget build(BuildContext context) {
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
                  'Editar Hábito',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF448D9C),
                  ),
                ),
                Text(
                  'Modifique seu hábito para uma experiência personalizada',
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
                  controller: _nameController,
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
                          borderSide:
                              BorderSide(color: Color(0xFF193339), width: 2))),
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
                        _selectedTrack = newValue!;
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
                            )))),
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
                  controller: _descriptionController,
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
                          borderSide:
                              BorderSide(color: Color(0xFF193339), width: 2))),
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
                              if (_nameController.text.isEmpty ||
                                  _selectedTrack == null ||
                                  _descriptionController.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: "Campos não preenchidos",
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Color(0xFF193339),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                _saveHabit(
                                  _nameController.text,
                                  _trackController.text,
                                  _descriptionController.text,
                                );
                                Navigator.pop(context);
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
  }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Editar Hábito'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () => _saveHabit(
//               widget.habitName, 
//               widget.habitTrack,
//               widget.habitDescription
//               ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Título'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'Descrição'),
//               maxLines: 3,
//             ),
//             SizedBox(height: 16.0),
//             DropdownButtonFormField<String>(
//               value: _selectedTrack,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                       borderSide: BorderSide(
//                         color: Color(0xFF193339),
//                         width: 2,
//                       )
//                   )
//               ),
//               items: _tracksList.map((String track) {
//                 return DropdownMenuItem<String>(
//                   value: track,
//                   child: Text(track),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedTrack = newValue;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
}