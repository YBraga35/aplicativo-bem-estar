import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideContent {
  final String title;
  final String content;
  final String imagePath;
  SlideContent(this.title, this.content, this.imagePath);
}

class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideContent> _slides = [
    SlideContent(
      'Missão e Valores',
      'O Habitus é um aplicativo dedicado a ajudar você a alcançar uma vida melhor através de pequenas mudanças diárias. Nossa missão é guiá-lo(a) em uma jornada de autodescoberta e bem-estar, fornecendo ferramentas e recursos para melhorar sua saúde mental, física e emocional.',
      'assets/icons/mental.svg',
    ),
    SlideContent(
      'Propósito',
      'Acreditamos que pequenas mudanças podem ter um grande impacto ao longo do tempo, e estamos aqui para apoiar você em cada passo dessa jornada.',
      'assets/icons/path.svg',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E6EA),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    return _buildSlide(
                      _slides[index],
                      isLastSlide: index == _slides.length - 1,
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _slides.length,
                    (index) => _buildDot(index),
                  ),
                ),
              ),
            ],
          ),
          if (_currentPage == _slides.length - 1)
            Positioned(
              bottom: 30,
              right: 30,
              child: _buildArrowButton(context),
            ),
        ],
      ),
    );
  }

  Widget _buildSlide(SlideContent slide, {bool isLastSlide = false}) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Habitus',
              style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF20434a),
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            if (slide.title == 'Missão e Valores') ...[
              _buildSectionTitle(slide.title),
              const SizedBox(height: 10),
              _buildSectionContent(slide.content),
              const SizedBox(height: 2),
              SvgPicture.asset(
                slide.imagePath,
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.contain,
                semanticsLabel: slide.title,
                placeholderBuilder: (BuildContext context) =>
                    const CircularProgressIndicator(),
              ),
            ] else ...[
              _buildSectionTitle(slide.title),
              const SizedBox(height: 10),
              _buildSectionContent(slide.content),
              const SizedBox(height: 10),
              SvgPicture.asset(
                slide.imagePath,
                width: MediaQuery.of(context).size.width * 0.10,
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.contain,
                semanticsLabel: slide.title,
                placeholderBuilder: (BuildContext context) =>
                    const CircularProgressIndicator(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildArrowButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF448D9C),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.authenticate),
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? const Color(0xFF448D9C)
            : const Color(0xFF448D9C).withOpacity(0.4),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.raleway(
        textStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Color(0xFF20434a),
        ),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSectionContent(String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Raleway',
            color: Color(0xFF193339),
            height: 1.6,
          ),
          children: _buildRichText(content),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  List<TextSpan> _buildRichText(String content) {
    List<String> boldWords = [
      'Habitus',
      'aplicativo',
      'missão',
      'autodescoberta',
      'bem-estar',
      'saúde mental',
      'física',
      'emocional',
      'propósito',
      'ambiente',
      'saudável',
      'sustentável',
      'mudanças',
      'impacto',
      'jornada',
    ];

    List<TextSpan> spans = [];
    String remaining = content;

    while (remaining.isNotEmpty) {
      int nearestIndex = remaining.length;
      String? nearestWord;
      for (String word in boldWords) {
        int index = remaining.toLowerCase().indexOf(word.toLowerCase());
        if (index != -1 && index < nearestIndex) {
          nearestIndex = index;
          nearestWord = word;
        }
      }

      if (nearestWord == null) {
        spans.add(TextSpan(text: remaining));
        break;
      }

      if (nearestIndex > 0) {
        spans.add(TextSpan(text: remaining.substring(0, nearestIndex)));
      }

      int wordLength = nearestWord.length;
      spans.add(
        TextSpan(
          text: remaining.substring(nearestIndex, nearestIndex + wordLength),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      remaining = remaining.substring(nearestIndex + wordLength);
    }

    return spans;
  }
}