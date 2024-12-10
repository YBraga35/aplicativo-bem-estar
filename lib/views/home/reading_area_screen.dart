import 'package:flutter/material.dart';
import 'package:zenjourney/views/home/reading_texts.dart';

class ReadingAreaScreen extends StatelessWidget {
  ReadingAreaScreen({super.key});

  final readingTexts = ReadingTexts().readingTextsList;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              'Leia informações e curiosidades, todas com embasamento científico',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Raleway',
                color: Color(0xFF193339),
              ),
              textAlign: TextAlign.center,
            )),
      ),
      SizedBox(
        height: 7.5,
      ),
      Expanded(
        child: ListView.builder(
            itemCount: readingTexts.length,
            itemBuilder: (context, index) {
              final stepsList = readingTexts[index]["stepsList"];

              return Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 7.5),
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 7.5, bottom: 7.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      readingTexts[index]["title"],
                      style: TextStyle(
                        height: 1.1,
                        fontSize: 22,
                        fontFamily: "raleway",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF448D9C),
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    buildBoldTexts(context, "Saúde Mental"),
                    buildTexts(context, readingTexts[index]["mentalHealth"]),
                    buildBoldTexts(context, "Saúde Física"),
                    buildTexts(context, readingTexts[index]["physicalHealth"]),
                    buildBoldTexts(context, readingTexts[index]["stepsTitle"]),
                    buildBoldTexts(context, stepsList[0]["title"]),
                    buildTexts(context, stepsList[0]["description"]),
                    buildBoldTexts(context, stepsList[1]["title"]),
                    buildTexts(context, stepsList[1]["description"]),
                    buildBoldTexts(context, stepsList[2]["title"]),
                    buildTexts(context, stepsList[2]["description"]),
                    buildBoldTexts(context, stepsList[3]["title"]),
                    buildTexts(context, stepsList[3]["description"]),
                    buildBoldTexts(context, stepsList[4]["title"]),
                    buildTexts(context, stepsList[4]["description"]),
                    buildBoldTexts(context, "Referências"),
                    buildTexts(context, readingTexts[index]["finalText"]),
                  ],
                ),
              );
            }),
      ),
    ]);
  }

  Widget buildBoldTexts(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: "raleway",
        color: Color(0xFF193339),
      ),
    );
  }

  Widget buildTexts(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        fontFamily: "raleway",
        color: Color(0xFF193339),
      ),
    );
  }
}
