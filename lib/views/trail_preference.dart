import  'package:flutter/material.dart';
//importar tela de anterior, possivelmente a tela principal

class Trilhas extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor:const Color(0xFFF1F7F9),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: EdgeInsets.only(top: 1.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 412,
                    height: 135,
                    fit: BoxFit.cover),
                ),
                const SizedBox(height: 16),
                Text(
                  'Trilhas',
                  style: TextStyle(
                    fontSize: 32,
                    color: const Color(0xFF448D9C),
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold)
                ),
                Container(
                  width: 230,
                  height: 100,
                  child: Text(
                  'Aqui você escolherá qual seu progresso ao longo do caminho',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Raleway'
                   ),
                  )
                ),
                const SizedBox(height: 20,),
                GridView.count(
                  crossAxisCount: 2, //número de botões por linha
                  crossAxisSpacing: 10, //espaçamento horizontal
                  mainAxisSpacing: 10, //espaçamento vertical
                  children: [
                    
                  ],)
              ],
            ) 
        ),
      ),
      )
    ); 
  }
  
}

Widget buildButton(){
  return ElevatedButton.styleFrom(
    padding: EdgeInsets.all(16.0),
    primary: Color(0xFF448D9C)

  )
}

