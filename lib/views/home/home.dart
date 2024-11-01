import 'package:flutter/material.dart';
import 'preferences_screen.dart';
import 'suggested_tasks_screen.dart';
import 'habit_tracking_screen.dart';
import 'reading_area_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2; // Default to the habit tracking screen

  static final List<Widget> _widgetOptions = <Widget>[
    PreferencesScreen(),
    SuggestedTasksScreen(),
    HabitTrackingScreen(),
    ReadingAreaScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe0e6ea),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1), // Branco acinzentado
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _buildIcon('assets/icons/preferences.png', 0),
              label: 'Preferências',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon('assets/icons/tasks.png', 1),
              label: 'Tarefas',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon('assets/icons/habits.png', 2),
              label: 'Hábitos',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon('assets/icons/reading.png', 3),
              label: 'Leitura',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon('assets/icons/profile.png', 4),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF006400),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w500,
          ),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildIcon(String assetPath, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetPath),
          colorFilter: _selectedIndex == index
              ? const ColorFilter.mode(Color(0xFF006400), BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }
}