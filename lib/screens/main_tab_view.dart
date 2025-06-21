import 'package:flutter/material.dart';
import 'package:finx_v1/screens/home_screen.dart';
import 'package:finx_v1/screens/chatbox_screen.dart';
import 'package:finx_v1/screens/profile_screen.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  MainTabViewState createState() => MainTabViewState();
}

class MainTabViewState extends State<MainTabView> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [HomeScreen(), ChatboxScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
