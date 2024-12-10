import 'package:flutter/material.dart';
import 'package:zenjourney/views/home/reading_texts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class ReadingAreaScreen extends StatefulWidget {
  const ReadingAreaScreen({super.key});

  @override
  ReadingAreaScreenState createState() => ReadingAreaScreenState();
}

class ReadingAreaScreenState extends State<ReadingAreaScreen> {
  final readingTexts = ReadingTexts().readingTextsList;

  Future<void> _launchLink(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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
              final referencesList = readingTexts[index]["references"];

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
                    buildBoldTexts("Saúde Mental"),
                    buildTexts(readingTexts[index]["mentalHealth"]),
                    buildBoldTexts("Saúde Física"),
                    buildTexts(readingTexts[index]["physicalHealth"]),
                    buildBoldTexts(readingTexts[index]["stepsTitle"]),
                    buildBoldTexts(stepsList[0]["title"]),
                    buildTexts(stepsList[0]["description"]),
                    buildBoldTexts(stepsList[1]["title"]),
                    buildTexts(stepsList[1]["description"]),
                    buildBoldTexts(stepsList[2]["title"]),
                    buildTexts(stepsList[2]["description"]),
                    buildBoldTexts(stepsList[3]["title"]),
                    buildTexts(stepsList[3]["description"]),
                    buildBoldTexts(stepsList[4]["title"]),
                    buildTexts(stepsList[4]["description"]),
                    buildBoldTexts("Referências"),
                    buildBoldTexts(referencesList[0]["source"]),
                    buildTexts(referencesList[0]["title"]),
                    buildLinkText(referencesList[0]["url"]),
                    buildBoldTexts(referencesList[1]["source"]),
                    buildTexts(referencesList[1]["title"]),
                    buildLinkText(referencesList[1]["url"]),
                    buildTexts(readingTexts[index]["finalText"]),
                  ],
                ),
              );
            }),
      ),
    ]);
  }

  Widget buildBoldTexts(String text) {
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

  Widget buildTexts(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        fontFamily: "raleway",
        color: Color(0xFF193339),
      ),
    );
  }

  Widget buildLinkText(String urlText) {
    final Uri url = Uri.parse(urlText);
    return RichText(
        text: TextSpan(
            text: urlText,
            style: TextStyle(
                fontSize: 17,
                fontFamily: "raleway",
                color: Color(0xFF0000FF),
                decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchLink(url);
              }));
  }
}
