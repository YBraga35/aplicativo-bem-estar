import 'package:flutter/material.dart';
class ReadingAreaScreen extends StatelessWidget {
  const ReadingAreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: const Text(
            'Área de Leitura',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Color(0xFF193339),
            ),
          ),
        ),
        Center(
          child: SizedBox(
              height: 75,
              width: 290,
              child: const Text(
                'Leia artigos, informações e curiosidades, todas com embasamento científico',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Raleway',
                  color: Color(0xFF193339),
                ),
                textAlign: TextAlign.center,
              )),
        ),
        const SizedBox(height: 15),
        Container(
          height: 35,
          width: 270,
          decoration: BoxDecoration(
            color: Color(0xFF193339),
          ),
          child: const Center(
            child: Text('Artigos',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                  fontFamily: 'Raleway',
                )),
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(
                    5,
                    (index) => Column(children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                blurStyle: BlurStyle.normal,
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(-5, 5),
                              )
                            ]),
                            margin: EdgeInsets.only(
                                left: 15.0, right: 35.0, top: 5.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(),
                              ),
                              child: Icon(
                                Icons.menu_book,
                                size: 50,
                                color: Color(0xFF448D9C),),
                            ),
                          ),
                          Center(
                            child: Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(left: 15.0, right: 35.0, top:5.0),
                                child: Text(
                                  'Caminhos verdes e a saúde mental',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 16,
                                      color: Color(0xFF193339)),
                                  textAlign: TextAlign.center,
                                )),
                          )
                        ])))),
        const SizedBox(height: 10),
        Container(
          height: 35,
          width: 270,
          decoration: BoxDecoration(
            color: Color(0xFF193339),
          ),
          child: const Center(
            child: Text('Informações',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                  fontFamily: 'Raleway',
                )),
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(
                    5,
                    (index) => Column(
                      children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                blurStyle: BlurStyle.normal,
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(-5, 5),
                              )
                            ]),
                            margin: EdgeInsets.only(
                                left: 15.0, right: 35.0, top: 5.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(),
                              ),
                              child: Icon(
                                Icons.menu_book,
                                size: 50,
                                color: Color(0xFF448D9C),)
                            ),
                          ),
                          Center(
                            child: Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(left: 15.0, right: 35.0, top: 5.0),
                                child: Text(
                                  'Caminhos verdes e a saúde mental',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 16,
                                      color: Color(0xFF193339)),
                                  textAlign: TextAlign.center,
                                )),
                          )
                        ])))),
      ],
    ));
  }
}