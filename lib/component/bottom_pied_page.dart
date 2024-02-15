import 'package:djiguiba_music/pages/music_page.dart';
import 'package:djiguiba_music/pages/profil_page.dart';
import 'package:flutter/material.dart';

import '../pages/videos_page.dart';

class BottomPiedPage extends StatefulWidget {
  const BottomPiedPage({super.key});

  @override
  State<BottomPiedPage> createState() => _BottomPiedPageState();
}

class _BottomPiedPageState extends State<BottomPiedPage> {
  // :::::::::::
  int _currentIndex = 0;
  final PidePage = [
    VideoPage(),
    MusicPage(),
    ProfilPage(),
    // Center(
    //   child: Text(
    //     "Profil",
    //     style: TextStyle(fontSize: 50),
    //   ),
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PidePage[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 18.0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          // ::::::::::::
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          iconSize: 20,
          backgroundColor: Theme.of(context).colorScheme.background,
          selectedItemColor: Color.fromARGB(255, 28, 180, 20),
          // selectedFontSize: 20,
          // unselectedFontSize: 15,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video),
              label: "Vidéos",
              // backgroundColor: Colors.blue,
            ),
            // ::::::::::::::
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music_rounded),
              label: "Music",
              // backgroundColor: Colors.blue,
            ),
            // :::::::::::::::::::
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil",
              // backgroundColor: Colors.blue,
            ),
          ],
          // :::::::::::::::
          onTap: (index) {
            setState(
              () {
                _currentIndex = index;
              },
            );
          },
        ),
      ),
    );
  }
}
