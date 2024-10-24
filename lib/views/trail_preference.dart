import  'package:flutter/material.dart';
//importar tela de anterior, possivelmente a tela principal

class Trilhas extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Color(0xFFE0E6EA), // Cor de fundo da tela
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 400,
                  height: 100,
                  ),
                SizedBox(height: 10),
                Text(
                  'Trilhas',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF448D9C),
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Aqui você escolherá qual\nseu progresso ao longo\ndo caminho',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'Raleway'
                  ),
                ),
                SizedBox(height: 30),
                Wrap(
                  spacing: 20.0,
                  runSpacing: 14.0,
                  alignment: WrapAlignment.center,
                  children: [
                    buildElevatedButton(Icons.fitness_center, 'Físico',() {
                      //açaõ especifica
                    }),
                    buildElevatedButton(Icons.bedtime, 'Sono',() {
                      //ação especifica
                    }),
                    buildElevatedButton(Icons.restaurant, 'Nutrição',() {
                      //ação especifica
                    }),
                    buildElevatedButton(Icons.music_note, 'Hobbies',(){
                      //ação especifica
                    }),
                    buildElevatedButton(Icons.groups, 'Social',() {
                      //ação especifica
                    }),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},//passar para próxima tela
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF193339), // Cor do botão
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Continuar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  } 
}
Widget buildElevatedButton(IconData icon, String label, void Function() onPressed) {
  return SizedBox(
    width: 102,
    height: 109,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF448D9C),
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: const Color.fromARGB(255, 5, 54, 48),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontFamily: 'Raleway'
            ),
          ),
        ],
      ),
    ),
  );
}