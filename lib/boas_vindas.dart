import 'package:flutter/material.dart';

class BoasVindas extends StatelessWidget{
  const BoasVindas({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      
      backgroundColor: const Color(0xFFF1F7F9),
      body: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 200,
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/frutas.png',
            height: 200,
            fit: BoxFit.cover,
          )
        ]
      ),
    );
  }
}