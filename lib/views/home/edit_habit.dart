// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditHabitView extends StatefulWidget {
  final String habitName;
  final String habitDescription;
  final String habitTrack;

  EditHabitView(
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
    _selectedTrack = null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _trackController.dispose();
    super.dispose();
  }

  void _saveHabit(String habitName, String habitTrack, String habitDescription) async {
    print('Hábito salvo: ${_nameController.text}, ${_descriptionController.text}, ${_trackController.text}');

    await firestore.collection('habits').doc(habitName).set({
      'name': _nameController.text,
      'description': _descriptionController.text,
      'track': _trackController.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Hábito'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveHabit(
              widget.habitName, 
              widget.habitTrack,
              widget.habitDescription
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedTrack,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Color(0xFF193339),
                        width: 2,
                      )
                  )
              ),
              items: _tracksList.map((String track) {
                return DropdownMenuItem<String>(
                  value: track,
                  child: Text(track),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTrack = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}