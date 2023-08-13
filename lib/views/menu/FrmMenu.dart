// ignore: file_names
import 'package:flutter/material.dart';
import 'package:pasantapp/views/feed/FrmFeedPasantia.dart';
import 'package:pasantapp/views/feed/FrmProfile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class FrmBottomMenuBar extends StatefulWidget {
  const FrmBottomMenuBar({super.key});

  @override
  State<FrmBottomMenuBar> createState() => _FrmBottomMenuBarState();
}

class _FrmBottomMenuBarState extends State<FrmBottomMenuBar> {
  final List<Widget> _pages = [
    FeedHome(),    // Página correspondiente al ítem "Home"
    FeedHome(),   // Página correspondiente al ítem "Likes"
    Profile(),  // Página correspondiente al ítem "Search"
    Profile(), // Página correspondiente al ítem "Profile"
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_currentIndex], // Mostrar la página actual
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Cambiar la página al hacer clic en un ítem
            });
          },
          items: _navBarItems,
        ),
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.message),
    title: const Text("OpenAI"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.wallet_travel_outlined),
    title: const Text("Scraping"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: Colors.teal,
  ),
];
