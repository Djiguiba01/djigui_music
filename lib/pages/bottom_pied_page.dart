import 'package:djiguiba_music/consts/colors.dart';
import 'package:djiguiba_music/pages/music_page.dart';
import 'package:djiguiba_music/pages/profil_page.dart';
import 'package:djiguiba_music/pages/videos_page.dart';
import 'package:flutter/material.dart';

class BottomPiedPage extends StatefulWidget {
  const BottomPiedPage({super.key});

  @override
  State<BottomPiedPage> createState() => _BottomPiedPageState();
}

class _BottomPiedPageState extends State<BottomPiedPage> {
  // :::::::::::
  int _currentIndex = 0;
  final PidePage = [
    // VideoPage(),
    VideoListPage(),
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
      // backgroundColor: bgDarkColor,
      body: PidePage[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.20),
              blurRadius: 18.0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          // ::::::::::::
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          iconSize: 20,
          // backgroundColor: Theme.of(context).colorScheme.background,
          backgroundColor: bgDarkColor,
          unselectedItemColor: whiteColor,
          selectedItemColor: Color.fromARGB(255, 28, 180, 20),

          // selectedFontSize: 20,
          // unselectedFontSize: 15,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.ondemand_video,
              ),
              label: "Vidéos",
            ),
            // ::::::::::::::
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_music_rounded,
              ),
              label: "Music",
            ),
            // :::::::::::::::::::
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profil",
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
