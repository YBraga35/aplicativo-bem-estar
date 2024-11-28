import 'package:flutter/material.dart';

class ReadingAreaScreen extends StatelessWidget {
  ReadingAreaScreen({super.key});

  final List<Map<String, dynamic>> readingTextsList = [
    {
      "title": "Lorem Ipsum",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
    },
    {
      "title": "Lorem Ipsum dolor",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    },
    {
      "title": "Lorem Ipsum dolor sit",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nCurabitur pretium tincidunt lacus. Nulla gravida orci a odio."
    },
    {
      "title": "Lorem Ipsum dolor sit amet",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nCurabitur pretium tincidunt lacus. Nulla gravida orci a odio.\n\nIn vitae eros ac orci dapibus ultricies non et eros."
    },
    {
      "title": "Lorem Ipsum dolor sit amet, consectetur",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\nCurabitur pretium tincidunt lacus. Nulla gravida orci a odio.\n\nIn vitae eros ac orci dapibus ultricies non et eros."
    }
  ];

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
            itemCount: readingTextsList.length,
            itemBuilder: (context, index) {
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
                      readingTextsList[index]["title"],
                      style: TextStyle(
                        height: 1.1,
                        fontSize: 22,
                        fontFamily: "raleway",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF448D9C),
                      ),
                    ),
                    SizedBox(height: 7,),
                    Text(
                      readingTextsList[index]["text"],
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "raleway",
                        color: Color(0xFF193339),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    ]);
  }
}
